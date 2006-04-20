Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 04CB667A01
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 03:37:17 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3KHbCnT018978
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Apr 2006 13:37:12 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3KHbCT7237836
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Apr 2006 13:37:12 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3KHbBgV025412
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Apr 2006 13:37:12 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch] powerpc: move PAGE_SIZE outside #ifdef __KERNEL__
Date: Thu, 20 Apr 2006 19:37:10 +0200
References: <4447C3BA.6050709@am.sony.com>
In-Reply-To: <4447C3BA.6050709@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604201937.10667.arnd.bergmann@de.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 20 April 2006 19:24, Geoff Levand wrote:
> The procps package needs PAGE_SIZE, defined in asm-powerpc/page.h,
> but it is defined inside "#ifdef __KERNEL__".
> 
> This moves the PAGE_SIZE definition outside of "#ifdef __KERNEL__".
> 
> From: Hiroaki Fuse
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Nack.

It's a little harder unfortunately. First of all, the patch moves
more parts outside of __KERNEL__, like the  #include <linux/config.h>,
which does not get installed into /usr/include/linux/.

More importantly, the page size is no longer constant on powerpc
across kernel builds. User space relying on a fixed size is broken.

Please look into the sysconf(3) and getpagesize(2) man pages for
how to do it correctly.

Which version of procps are you referring to anyway? This bug seems
to have been fixed back in 2001, but maybe it got reintroduced now.

	Arnd <><
