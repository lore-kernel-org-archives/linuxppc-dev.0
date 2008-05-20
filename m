Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3675CDE133
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 08:16:13 +1000 (EST)
Date: Tue, 20 May 2008 15:11:02 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
In-Reply-To: <jeiqx83ab0.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.64.0805201502000.7453@t2.domain.actdsltmp>
References: <1211316025-29069-1-git-send-email-tpiepho@freescale.com>
	<jeiqx83ab0.fsf@sykes.suse.de>
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
>
>> For the LE versions, eventually they boil down to an asm that will look
>> something like this:
>> asm("sync; stwbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
>>
>> While not perfect, this appears to be the best one can do.  The issue is
>> that the "stwbrx" instruction only comes in an indexed, or 'x', version, in
>> which the address is represented by the sum of two registers (the "0,%2").
>> Unfortunately, gcc doesn't have a constraint for an indexed memory
>> reference.
>
> There is the "Z" constraint, which matches either an indirect or an
> indexed memory address.  That should fit here.

This came up on the Freescale list.  I should have put what I wrote there into
my patch descrition:

It's the _le versions that have a problem, since we can't get gcc to just use
the register indexed mode.  It seems like an obvious thing to have a
constraint for, but I guess there weren't enough instructions that only come
in 'x' versions to bother with it.  There is a 'Z' constraint, "Memory operand
that is an indexed or indirect from a register", but I tried it and it can use
both "rb,ri" and "disp(rb)" forms.  Actually, I'm not sure how 'Z' is any
different than "m"?
