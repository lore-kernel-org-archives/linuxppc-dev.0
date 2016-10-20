Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szvV320x5zDrPL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 14:31:07 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id i85so4151819pfa.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 20:31:07 -0700 (PDT)
Subject: Re: [PATCH v4 3/5] powerpc/mm: allow memory hotplug into a memoryless
 node
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <1475778995-1420-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1475778995-1420-4-git-send-email-arbab@linux.vnet.ibm.com>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Tang Chen <tangchen@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-mm@kvack.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <872f253d-8a55-246c-2be0-636a588e2dd0@gmail.com>
Date: Thu, 20 Oct 2016 14:30:42 +1100
MIME-Version: 1.0
In-Reply-To: <1475778995-1420-4-git-send-email-arbab@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/10/16 05:36, Reza Arbab wrote:
> Remove the check which prevents us from hotplugging into an empty node.
> 
> This limitation has been questioned before [1], and judging by the
> response, there doesn't seem to be a reason we can't remove it. No issues
> have been found in light testing.
> 
> [1] http://lkml.kernel.org/r/CAGZKiBrmkSa1yyhbf5hwGxubcjsE5SmkSMY4tpANERMe2UG4bg@mail.gmail.com
>     http://lkml.kernel.org/r/20160511215051.GF22115@arbab-laptop.austin.ibm.com
> 
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/numa.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 75b9cd6..d7ac419 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1121,7 +1121,7 @@ static int hot_add_node_scn_to_nid(unsigned long scn_addr)
>  int hot_add_scn_to_nid(unsigned long scn_addr)
>  {
>  	struct device_node *memory = NULL;
> -	int nid, found = 0;
> +	int nid;
>  
>  	if (!numa_enabled || (min_common_depth < 0))
>  		return first_online_node;
> @@ -1137,17 +1137,6 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
>  	if (nid < 0 || !node_online(nid))
>  		nid = first_online_node;
>  
> -	if (NODE_DATA(nid)->node_spanned_pages)
> -		return nid;
> -
> -	for_each_online_node(nid) {
> -		if (NODE_DATA(nid)->node_spanned_pages) {
> -			found = 1;
> -			break;
> -		}
> -	}
> -
> -	BUG_ON(!found);
>  	return nid;

FYI, these checks were temporary to begin with

I found this in git history

b226e462124522f2f23153daff31c311729dfa2f (powerpc: don't add memory to empty node/zone)

Balbir Singh.
