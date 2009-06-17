Return-Path: <dwg@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F0609B71E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 15:08:09 +1000 (EST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AB90ADDD1C
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 15:08:08 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5H57G27027994
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 15:07:16 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5H587RI557372
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 15:08:07 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5H586Bu005225
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 15:08:07 +1000
Date: Wed, 17 Jun 2009 14:13:44 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 5/6] Modify Data storage exception code to recognise
	DABR match first
Message-ID: <20090617041344.GJ486@yookeroo.seuss>
References: <20090610090316.898961359@prasadkr_t60p.in.ibm.com>
	<20090610090824.GF14478@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090610090824.GF14478@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 10, 2009 at 02:38:24PM +0530, K.Prasad wrote:
> Modify Data storage exception code to first lookout for a DABR match before
> recognising a kprobe or xmon exception.
> 
> Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/fault.c |   14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> Index: linux-2.6-tip.hbkpt/arch/powerpc/mm/fault.c
> ===================================================================
> --- linux-2.6-tip.hbkpt.orig/arch/powerpc/mm/fault.c
> +++ linux-2.6-tip.hbkpt/arch/powerpc/mm/fault.c
> @@ -136,6 +136,12 @@ int __kprobes do_page_fault(struct pt_re
>  		error_code &= 0x48200000;
>  	else
>  		is_write = error_code & DSISR_ISSTORE;
> +
> +	if (error_code & DSISR_DABRMATCH) {
> +		/* DABR match */
> +		do_dabr(regs, address, error_code);
> +		return 0;
> +	}

Again, given the amount of work you're doing on all the breakpoint
paths, I really think you should be rewriting do_dabr(), not just
hooking in around it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
