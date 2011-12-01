Return-Path: <michaele@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 62EE0B6F65
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 17:59:05 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <michaele@au1.ibm.com>;
 Thu, 1 Dec 2011 06:54:42 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB16tKTh2326728
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2011 17:55:20 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB16wkBZ007373
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2011 17:58:47 +1100
Message-ID: <1322722726.5215.2.camel@concordia>
Subject: Re: [PATCH 07/10] powerpc/mpic: Don't open-code dcr_resource_start
From: Michael Ellerman <michaele@au1.ibm.com>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Date: Thu, 01 Dec 2011 17:58:46 +1100
In-Reply-To: <1322593117-29938-8-git-send-email-Kyle.D.Moffett@boeing.com>
References: <1322593117-29938-1-git-send-email-Kyle.D.Moffett@boeing.com>
 <1322593117-29938-8-git-send-email-Kyle.D.Moffett@boeing.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Reply-To: michaele@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-11-29 at 13:58 -0500, Kyle Moffett wrote:
> Don't open-code the OpenFirmware "dcr-reg" property lookup trying to map
> DCR resources.  This makes the code a bit easier to read.
> 
> Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
> ---
>  arch/powerpc/sysdev/mpic.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index e0216ff..6916ba5 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -319,11 +319,8 @@ static void _mpic_map_dcr(struct mpic *mpic, struct device_node *node,
>  			  struct mpic_reg_bank *rb,
>  			  unsigned int offset, unsigned int size)
>  {
> -	const u32 *dbasep;
> -
> -	dbasep = of_get_property(node, "dcr-reg", NULL);
> -
> -	rb->dhost = dcr_map(node, *dbasep + offset, size);
> +	phys_addr_t phys_addr = dcr_resource_start(node);

Gives me:

  arch/powerpc/sysdev/mpic.c:321: error: too few arguments to function 'dcr_resource_start'

Because you're missing index:

  unsigned int dcr_resource_start(const struct device_node *np, unsigned int index)

cheers

-- 
