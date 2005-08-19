Return-Path: <adgospod@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.193])
	by ozlabs.org (Postfix) with ESMTP id B54DE67F91
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Aug 2005 05:47:56 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i11so622961wra
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 12:47:55 -0700 (PDT)
Message-ID: <bdfc5d6e05081912406b1a3840@mail.gmail.com>
Date: Fri, 19 Aug 2005 15:40:42 -0400
From: "Andy G." <adgospod@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: SIGFPE on 8245
Reply-To: andy@greyhouse.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm working with a rather large multi-threaded application that after
a several hour run will often produce a floating point exception
(specifically a divide by zero exception).  I've manged to catch the
signal and use some home grown code to examine the current state of
the running thread as well as all of the others, but sadly this debug
information never provides any valuable information.  It appears as
though the crash is happening in the pthread library when trying to
execute a floating point store instruction (0x8114 listed below).

00008108 <__pthread_timedsuspend_new>:
8108:       7d 80 00 26     mfcr    r12
810c:       94 21 fc 90     stwu    r1,-880(r1)
8110:       7c 08 02 a6     mflr    r0                                     =
    =20
8114:       d9 c1 02 e0     stfd    f14,736(r1)  <--- SIGFPE happens here  =
=20

After looking over the 32-bit PPC Programming Env Manual it seems to
me that the floating point operations that result in +/- infinity will
disable the FPU and write the FPECR with the cause.  Next time a
floating point instruction is attempted we will get an exception since
the FPU is disabled and then we will throw the exception.

This information unfortunately tells me that I have to start digging
through the source code to find the programming error, but I'm hoping
I'm wrong about this.  Any advice or tips?

Thanks in advance,

-andy
