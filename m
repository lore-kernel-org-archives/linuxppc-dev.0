Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7F7C67FB3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 18:59:33 +1000 (EST)
Date: Wed, 24 Aug 2005 09:59:27 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: zhonglei@RCS-9000.COM
Message-Id: <20050824095927.2dcfa041.ajz@cambridgebroadband.com>
In-Reply-To: <200508241507.AA31981680@RCS-9000.COM>
References: <200508241507.AA31981680@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: unresolved symbol
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

At compile time the compiler assumed these symbols would be defined externally, either by the kernel
or by another module loaded prior to hello.o.  The error message says that these symbols are not
exported by the kernel (or any currently loaded modules) prior to running "insmod hello.o".

Either:

1.	You need to insmod another module first (or use "modprobe hello" which may do this automatically)

2.	The module defining these symbols has not used the EXPORT_SYMBOL() macro to make them exported.

3.	These symbols are not defined in either the kernel or any modules.

Alex

On Wed, 24 Aug 2005 15:07:58 +0800
"zhonglei" <zhonglei@RCS-9000.COM> wrote:

> hi
>    My mod has no error or warning during compiling.But when I "insmod hello.o" , it shows:
>    hello.o : unresolved symbol TaskStart
>    hello.o : unresolved symbol TaskLoadImage
>    hello.o : unresolved symbol TaskInitAPI
>    ...
> What's the problem?
> BestRegards
> zhonglei
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
