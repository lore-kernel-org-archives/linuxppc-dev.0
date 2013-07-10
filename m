Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B9B6C2C02AF
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jul 2013 00:11:57 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 10 Jul 2013 23:59:53 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D9C2E2CE804D
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jul 2013 00:11:54 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6ADulAM39256200
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jul 2013 23:56:47 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6AEBrhA021992
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jul 2013 00:11:54 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix the corrupt r3 error during MCE handling.
In-Reply-To: <20130710130155.4993.61577.stgit@mars>
References: <20130710130155.4993.61577.stgit@mars>
Date: Wed, 10 Jul 2013 19:41:51 +0530
Message-ID: <8761wild20.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> During Machine Check interrupt on pseries platform, R3 generally points to
> memory region inside RTAS (FWNMI) area. We see r3 corruption because when RTAS
> delivers the machine check exception it passes the address inside FWNMI area
> with the top most bit set. This patch fixes this issue by masking top two bit
> in machine check exception handler.

I always got that error and used to wonder why I find FWNMI
corrupt. IS this a rtas bug or is it documented in papr ?


>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/ras.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index 7b3cbde..721c058 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -287,6 +287,9 @@ static struct rtas_error_log *fwnmi_get_errinfo(struct pt_regs *regs)
>  	unsigned long *savep;
>  	struct rtas_error_log *h, *errhdr = NULL;
>
> +	/* Mask top two bits */
> +	regs->gpr[3] &= ~(0x3UL << 62);
> +
>  	if (!VALID_FWNMI_BUFFER(regs->gpr[3])) {
>  		printk(KERN_ERR "FWNMI: corrupt r3 0x%016lx\n", regs->gpr[3]);
>  		return NULL;
>

-aneesh
