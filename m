Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbzFY4k9dzDqjm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 15:12:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v2 2/5] powerpc: pseries: vio: match parent nodes with
 of_find_node_by_path
In-Reply-To: <20170821151651.25096-3-robh@kernel.org>
References: <20170821151651.25096-1-robh@kernel.org>
 <20170821151651.25096-3-robh@kernel.org>
Date: Tue, 22 Aug 2017 15:12:17 +1000
Message-ID: <87fuckb2z2.fsf@concordia.ellerman.id.au>
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

Rob Herring <robh@kernel.org> writes:

> In preparation to remove the full path from device_node.full_name, use
> of_find_node_by_path instead of open coding with strcmp.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> v2:
> - rebased to linux-next and removed spurious change fro patch 1.
>
>  arch/powerpc/platforms/pseries/vio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
> index aa5ca74316fa..5754572deb23 100644
> --- a/arch/powerpc/platforms/pseries/vio.c
> +++ b/arch/powerpc/platforms/pseries/vio.c
> @@ -1357,9 +1357,9 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
>  	 */
>  	parent_node = of_get_parent(of_node);
>  	if (parent_node) {
> -		if (!strcmp(parent_node->full_name, "/ibm,platform-facilities"))
> +		if (parent_node == of_find_node_by_path("/ibm,platform-facilities"))
>  			family = PFO;
> -		else if (!strcmp(parent_node->full_name, "/vdevice"))
> +		else if (parent_node == of_find_node_by_path("/vdevice"))
>  			family = VDEVICE;

This leaks references to the looked up nodes.

Both these nodes are defined in PAPR (our hypervisor spec), and both of
them must have a device_type, either "ibm,platform-facilities" or
"vdevice".

Looking at the commit that added the code I don't see any particular
reason it used the comparison against full_name, rather than using the
device_type.

So I'm inclined to do this instead:

diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 8a47f168476b..f26f906e6021 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -1357,9 +1357,9 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 	 */
 	parent_node = of_get_parent(of_node);
 	if (parent_node) {
-		if (!strcmp(parent_node->full_name, "/ibm,platform-facilities"))
+		if (!strcmp(parent_node->type, "ibm,platform-facilities"))
 			family = PFO;
-		else if (!strcmp(parent_node->full_name, "/vdevice"))
+		else if (!strcmp(parent_node->type, "vdevice"))
 			family = VDEVICE;
 		else {
 			pr_warn("%s: parent(%s) of %s not recognized.\n",


I've checked both Qemu and kvmtool add the device_type, and I'm fairly
confident that PowerVM does too. Anyway I'll test it on all the machines
I can find.

cheers
