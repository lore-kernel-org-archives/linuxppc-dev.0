Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-ash-R.bigfish.com (outbound-ash.frontbridge.com
	[206.16.192.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5EE4367B55
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 03:35:12 +1000 (EST)
Received: from outbound1-ash.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound1-ash-R.bigfish.com (Postfix) with ESMTP id C8DCE12A5792
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 17:34:58 +0000 (UTC)
Received: from mail33-ash-R.bigfish.com (unknown [172.18.2.3])
	by outbound1-ash.bigfish.com (Postfix) with ESMTP id 3A5F012A38B9
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 17:34:58 +0000 (UTC)
Received: from mail33-ash.bigfish.com (localhost.localdomain [127.0.0.1])
	by mail33-ash-R.bigfish.com (Postfix) with ESMTP id 19085826143
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 17:34:56 +0000 (UTC)
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mail33-ash.bigfish.com (Postfix) with ESMTP id 0419782ACF8
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 17:34:55 +0000 (UTC)
Received: from mail1.sgo.in.sel.sony.com (mail1.sgo.in.sel.sony.com
	[43.130.1.111])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id k7THYt5k025841
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 17:34:55 GMT
Received: from USSDIXIM01.am.sony.com (ussdixim01.am.sony.com [43.130.140.33])
	by mail1.sgo.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id
	k7THYs9x005308
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 17:34:54 GMT
Message-ID: <44F47ABE.7080602@am.sony.com>
Date: Tue, 29 Aug 2006 10:34:54 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: undefined reference to pci_io_base
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to understand the intended design of the inb()
and outb() macros in asm-powerpc/io.h. They are causing
me some grief when I set CONFIG_PCI=n:

  drivers/built-in.o: undefined reference to `pci_io_base'

This is coming from drivers/char/mem.c, which is always
built in, and is referencing pci_io_base through inb()
and outb().

Anyway, it seems asm-powerpc/io.h has two sets of io macros,
one set for iSeries, and one generic set for everything else.
The problem arises because the generic macros just use the eeh
macros in eeh.h, which in turn, directly use pci_io_base. 

I can think of three solutions to this that work for me, but
I'm not sure which, if any, would be the most proper.  One
would be to just have this in io.h:

  #if defined(CONFI_PCI)
  extern unsigned long pci_io_base;
  #else
  #define pci_io_base 0
  #endif

Another would be to have this in some file that is always built
in, like setup-common.c:

  #if !defined(CONFI_PCI)
  unsigned long pci_io_base;
  EXPORT_SYMBOL(pci_io_base);
  #endif

A third would be to have another set of io macros in io.h that
are used when CONFIG_PCI=n.

Comments welcome.

-Geoff
