Return-Path: <vbendeb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.233])
	by ozlabs.org (Postfix) with ESMTP id F29D9DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Aug 2008 12:52:54 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so202622rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 06 Aug 2008 19:52:53 -0700 (PDT)
Message-ID: <f608b67d0808061952g3d1b658bp7179e3990c5b105b@mail.gmail.com>
Date: Wed, 6 Aug 2008 22:52:53 -0400
From: vb <vb@vsbe.com>
Sender: vbendeb@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: Accessing peripheral bus devices on 460GT
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

I am trying to bring up a 2.6.25 based system on a 460GT platform. I
am using the OF tree cloned off canyonblands.dts, and I am not sure if
something is missing in the tree, or in the kernel, or I am doing
something stupid.

The problem is that I don't seem to be able to access any peripheral
device activated by cs1, 2, 3 (I have not tried touching the NOR flash
(cs0) just yet). If I don't touch any peripherals the system can
netbboot or diskboot all the way to the linux prompt.

But unfortunately, the damn peripherals have to be touched :-)

I do invoke ioremap_nocache(<phys addr>, <addr range size>), and it
returns a virtual address. The thing is that as soon as I try
accessing the device off this pointer an exception is thrown. From
u-boot  I can access the <phys addr>..+<addr range size> space no
problem.

 I see that the dts file mentions that u-boot is supposed to supply
the "ranges" property in the /plb/opb/ebc section; examining the
u-boot code for different amcc platforms shows that only the NOR flash
size is supplied there.

I guess the real question is how do I gain access to the EBC mapped
hardware configured by u-boot?

can someone please shed any light on this,

thanks a lot in advance,

Vadim
