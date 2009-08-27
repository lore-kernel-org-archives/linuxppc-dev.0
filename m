Return-Path: <wilbur512@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3EB8EB7B7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 02:27:20 +1000 (EST)
Received: from mail-yw0-f171.google.com (mail-yw0-f171.google.com
	[209.85.211.171]) by ozlabs.org (Postfix) with ESMTP id 87C01DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 02:27:18 +1000 (EST)
Received: by ywh1 with SMTP id 1so1593274ywh.9
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 09:27:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A96AD4B.1010204@freescale.com>
References: <e997b7420908260739u49fb4b36j9eb148782829547b@mail.gmail.com>
	<20090826192030.GA17027@b07421-ec1.am.freescale.net>
	<e997b7420908270853i7d4058e1p8ddcfcf8df18486e@mail.gmail.com>
	<4A96AD4B.1010204@freescale.com>
Date: Fri, 28 Aug 2009 00:27:15 +0800
Message-ID: <e997b7420908270927m1ec1dbcbq51781e3b1e4db061@mail.gmail.com>
Subject: Re: Can't write value into memory ?(E500 V2)
From: "wilbur.chan" <wilbur512@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/8/27 Scott Wood <scottwood@freescale.com>:
>
> Is this under Linux (it is a Linux mailing list...)? =A0If so, there are
> better ways of communicating that don't involve clobbering random memory =
and
> overlapping userspace TLB mappings.

Yes, I'm doing this under linux in kernel mode.

I've used interrupt between cores, to make:

1) cpu0  carrys some data to a place (As a matter of fact ,the 'data'
is a kernel, the 'place' is at 0, and  I'm using kexec..)

2) cpu0 writes a 'flag' to a physical address(16M), to indicate that ,

it has finished the carrying in step 1. And jump to new kernel directly.


3) cpu1 enters the loop by IRQ , checking the 'flag' from time to
time. If the 'flag' is true, it

breaks the  loop and jumps to the instruction in new kernel.


> Do both cores have a mapping with the M bit (memory coherence required) s=
et?


What do you mean by  M bit set?

I setup a 1:1 mapping in both cpu0 and cpu1, and invalidate all the
other entries in TLB1 and

TLB0
