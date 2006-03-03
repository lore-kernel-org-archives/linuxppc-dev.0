Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E7594679F4
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Mar 2006 00:57:22 +1100 (EST)
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id D371AEEF1
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Mar 2006 14:57:17 +0100 (CET)
Date: Fri, 3 Mar 2006 14:57:17 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: alignment bugs in prom_init
Message-ID: <20060303135717.GA5707@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some G5 and pSeries models dont boot with recent kernels. The reason is
likely the casting of pointers of stack variables to u32. One example is
the prom_getprop() call in prom_init_stdout().

sp is 0x0023e784, val is at offset 120, which makes 0x0023e7fc. This
address is casted to u32, which changes it to 0x0023e7f8. The firmware
writes to the wrong addres and things go downhill very quick.

c00000000040baa8:       3b 21 00 78     addi    r25,r1,120
..
c00000000040baf4:       57 28 00 38     rlwinm  r8,r25,0,0,28
..
c00000000040bb10:       4b ff d3 3d     bl      c000000000408e4c <.call_prom>

If I remove the casts and pass the pointer as is, everything starts to
work as expected? Why is all this (u32)(unsigned long) casting in
arch/powerpc/kernel/prom_init.c required?

Does -Os vs -O2 make a difference here?
