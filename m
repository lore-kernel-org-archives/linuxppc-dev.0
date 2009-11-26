Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DB643B6EE9
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 08:19:11 +1100 (EST)
In-Reply-To: <2a27d3730911250007s62f31673p3358631996e8a451@mail.gmail.com>
References: <1258441832-20133-1-git-send-email-leoli@freescale.com>
	<8543954E-619A-4A78-A934-CDC326027FD2@kernel.crashing.org>
	<3A45394FD742FA419B760BB8D398F9EDCBC1F2@zch01exm26.fsl.freescale.net>
	<1258707833.2140.865.camel@pasglop>
	<2a27d3730911200123i23fa6dd1td9e19944d1737e73@mail.gmail.com>
	<DFC7BA62-6CF0-4A08-8DD1-11825A638262@kernel.crashing.org>
	<2a27d3730911250007s62f31673p3358631996e8a451@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DF186CC0-6BF9-4C17-B89B-F6B695E726B2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] powerpc/mm: honor O_SYNC flag for memory map
Date: Thu, 26 Nov 2009 22:26:06 +0100
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> So what you are saying is that if the kernel has mapped a physical
> page as cacheable while user application is trying to map it as
> non-cacheable, there will be machine checks and checkstops rather than
> just performance drop?  This is new to me.  Could you elaborate a bit?

If some data is in cache at a certain physical address, and you then
do an uncached read from that address, on at least some CPUs both the
bus interface and the cache will reply.  Bang, machine check.

Writes are problematic as well.


Segher
