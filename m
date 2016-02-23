Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4EDC31A19E3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 16:00:09 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Tue, 23 Feb 2016 15:00:08 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 23B802CE805C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 16:00:07 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1N4xx6x1900972
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 16:00:07 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1N4xYVF016574
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 15:59:34 +1100
Date: Tue, 23 Feb 2016 15:59:07 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, michaele@au1.ibm.com
Subject: Re: [PATCH 1/1] powerpc: Detect broken or mismatched toolchains
Message-ID: <20160223045907.GA28294@tungsten.ozlabs.ibm.com>
References: <5c8ce41d4341aa5c0698abbc0284359a789d2334.1456117980.git.sam.bobroff@au1.ibm.com>
 <1456193101.2463.133.camel@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456193101.2463.133.camel@buserror.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 22, 2016 at 08:05:01PM -0600, Scott Wood wrote:
> On Mon, 2016-02-22 at 16:13 +1100, Sam Bobroff wrote:
> > It can currently be difficult to diagnose a build that fails due to
> > the compiler, linker or other parts of the toolchain being unable to
> > build binaries of the type required by the kernel config. For example
> > using a little endian toolchain to build a big endian kernel may
> > produce:
> > 
> > as: unrecognized option '-maltivec'
> > 
> > This patch adds a basic compile test and error message to
> > arch/powerpc/Makefile so that the above error becomes:
> > 
> > *** Sorry, your toolchain seems to be broken or incorrect. ***
> > Make sure it supports your kernel configuration (ppc64).
> > 
> > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> > ---
> 
> How is this more useful than getting to actually see the way in which the
> toolchain (or the CFLAGS) is broken?

My reasoning was that it would be better because it happens at the start of the
build, rather than (possibly) a long way into it, and it indicates that the
problem is the toolchain setup (or config) itself rather than the file it's
trying to compile or link.

But I agree completely with what you're saying. I'll try re-working it in a way
that shows the command that fails and it's output.

Cheers,
Sam.
