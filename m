Return-Path: <rubini@mail.gnudd.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5F4ABB7B8E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 02:28:08 +1000 (EST)
Received: from mail.gnudd.com (mail2.gnudd.com [213.203.150.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5C25FDDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 02:28:06 +1000 (EST)
Date: Thu, 30 Jul 2009 18:19:42 +0200
From: Alessandro Rubini <rubini@gnudd.com>
To: nvbolhuis@aimvalley.nl
Subject: Re: can the kernel show user task stack backtrace ?
Message-ID: <20090730161941.GA14988@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: rubini@gnudd.com
In-Reply-To: <4A71C04E.6060506@aimvalley.nl>
References: <4A71C04E.6060506@aimvalley.nl> 
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> We're dealing with some complex (3rd party) applications and I like to see a
> user task stack backtrace.
> 
> (Of course the way to go here is to use a debugger (gdb) and
>   do a backtrace (with the coredump file).

Actually, you can intercept SIGSEGV and print your own stack from within
the signal handler. You can also open /proc/self/maps and print it, to
ease understanding the various pointers in there, especially if the
application is using a number of shared libs.

This is usually easier than getting to a core dump, although there is
less information than what the core offers.

I have the code for ARM and I've it on ppc once, but I must dig for the actual
code.

/alessandro
