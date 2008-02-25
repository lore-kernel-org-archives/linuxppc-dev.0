Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.228])
	by ozlabs.org (Postfix) with ESMTP id 417B8DDE9A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Feb 2008 07:05:21 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so1769809wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Feb 2008 12:05:20 -0800 (PST)
Message-ID: <fa686aa40802251205t5c9e76a3yf314b325bfcdd342@mail.gmail.com>
Date: Mon, 25 Feb 2008 13:05:19 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: rodolfo <rodolfo@lesc.ufc.br>
Subject: Re: XUP Virtex II p with Linux 2.4 - Question
In-Reply-To: <9974727a671b73eacef871a6a394c6cb@lesc.ufc.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9974727a671b73eacef871a6a394c6cb@lesc.ufc.br>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Feb 25, 2008 at 12:05 PM, rodolfo <rodolfo@lesc.ufc.br> wrote:
> Hey everybody,
>
>  I'm in trouble;
>
>  1) The EDK flow: I set the OS in the Software Plataform Settings to
>  linux_2_6 version 1.00.a. after that, in OS and Library section I have to
>  fill out the fields "memory size" , "connected_periphs" , "ramdisk size"
>  ... ?  How would I do it ?
>
>  2) Do I place xparametera_ml300.h in /opt/ELDK/ppc_4xx/usr/src/linux-2.6.15
>  ? if not where?

You should download a current release of the linux kernel.  Don't use
the one that comes with ELDK.

in arch/ppc/platforms/4xx/xparameters/xparameters_ml403.h.  If you're
using the ml403 reference design, it is already there.  If you're
using a custom design then you'll need to replace it.

See here for hints:

http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex

>  3) I downloaded "ppc-2006-01-11.iso" from denx (ELDK) website and I'm
>  trying to follow their instructions for ppc 4xx plataform.
>  [ website: http://www.denx.de/wiki/view/DULG/ELDK ]

This is an old release of ELDK.  You should probably move up to a more
recent release.

>
>  In /opt/ELDK/ppc_4xx/usr/src/u-boot-1.1.4/ I do:
>
>  "make distclen" and  "make ml300_config" are ok! After "make all" in  I've
>  got an error:
>
>  a - ppc_longjmp.o
>  a - ppc_setjmp.o
>  a - stubs.o
>  make[1]: *** No rules for processing the target `hello_world.srec', needed
>  by `all'. Stop.       --> note: "TRANSLATION FROM PORTUGESE"
>  make[1]: Exiting `/opt/ELDK/ppc_4xx/usr/src/u-boot-1.1.4/examples'
>  make: ** [examples] Error 2

You're using an ancient copy of u-boot that breaks with certain
versions of the 'make' program.  You should try using a recent release
of u-boot.  Alternately, you can hack the u-boot makefile to not build
the examples directory.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
