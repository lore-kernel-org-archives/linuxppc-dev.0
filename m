Return-Path: <jimix@watson.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2219F67C54
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 05:10:09 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7DJA3iV029492
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Aug 2006 15:10:03 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7DJA32W295410
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Aug 2006 15:10:03 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7DJA3iX023462
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Aug 2006 15:10:03 -0400
In-Reply-To: <20060807230606.GC11805@pb15.lixom.net>
References: <E1G9jpY-0004Nv-2d@kmac.watson.ibm.com>
	<20060807230606.GC11805@pb15.lixom.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E8DB24F7-88DE-4509-9005-940973271C5E@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [RFC] Debugging with a HW probe.
Date: Sun, 13 Aug 2006 15:10:00 -0400
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 7, 2006, at 7:06 PM, Olof Johansson wrote:

> > --- a/include/asm-powerpc/xmon.h
> > +++ b/include/asm-powerpc/xmon.h
> > @@ -8,5 +8,12 @@ extern int xmon(struct pt_regs *excp);
> >  extern void xmon_printf(const char *fmt, ...);
> >  extern void xmon_init(int);
> >
> > +/*
> > + * Support Processor Attention Instruction introduced in POWER
> > + * architecture processors as of RS64, tho may not be supported by
> > + * POWER 3.
> > + */
> > +#define ATTN() asm volatile(".long 0x00000200; nop")
>
> At least my toolchain understands "attn ; nop"?

looks like it was added in 2003:
   2003-06-10  Gary Hade <garyhade@us.ibm.com>
   	    Alan Modra  <amodra@bigpond.net.au>

	* ppc-opc.c (DQ, RAQ, RSQ, RTQ): Define.
	(insert_dq, extract_dq, insert_raq, insert_rtq, insert_rsq): New.
	(powerpc_opcodes): Add "attn", "lq" and "stq".

am happy to put in symbolically.
