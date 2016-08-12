Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9SXF0pCWzDqdG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 11:50:53 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id cf3so607462pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 18:50:53 -0700 (PDT)
Subject: Re: [PATCH 3/4] powerpc/mm: allow memory hotplug into a memoryless
 node
To: Reza Arbab <arbab@linux.vnet.ibm.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>, Bharata B Rao
 <bharata@linux.vnet.ibm.com>, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1470680843-28702-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1470680843-28702-4-git-send-email-arbab@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <7d943111-d243-ffb3-ff5f-6d712c268e67@gmail.com>
Date: Fri, 12 Aug 2016 11:50:43 +1000
MIME-Version: 1.0
In-Reply-To: <1470680843-28702-4-git-send-email-arbab@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/08/16 04:27, Reza Arbab wrote:
> Remove the check which prevents us from hotplugging into an empty node.
> 
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/numa.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 80d067d..bc70c4f 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1127,7 +1127,7 @@ static int hot_add_node_scn_to_nid(unsigned long scn_addr)
>  int hot_add_scn_to_nid(unsigned long scn_addr)
>  {
>  	struct device_node *memory = NULL;
> -	int nid, found = 0;
> +	int nid;
>  

Do we want to do this only for ibm,hotplug-aperture compatible ranges?

I'm OK either ways

Acked-by: Balbir Singh <bsingharora@gmail.com>
