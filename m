Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C0F72C04F0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:56:22 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 19 Aug 2013 23:45:10 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8A83C3578050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:56:17 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7JDu6Na33095682
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:56:06 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7JDuH3W019042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:56:17 +1000
Message-ID: <521223FE.8030100@linux.vnet.ibm.com>
Date: Mon, 19 Aug 2013 08:56:14 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 8/8] powerpc/pseries: child nodes are not detached by
 dlpar_detach_node
References: <1376544232-24936-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1376544232-24936-9-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1376544232-24936-9-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/15/2013 12:23 AM, Tyrel Datwyler wrote:
> Calls to dlpar_detach_node do not iterate over child nodes detaching them as
> well. By iterating and detaching the child nodes we ensure that they have the
> OF_DETACHED flag set and that their reference counts are decremented such that
> the node will be freed from memory by of_node_release.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/pseries/dlpar.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 4ea667d..7cfdaae 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -286,8 +286,15 @@ int dlpar_attach_node(struct device_node *dn)
>  
>  int dlpar_detach_node(struct device_node *dn)
>  {
> +	struct device_node *child;
>  	int rc;
>  
> +	child = of_get_next_child(dn, NULL);
> +	while (child) {
> +		dlpar_detach_node(child);
> +		child = of_get_next_child(dn, child);
> +	}
> +
>  	rc = of_detach_node(dn);
>  	if (rc)
>  		return rc;
> 
