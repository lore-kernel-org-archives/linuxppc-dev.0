Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4CB41A0725
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Sep 2015 00:43:48 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 4 Sep 2015 08:43:46 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 8E4621FF0057
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2015 08:34:53 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t84EhZJA37486618
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Sep 2015 07:43:44 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t84EhA27001128
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Sep 2015 08:43:11 -0600
Message-ID: <55E9ADE5.1080605@linux.vnet.ibm.com>
Date: Fri, 04 Sep 2015 09:42:45 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Bharata B Rao <bharata.rao@gmail.com>, linuxppc-dev@lists.ozlabs.org
CC: Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: Re: [PATCH FIX] powerpc/pseries: Release DRC when configure_connector
 fails
References: <1441361052-3319-1-git-send-email-bharata.rao@gmail.com>
In-Reply-To: <1441361052-3319-1-git-send-email-bharata.rao@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/04/2015 05:04 AM, Bharata B Rao wrote:
> From: Bharata B Rao <bharata@linux.vnet.ibm.com>
> 
> dlpar_cpu_probe() should release the acquired DRC if configure_connector
> call fails.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/pseries/dlpar.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 47d9cebe..db17827 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -422,8 +422,10 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
> 
>  	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
>  	of_node_put(parent);
> -	if (!dn)
> +	if (!dn) {
> +		dlpar_release_drc(drc_index);
>  		return -EINVAL;
> +	}
> 
>  	rc = dlpar_attach_node(dn);
>  	if (rc) {
> 
