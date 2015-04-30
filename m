Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43B131A025F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 07:58:40 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 30 Apr 2015 17:58:37 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 757AA38C8026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 17:58:35 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3ULwZXF61866052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 21:58:35 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3ULwYmX024081
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 17:58:35 -0400
Message-ID: <5542A589.9010703@linux.vnet.ibm.com>
Date: Thu, 30 Apr 2015 14:58:33 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: Fix possible leaked device node reference
References: <5541891A.6040506@linux.vnet.ibm.com>
In-Reply-To: <5541891A.6040506@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/29/2015 06:44 PM, Nathan Fontenot wrote:
> Failure return from dlpar_configure_connector when dlpar adding cpus
> results in leaking references to the cpus parent device node. Move the
> call to of_node_put() prior to checking the result of
> dlpar_configure_connector.
> 
> Fixes: 8d5ff320766f ("powerpc/pseries: Make dlpar_configure_connector parent node aware")

That commit went into 3.12. Shouldn't this be CC to stable?

-Tyrel

> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/dlpar.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 019d34a..47d9cebe 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -421,11 +421,10 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
>  		return -ENODEV;
>  
>  	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
> +	of_node_put(parent);
>  	if (!dn)
>  		return -EINVAL;
>  
> -	of_node_put(parent);
> -
>  	rc = dlpar_attach_node(dn);
>  	if (rc) {
>  		dlpar_release_drc(drc_index);
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
