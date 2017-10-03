Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5tvF1VGczDqhh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 20:26:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Laight <David.Laight@aculab.com>,
 nfont@linux.vnet.ibm.com <nfont@linux.vnet.ibm.com>,
 tyreld@linux.vnet.ibm.com <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/5] powerpc: pseries: only store the device node
 basename in full_name
In-Reply-To: <20170821151651.25096-5-robh@kernel.org>
References: <20170821151651.25096-1-robh@kernel.org>
 <20170821151651.25096-5-robh@kernel.org>
Date: Tue, 03 Oct 2017 20:26:16 +1100
Message-ID: <87tvzgd1l3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Rob,

Unfortunately this one has a bug, which only showed up after some stress
testing.

Rob Herring <robh@kernel.org> writes:
> With dependencies on full_name containing the entire device node path
> removed, stop storing the full_name in nodes created by
> dlpar_configure_connector() and pSeries_reconfig_add_node().
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> v2:
> - Rework dlpar_parse_cc_node() to a single allocation and strcpy instead
>   of kasprintf
>   
>  arch/powerpc/platforms/pseries/dlpar.c    | 30 +++++++-----------------------
>  arch/powerpc/platforms/pseries/reconfig.c |  2 +-
>  2 files changed, 8 insertions(+), 24 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 783f36364690..31a0615aeea1 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -75,28 +75,17 @@ static struct property *dlpar_parse_cc_property(struct cc_workarea *ccwa)
>  	return prop;
>  }
>  
> -static struct device_node *dlpar_parse_cc_node(struct cc_workarea *ccwa,
> -					       const char *path)
> +static struct device_node *(dlpar_parse_cc_node)(struct cc_workarea *ccwa)
>  {
>  	struct device_node *dn;
> -	char *name;
> -
> -	/* If parent node path is "/" advance path to NULL terminator to
> -	 * prevent double leading slashs in full_name.
> -	 */
> -	if (!path[1])
> -		path++;
> +	const char *name = (const char *)ccwa + be32_to_cpu(ccwa->name_offset);
>  
> -	dn = kzalloc(sizeof(*dn), GFP_KERNEL);
> +	dn = kzalloc(sizeof(*dn) + strlen(name) + 1, GFP_KERNEL);
>  	if (!dn)
>  		return NULL;
>  
> -	name = (char *)ccwa + be32_to_cpu(ccwa->name_offset);
> -	dn->full_name = kasprintf(GFP_KERNEL, "%s/%s", path, name);
> -	if (!dn->full_name) {
> -		kfree(dn);
> -		return NULL;
> -	}
> +	dn->full_name = (char *)(dn + 1);
> +	strcpy((char *)dn->full_name, name);

Allocating the full_name on the tail of the struct this way breaks the
call to kfree(node->full_name) in of_node_release().

eg:


[  322.543581] Freeing node->full_name c0000007f4ed4090
[  322.543583] =============================================================================
[  322.543586] BUG kmalloc-192 (Tainted: G    B          ): Invalid object pointer 0xc0000007f4ed4090
[  322.543588] -----------------------------------------------------------------------------

[  322.543592] INFO: Slab 0xf000000001fd3b40 objects=292 used=72 fp=0xc0000007f4ed41a8 flags=0x13ffff800000101
[  322.543595] CPU: 40 PID: 5 Comm: kworker/u192:0 Tainted: G    B           4.14.0-rc2-gcc-6.3.1-next-20170929-dirty #429
[  322.543600] Workqueue: pseries hotplug workque pseries_hp_work_fn
[  322.543602] Call Trace:
[  322.543605] [c0000003f769f660] [c000000000a6b710] dump_stack+0xb0/0xf0 (unreliable)
[  322.543609] [c0000003f769f6a0] [c00000000032cd5c] slab_err+0x9c/0xc0
[  322.543612] [c0000003f769f790] [c00000000033440c] free_debug_processing+0x19c/0x490
[  322.543615] [c0000003f769f860] [c0000000003349fc] __slab_free+0x2fc/0x4b0
[  322.543619] [c0000003f769f960] [c0000000008f2484] of_node_release+0xe4/0x1a0
[  322.543622] [c0000003f769fa00] [c000000000a71c04] kobject_put+0xd4/0x160
[  322.543625] [c0000003f769fa80] [c0000000008f10c4] of_node_put+0x34/0x50
[  322.543628] [c0000003f769fab0] [c0000000000c0248] dlpar_cpu_remove_by_index+0x108/0x130
[  322.543631] [c0000003f769fb40] [c0000000000c166c] dlpar_cpu+0x27c/0x510
[  322.543634] [c0000003f769fbf0] [c0000000000bb2d0] handle_dlpar_errorlog+0xc0/0x160
[  322.543638] [c0000003f769fc60] [c0000000000bb3ac] pseries_hp_work_fn+0x3c/0xa0
[  322.543641] [c0000003f769fc90] [c00000000012200c] process_one_work+0x2bc/0x560
[  322.543645] [c0000003f769fd20] [c000000000122348] worker_thread+0x98/0x5d0
[  322.543648] [c0000003f769fdc0] [c00000000012b4e4] kthread+0x164/0x1b0
[  322.543651] [c0000003f769fe30] [c00000000000bae0] ret_from_kernel_thread+0x5c/0x7c


The obvious fix is just to allocate it separately as before, eg ~=:

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 267b01e30ac0..8617d7e28bf7 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -80,11 +80,16 @@ static struct device_node *dlpar_parse_cc_node(struct cc_workarea *ccwa)
 	struct device_node *dn;
 	const char *name = (const char *)ccwa + be32_to_cpu(ccwa->name_offset);
 
-	dn = kzalloc(sizeof(*dn) + strlen(name) + 1, GFP_KERNEL);
+	dn = kzalloc(sizeof(*dn), GFP_KERNEL);
 	if (!dn)
 		return NULL;
 
-	dn->full_name = (char *)(dn + 1);
+	dn->full_name = kzalloc(strlen(name) + 1, GFP_KERNEL);
+	if (!dn->full_name) {
+		kfree(dn);
+		return NULL;
+	}
+
 	strcpy((char *)dn->full_name, name);
 
 	of_node_set_flag(dn, OF_DYNAMIC);


cheers
