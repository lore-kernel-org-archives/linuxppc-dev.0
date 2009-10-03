Return-Path: <Simon.Richter@hogyros.de>
Received: from psionic8.psi5.com (psionic.psi5.com [212.112.229.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.psi5.com", Issuer "psi5.com CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2045FB7BCA
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 20:05:18 +1000 (EST)
Received: from localhost (port-212-202-168-87.dynamic.qsc.de [212.202.168.87])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client CN "Simon Richter",
	Issuer "CA Cert Signing Authority" (verified OK))
	by psionic8.psi5.com (Postfix) with ESMTPS id 3AFCFF2C012
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 11:55:36 +0200 (CEST)
Date: Sat, 3 Oct 2009 11:55:37 +0200
From: Simon Richter <Simon.Richter@hogyros.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Is volatile always verboten for FSL QE structures?
Message-ID: <20091003095537.GA15992@honey.hogyros.de>
References: <4AC60AD8.8030509@ruggedcom.com> <4AC61247.1030507@freescale.com>
	<C3FE6281-04FA-48B3-96EA-D6E68AF65D6B@kernel.crashing.org>
	<4AC63112.7080404@ruggedcom.com>
	<20091002200848.06be4c5a@xilun.lan.proformatique.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091002200848.06be4c5a@xilun.lan.proformatique.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> > >> 'volatile' just doesn't really do what you think it should do.  The
> > >> PowerPC architecture is too complicated w.r.t. ordering of reads and
> > >> writes.  In other words, you can't trust it.

It's not sufficient on PowerPC.

It might be necessary, depending on the compiler's mood for moving stuff
out of loops.

Consider:

| unsigned int *foo = (unsigned int *)0x12345678;
| void bar(void) { while(*foo != 0) asm("eieio"); }

gcc 4.3.4 with -O3 compiles this to

00000000 <bar>:
   0:   3d 20 00 00     lis     r9,0
                        2: R_PPC_ADDR16_HA      foo
   4:   81 69 00 00     lwz     r11,0(r9)
                        6: R_PPC_ADDR16_LO      foo
   8:   80 0b 00 00     lwz     r0,0(r11)
   c:   2f 80 00 00     cmpwi   cr7,r0,0
  10:   4d 9e 00 20     beqlr   cr7
  14:   7c 00 06 ac     eieio
  18:   7c 00 06 ac     eieio
  1c:   4b ff ff f8     b       14 <bar+0x14>

Making the target of foo volatile properly rechecks the condition on
each iteration.

OTOH my PPC box runs fine, so I'm probably missing something obvious.

   Simon
