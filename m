Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B54ABDDD09
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 05:19:11 +1100 (EST)
Subject: RE: Exception in kernel mode
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 15 Mar 2007 11:19:08 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A198@MERCURY.inside.istor.com>
In-Reply-To: <45F96BCD.4050401@ru.mvista.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Cc: Chris Carlson <ccarlson@istor.com>, Kevin Smith <ksmith@istor.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


    Obviously, you've got an exception in the decrementer exception
handler=20
itself -- and this was something like program check exception, judging
on the=20
signal you've got (SIGILL).

> So, with that said:

> "What might be the causes of such an exception from the decrementer in
a
> 2.6.17.11 ppc8241 kernel?"

> "Where should one concentrate ones efforts in figuring this out?"

    Hrm, looks like some CPU errata maybe...

WBR, Sergei

Thank you very much for the great hint. I have a follow-up question.

I can see from arch/ppc/kernel/head.S that the EXCEPTION_PROLOG macro is
the first instruction in the decrementer ISR and it says (amongst other
things):

mtspr SPRN_SPRG0, r10=20
mtspr SPRN_SPRG1, r11

Which is, I believe, moving r10 to SPRG0 and r11 to SPRG1.

So, how do we know that r10 and r11 are always valid in an interrupt
context? Are we setting aside r10 and r11 somewhere else in
initialization for this purpose? I have looked at the -ffixed-r2 in the
CFLAGS and see it is set aside, but it doesn't appear the build process
sets r10 & r11 aside for the exclusive use of interrupt routines. Is
there a shadow register set in the 8241 I havent appreciated yet?

I have to admit that I am only modestly familiar with the ppc family but
would appreciate any insight to understand how this interrupt code
works.

Charles
