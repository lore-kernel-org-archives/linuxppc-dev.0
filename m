Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 2118FDDD09
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 05:23:47 +1100 (EST)
Message-ID: <45F98F28.4060708@ru.mvista.com>
Date: Thu, 15 Mar 2007 21:23:36 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Charles Krinke <ckrinke@istor.com>
Subject: Re: Exception in kernel mode
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A198@MERCURY.inside.istor.com>
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A198@MERCURY.inside.istor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hello.

Charles Krinke wrote:

>     Obviously, you've got an exception in the decrementer exception
> handler 
> itself -- and this was something like program check exception, judging
> on the 
> signal you've got (SIGILL).

>>So, with that said:

>>"What might be the causes of such an exception from the decrementer in a

>>2.6.17.11 ppc8241 kernel?"

>>"Where should one concentrate ones efforts in figuring this out?"

>     Hrm, looks like some CPU errata maybe...

    Please, tune message quoting in your mailer.

> Thank you very much for the great hint. I have a follow-up question.

> I can see from arch/ppc/kernel/head.S that the EXCEPTION_PROLOG macro is
> the first instruction in the decrementer ISR and it says (amongst other
> things):

> mtspr SPRN_SPRG0, r10 
> mtspr SPRN_SPRG1, r11

> Which is, I believe, moving r10 to SPRG0 and r11 to SPRG1.

> So, how do we know that r10 and r11 are always valid in an interrupt
> context? Are we setting aside r10 and r11 somewhere else in

    That doesn't matter to kernel at all -- they are just *saved* in SPRG regs 
to avoid being trashed by the exception handler.

WBR, Sergei
