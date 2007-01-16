Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D9419DDE02
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 19:36:11 +1100 (EST)
In-Reply-To: <20070116042829.GA24654@iram.es>
References: <20070114225502.GA21471@austin.ibm.com>
	<17834.47158.581922.62728@cargo.ozlabs.ibm.com>
	<20070115085557.GA4943@iram.es>
	<4391e3fc8335446ddeedecb5670d4a00@kernel.crashing.org>
	<20070116042829.GA24654@iram.es>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <318e675947afbb7406839eac28083d9e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] atomic_dec_if_positive sign extension fix
Date: Tue, 16 Jan 2007 09:36:41 +0100
To: Gabriel Paubert <paubert@iram.es>
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> You can specify "cc" in the clobber list already, don't use
>> "xer" unless you're clobbering something else in the XER.
>>
>
> Hmm, I believed "cc" was an alias for cr0.

Yes it is and I'm just confused.  Sorry about that.
My excuse is that "addic." would do that to anyone ;-)

> /* PSImode is used for the XER register.  The XER register
>    is not used for anything; perhaps it should be deleted,
>    except that that would change register numbers.  */
> PARTIAL_INT_MODE (SI);
>
> in gcc/config/rs6000-modes.def is actually a bit misleading since the
> XER is often clobbered by instructions. But the XER is actually never
> exposed to the instruction scheduler: all the patterns that set and use
> the carry are simple lists of machine instructions which will be put in
> the final object without modifications (only register number and 
> possibly
> immediate value substitution).

Yes indeed.  Replacing the XER in GCC with a "carry register"
has been on my todo list for years; it is one of the last
things that still require emitting more than one machine insn
at once.


Segher
