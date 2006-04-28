Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F91F679E1
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 23:12:59 +1000 (EST)
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id k3SDCsRT000637
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 15:12:55 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id k3SDCs5D000635
	for linuxppc-dev@ozlabs.org; Fri, 28 Apr 2006 15:12:54 +0200
Date: Fri, 28 Apr 2006 15:12:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@ozlabs.org
Subject: sign extension for 32bit syscalls on ppc64
Message-ID: <20060428131254.GA507@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For 32bit syscalls implemented in arch/powerpc/ we're doing our own
sign-extension where an int argument is passed as u32 in the prototype
and then casted to int later on:

asmlinkage long compat_sys_sendfile(u32 out_fd, u32 in_fd, compat_off_t
__user * offset, u32 count)

{
	...
	ret = sys_sendfile((int)out_fd, (int)in_fd, up, count);
	..
}

OTOH various syscalls in the generic code don't do that and it seems to
still work fine.  I have patches for various new generic compat
routines, and they all seem to work fine without this sign extension.

What's the exact sign extention rules for ppc64?
