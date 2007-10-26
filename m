Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CEB7BDDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Oct 2007 11:52:21 +1000 (EST)
Subject: Re: Apparent kernel bug with GDB on ppc405
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Daney <ddaney@avtrex.com>
In-Reply-To: <471FAC48.1070008@avtrex.com>
References: <20071024194640.GB19691@waste.org> <471FAC48.1070008@avtrex.com>
Content-Type: text/plain
Date: Fri, 26 Oct 2007 11:52:10 +1000
Message-Id: <1193363530.7018.42.camel@pasglop>
Mime-Version: 1.0
Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org,
	Matt Mackall <mpm@selenic.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Wed, 2007-10-24 at 13:34 -0700, David Daney wrote:
> First of all I have never used a similar configuration so this may be 
> totally off base.  But...
> 
> If the icache is virtually indexed, then I think there are only two
> ways 
> to invalidate it.  The first is from the context of the debugged
> process 
> where the page is mapped at the location the target program will see
> it. 
>    If you try to invalidate from the context of the debugger, the
> page 
> will most likely not be mapped at the virtual address of the target 
> program so you might have to invalidate the *entire* icache.

Yup, sounds likely. We don't handle that virtual icache well at all in
linux. Things tend to work by mere luck. I have various ideas to fix
that but haven't actually implemented them.

Ben.
