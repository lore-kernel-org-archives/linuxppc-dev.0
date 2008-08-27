Return-Path: <vbendeb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.226])
	by ozlabs.org (Postfix) with ESMTP id A2341DE14D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 12:26:59 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2628253rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Aug 2008 19:26:58 -0700 (PDT)
Message-ID: <f608b67d0808261926p67e27770mb7c64cc14015b9ab@mail.gmail.com>
Date: Tue, 26 Aug 2008 19:26:58 -0700
From: vb <vb@vsbe.com>
Sender: vbendeb@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: mmap and ppc460gt
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am trying to port an application from ppc854x to ppc440. The
application, among other things, maps register file of a PCI device
into its memory space to gain direct access to the device. mmap() is
used to accomplish the mapping.

I don't seem to be able to port this to ppc460gt: on this architecture
the PCI register space can be mapped only to 36 bit address ranges
with nonzero top nibbles. But mmap()  (at least the one I have in
2.6.25)  accepts only 32 bit values for addresses, hence there is no
way to map PCI space into user space.

Am I missing something and there is a way to map 36 bit address in 32
bit mode? Or maybe the kernel/library were not compiled properly and
mmap() is supposed to accept 64 bit addresses?

Any hints/suggestions will be highly appreciated,
TIA,
Vadim
