Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5AD7EDDF88
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 06:31:43 +1000 (EST)
Date: Wed, 21 May 2008 13:25:52 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
In-Reply-To: <je3aocdqxh.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.64.0805211300590.5706@t2.domain.actdsltmp>
References: <1211316025-29069-1-git-send-email-tpiepho@freescale.com>
	<jeiqx83ab0.fsf@sykes.suse.de>
	<Pine.LNX.4.64.0805201502000.7453@t2.domain.actdsltmp>
	<jeabik385g.fsf@sykes.suse.de>
	<Pine.LNX.4.64.0805201612240.7453@t2.domain.actdsltmp>
	<je3aocdqxh.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 21 May 2008, Andreas Schwab wrote:
> Trent Piepho <tpiepho@freescale.com> writes:
>> On Wed, 21 May 2008, Andreas Schwab wrote:
>>> Trent Piepho <tpiepho@freescale.com> writes:
>>>> It's the _le versions that have a problem, since we can't get gcc to just use
>>>> the register indexed mode.  It seems like an obvious thing to have a
>>>> constraint for, but I guess there weren't enough instructions that only come
>>>> in 'x' versions to bother with it.  There is a 'Z' constraint, "Memory operand
>>>> that is an indexed or indirect from a register", but I tried it and it can use
>>>> both "rb,ri" and "disp(rb)" forms.  Actually, I'm not sure how 'Z' is any
>>>> different than "m"?
>>>
>>> 'Z' will never emit a non-zero constant displacement.
>>
>> It's too bad gas doesn't appear to be smart enough to turn:
>>         stwbrx 0, 0(3)   -or-   stwbr 0, 0(3)
>
> Use the %y modifier when substituting the operand.

Of course, the undocumented y modifier!  "Print AltiVec or SPE memory operand"
Why didn't I think of that?

That appears to work.  I can get gcc to to emit 0,reg and reg,reg but not
disp(reg).  It won't try to use an "update" address either, though it will
with an "m" constraint.

But, gcc 4.0.2 can't handle the 'Z' constraint.  It looks like it's not
supported.  Other than this, I can build a kernel with 4.0.2 that appears to
work.  Is it ok to break compatibility with 4.0.2, or should I put in a gcc
version check?
