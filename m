Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AAF6EB7B6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Sep 2009 14:37:43 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1035BDDD01
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Sep 2009 14:37:42 +1000 (EST)
Subject: Re: [FTRACE] Enabling function_graph causes OOPS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: rostedt@goodmis.org
In-Reply-To: <1252814877.26049.93.camel@gandalf.stny.rr.com>
References: <4A5C5D65.3030906@in.ibm.com>
	<alpine.DEB.2.00.0907141844540.32740@gandalf.stny.rr.com>
	<4A76BE81.4080707@in.ibm.com>
	<1252458303.20985.10.camel@gandalf.stny.rr.com>
	<4AA74AE2.5090001@in.ibm.com>
	<1252814877.26049.93.camel@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Sun, 13 Sep 2009 14:37:30 +1000
Message-Id: <1252816650.8375.70.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2009-09-13 at 00:07 -0400, Steven Rostedt wrote:
>                        982: R_PPC64_ADDR16_HIGHEST
> ftrace_return_to_handler
>  984:   60 84 00 00     ori     r4,r4,0
>                         986: R_PPC64_ADDR16_HIGHER
> ftrace_return_to_handler
>  988:   78 84 07 c6     rldicr  r4,r4,32,31
>  98c:   64 84 00 00     oris    r4,r4,0
>                         98e: R_PPC64_ADDR16_HI
> ftrace_return_to_handler
>  990:   60 84 00 00     ori     r4,r4,0
>                         992: R_PPC64_ADDR16_LO
> ftrace_return_to_handler
>  994:   e8 44 00 08     ld      r2,8(r4)
>  998:   48 00 00 01     bl      998 <.mod_return_to_handler+0x30>
>                         998:
> R_PPC64_REL24      .ftrace_return_to_handler
>  99c:   60 00 00 00     nop
>  9a0:   7c 68 03 a6     mtlr    r3

.../...

> Something is totally messed up here.

Could it be that we don't handle R_PPC64_ADDR16_* relocs in
arch/powerpc/kernel/modules/module_64.c ?

Sachin, do you see a bunch of "Unknown ADD relocation" in your dmesg ?

Ben.
