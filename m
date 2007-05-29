Return-Path: <tmbinc@elitedvb.net>
Received: from mail.multimedia-labs.de (mail.multimedia-labs.de
	[82.149.226.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.multimedia-labs.de",
	Issuer "Multimedia Labs CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 30060DDF8F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 08:16:48 +1000 (EST)
Received: from localhost (localhost [127.0.0.172])
	by mail.multimedia-labs.de (Postfix) with ESMTP id A43081C803E
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 23:47:02 +0200 (CEST)
Received: from mail.multimedia-labs.de ([127.0.0.172])
	by localhost (mail [127.0.0.172]) (amavisd-new, port 10024) with LMTP
	id 31900-01-2 for <linuxppc-dev@ozlabs.org>;
	Tue, 29 May 2007 23:46:59 +0200 (CEST)
Received: from xpc823.intern.randgruppe.info (e176178199.adsl.alicedsl.de
	[85.176.178.199])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.multimedia-labs.de (Postfix) with ESMTP id 77A861C8006
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 23:46:59 +0200 (CEST)
Received: from [10.0.0.75] (unknown [10.0.0.75])
	by xpc823.intern.randgruppe.info (Postfix) with ESMTP id F3C427004F
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 23:51:12 +0200 (CEST)
Message-ID: <465C9F04.4070202@elitedvb.net>
Date: Tue, 29 May 2007 23:45:40 +0200
From: Felix Domke <tmbinc@elitedvb.net>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
References: <1180423456.19517.124.camel@localhost.localdomain>	<B1348C8C-09B1-4906-BF89-CC4206F0CA0A@embeddedalley.com>	<1180425900.19517.136.camel@localhost.localdomain>	<20070529092658.GA32228@iram.es>	<08b3997ab86a819c63b5cb0afcdc0c9e@kernel.crashing.org>
	<1180474079.19517.188.camel@localhost.localdomain>
In-Reply-To: <1180474079.19517.188.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2007-05-29 at 15:04 +0200, Segher Boessenkool wrote:
>> Just call them and trap the SEGV ;-)  You can check the
>> aux vector of course, or ask glibc -- but the SEGV way
>> is the only really portable way.  Strange world :-)
> SIGILL you mean ? :-)
Anyway, please don't. It is *not* portable.

Or can you guarantee that no CPU ever will implement a.) only a 64bit
subset or b.) other instructions using the same encoding as the 64bit
insn you will use for testing?

I still remember the pain of trying to tell that ffmpeg that my CPU
can't do real altivec, even when it implements some parts of it without
SIGILLing (which ffmpeg used for testing).

And: What will happen if you manage to run your code under an operating
system which doesn't even save the upper bits at all on interrupts? You
can't check for that with SIGILL.

Having a decent way (like aux/glibc) would also solve the problem with
"incompatible CPUs", which you mentioned.

And i'd still like to see some decent ILP32LL64 support. Maybe even with
a new "native 64bit" datatype (how ugly), in order to not break the ABI.
I just want to call my hand-optimized 64bit assembler code with 64bit
arguments.
How does OS X handle this? Don't they have the same problem there?

Felix
