Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcWt06Xs8zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 21:42:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, paulus@samba.org,
 nfont@linux.vnet.ibm.com, sahilmehta17@gmail.com, jallen@linux.vnet.ibm.com,
 mwb@linux.vnet.ibm.com, alastair@d-silva.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/hotplug-mem: Fix aa_index match bug for hotplug
In-Reply-To: <b284d6be-ff37-4e5c-7357-446b4e1ea8ad@linux.vnet.ibm.com>
References: <b284d6be-ff37-4e5c-7357-446b4e1ea8ad@linux.vnet.ibm.com>
Date: Tue, 30 May 2017 21:41:58 +1000
Message-ID: <87tw424lmh.fsf@concordia.ellerman.id.au>
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

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:

> When adding or removing memory, the aa_index (affinity value) for the
> memblock must also be converted to match the endianness of the rest
> of the 'ibm,dynamic-memory' property.  Otherwise, subsequent retrieval
> of the attribute will likely lead to non-existent nodes, followed by
> using the default node in the code inappropriately.
>
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index e104c71..1fb162b 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -124,6 +124,7 @@ static struct property *dlpar_clone_drconf_property(struct device_node *dn)
>  	for (i = 0; i < num_lmbs; i++) {
>  		lmbs[i].base_addr = be64_to_cpu(lmbs[i].base_addr);
>  		lmbs[i].drc_index = be32_to_cpu(lmbs[i].drc_index);
> +		lmbs[i].aa_index = be32_to_cpu(lmbs[i].aa_index);
>  		lmbs[i].flags = be32_to_cpu(lmbs[i].flags);
>  	}
>  

AFAICS this code was added in commit 5f97b2a0d176 ("powerpc/pseries:
Implement memory hotplug add in the kernel").

So this should probably be marked:

  Fixes: 5f97b2a0d176 ("powerpc/pseries: Implement memory hotplug add in the kernel")

And it seems like a bug we'd want fixed in stable, so:

  Cc: stable@vger.kernel.org # v4.1+


Am I right?

cheers
