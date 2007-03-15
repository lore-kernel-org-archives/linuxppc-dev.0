Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 24674DDD0D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 02:53:01 +1100 (EST)
Message-ID: <45F96BCD.4050401@ru.mvista.com>
Date: Thu, 15 Mar 2007 18:52:45 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Charles Krinke <ckrinke@istor.com>
Subject: Re: Exception in kernel mode
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A197@MERCURY.inside.istor.com>
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A197@MERCURY.inside.istor.com>
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

> I have a PPC8241 which does an 

> Oops: Exception in kernel mode, sig: 4 [#1]
> PREEMPT
> NIP: 00000900 LR: C00E579C CTR: 00003A55

> When doing a 'tar -xvzf'. The NIP is pointing at the decrementer
> interrupt, I believe.

> As I understand the decrementer, this is basically the timer tick in the
> ppc and goes off every n ms continuously. 

> A tar is going to be concerned with date/time stamps on files, so it has
> some interaction with the clock algorithms.

> It seems to me that the decrementer should be able to go off at any time
> during kernel operation, so maybe the "Exception in kernel mode" is
> pointing us in an unusual direction.

    Obviously, you've got an exception in the decrementer exception handler 
itself -- and this was something like program check exception, judging on the 
signal you've got (SIGILL).

> So, with that said:

> "What might be the causes of such an exception from the decrementer in a
> 2.6.17.11 ppc8241 kernel?"

> "Where should one concentrate ones efforts in figuring this out?"

    Hrm, looks like some CPU errata maybe...

WBR, Sergei
