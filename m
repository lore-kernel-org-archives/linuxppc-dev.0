Return-Path: <skaiser.uci@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 855B467B85
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 05:29:09 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id i2so291757nfe
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 06 Sep 2006 12:29:06 -0700 (PDT)
From: "Steven Kaiser" <skaiser.uci@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: Simple module, but won't build
Date: Wed, 6 Sep 2006 12:29:05 -0700
Message-ID: <000001c6d1ea$b8541b30$6e4ec880@volt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thanks Josu for the LED source code.  It works!

Turns out my basic problem with autoconf.h was my confusion with all the
kernel trees I have around.  I was downloading and compiling new kernels
into:
/opt/eldk/
but my NFS filesystem was targeted at:
/opt/eldk/ppc_82xx/
 
autoconf.h is generated during the $make menuconfig step (I'm pretty sure),
and so was placed in:
/opt/eldk/usr/src/linuxppc_2_4_devel/include/linux
but my running kernel was looking for it in:
/opt/eldk/ppc_82xx/usr/src/linuxppc_2_4_devel/include/linux

So I downloaded new kernel sources into /opt/eldk/ppc_82xx/, recompiled,
fixed some symbolic links, and did a little makefile magic to ensure the
right stuff is included when I compile modules, and all now seems well.

Steven Kaiser
Chemistry Electronics Facility
University of California, Irvine
2347 Natural Sciences 2
Irvine, CA  92697-2025
