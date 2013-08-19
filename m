Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9331B2C00EA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:49:29 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 19 Aug 2013 23:46:14 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 350B82BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:49:24 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7JDnDkd9306490
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:49:13 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7JDnNm0018067
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 23:49:23 +1000
Message-ID: <52122261.7030501@linux.vnet.ibm.com>
Date: Mon, 19 Aug 2013 08:49:21 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/8] powerpc/pseries: do all node initialization in
 dlpar_parse_cc_node
References: <1376544232-24936-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1376544232-24936-6-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1376544232-24936-6-git-send-email-tyreld@linux.vnet.ibm.com>
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
> Currently the OF_DYNAMIC and kref initialization for a node happens in
> dlpar_attach_node. However, a node passed to dlpar_attach_node may be a tree
> containing child nodes, and no initialization traversal is done on the
> tree. Since the children never get their kref initialized or the OF_DYNAMIC
> flag set these nodes are prevented from ever being released from memory
> should they become detached. This initialization step is better done at the
> time each node is allocated in dlpar_parse_cc_node.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/pseries/dlpar.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index a1a7b9a..c855233 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -83,6 +83,9 @@ static struct device_node *dlpar_parse_cc_node(struct cc_workarea *ccwa)
>  		return NULL;
>  	}
>  
> +	of_node_set_flag(dn, OF_DYNAMIC);
> +	kref_init(&dn->kref);
> +
>  	return dn;
>  }
>  
> @@ -256,8 +259,6 @@ int dlpar_attach_node(struct device_node *dn)
>  {
>  	int rc;
>  
> -	of_node_set_flag(dn, OF_DYNAMIC);
> -	kref_init(&dn->kref);
>  	dn->parent = derive_parent(dn->full_name);
>  	if (!dn->parent)
>  		return -ENOMEM;
> 
