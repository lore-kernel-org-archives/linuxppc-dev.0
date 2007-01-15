Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4F6F7DDE35
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 03:09:31 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0FG9NRx021482
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 11:09:23 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l0FG80X3245156
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 11:08:01 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0FG80ss031597
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 11:08:00 -0500
Subject: Re: [PATCH 7/19] powerpc: interfaces to the hypervisor of Celleb
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20070113124638.GA13493@krispykreme>
References: <200701120100.l0C10ktW025821@toshiba.co.jp>
	<20070113124638.GA13493@krispykreme>
Content-Type: text/plain
Date: Mon, 15 Jan 2007 10:07:56 -0600
Message-Id: <1168877276.11068.14.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-13-01 at 23:46 +1100, Anton Blanchard wrote:
> Hi,
> 
> Just a few suggestions.
> 
> > +#define	HCALL_MEDIUM	or 	2,2,2
> 
> Doesnt look like this is used.

seconded.  that #define is identical to HMT_MEDIUM out of ppc_asm.h.  I
notice that HMT_MEDIUM is actually used throughout this patch, so most
of the way there already.

> > +#define	HVSC	.long	0x44000022
> 
> Could you pick this up from the define in include/asm-powerpc instead?

"#include <asm/hvcall.h>" should do it.

> 
> > +#define	LOAD_CONST64(r, const)					\
> > +	lis	r, ((const)>>48)&0xFFFF;			\
> > +	ori	r, r, ((const)>>32)&0xFFFF;			\
> > +	rldicr	r, r, 32, 31;					\
> > +	oris	r, r, ((const)>>16)&0xFFFF;			\
> > +	ori	r, r, ((const)>>0)&0xFFFF
> 
> It doesnt look like this is used either.
> 
> Anton
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
