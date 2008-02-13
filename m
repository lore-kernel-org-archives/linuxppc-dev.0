Return-Path: <dhbaird@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 01F7EDDEE0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Feb 2008 05:32:10 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so149856wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Feb 2008 10:32:09 -0800 (PST)
Message-ID: <440abda90802131032l6e11eef7gbd7eb57352c2ce4@mail.gmail.com>
Date: Wed, 13 Feb 2008 11:32:07 -0700
From: "David Baird" <dhbaird@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: TLB Miss booting linux kernel on ppc 405
In-Reply-To: <5ee408090802131003m4b8e632cu931769bc77f9b439@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5ee408090802130850w130ce09an507ca5c4d41cc5a8@mail.gmail.com>
	<440abda90802130917x79c3c990j6a1fc7c12ba05ed7@mail.gmail.com>
	<5ee408090802130938u7d069636g42a496e489fe5b80@mail.gmail.com>
	<440abda90802130951h7a23743asc85454bf089c7e55@mail.gmail.com>
	<5ee408090802131003m4b8e632cu931769bc77f9b439@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Feb 13, 2008 11:03 AM, Ricardo Ayres Severo <severo.ricardo@gmail.com> wrote:
> Here are the srr dump:
>   srr0: c0002218
>   srr1: 00021030
>   srr2: 00001154
>   srr3: 00000000

Okay, SRR0 tells us that you did in fact have an exception at
0xc0002218.  And I am willing to bet that is the line you mentioned
(line 826 of start_here).  You can match this up with your System.map
or an objdump -d of vmlinux.

Someone who knows more than I do can correct me on this, but I have a
suspicion.  As soon virtual (translation) mode is entered, I have had
a hard time using the normal debugging functions (e.g. single
instruction stepping and reading memory regions).  While in virtual
mode, it seemed like I had to resort to these techniques:

- Blinking some LEDs
- Spitting characters out of a uartlite
- When an exception occurs, the processor switches back into real mode
and therefore I can set breakpoints on the beginnings of various
exception handlers and be able to use normal debugging tools again

So, I have another question.  Can you set a breakpoint on 0x1100 (in
XMD: bps 0x1100 hw), then just let it run (i.e. do not single step!)
all the way until an exception happens.  When the exception happens,
can you then paste the SRR0, SRR1, and the ESR (exception syndrome
register)?

I hope I am not giving you a run-around here....

-David
