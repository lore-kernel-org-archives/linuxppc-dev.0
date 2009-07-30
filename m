Return-Path: <hofrat@hofr.at>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 77EFDB7BB9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 02:55:59 +1000 (EST)
Received: from mail.hofr.at (unknown [212.69.189.236])
	by ozlabs.org (Postfix) with ESMTP id 0DFEADDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 02:55:58 +1000 (EST)
Date: Thu, 30 Jul 2009 18:55:55 +0200
From: Nicholas Mc Guire <mcguire@lzu.edu.cn>
To: Alessandro Rubini <rubini@gnudd.com>
Subject: Re: can the kernel show user task stack backtrace ?
Message-ID: <20090730165555.GA5476@opentech.at>
References: <4A71C04E.6060506@aimvalley.nl>
	<20090730161941.GA14988@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090730161941.GA14988@mail.gnudd.com>
Cc: linuxppc-dev@ozlabs.org, nvbolhuis@aimvalley.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 30 Jul 2009, Alessandro Rubini wrote:

> > We're dealing with some complex (3rd party) applications and I like to see a
> > user task stack backtrace.
> > 
> > (Of course the way to go here is to use a debugger (gdb) and
> >   do a backtrace (with the coredump file).
> 
> Actually, you can intercept SIGSEGV and print your own stack from within
> the signal handler. You can also open /proc/self/maps and print it, to
> ease understanding the various pointers in there, especially if the
> application is using a number of shared libs.
> 
> This is usually easier than getting to a core dump, although there is
> less information than what the core offers.
> 
> I have the code for ARM and I've it on ppc once, but I must dig for the actual
> code.
>
I think libSegFault.so (part of glibc) can do that by simply preloading it 

LD_PRELOAD=/lib/libSegFault.so ./your_segfaulting_app

should do the trick.

hofrat
