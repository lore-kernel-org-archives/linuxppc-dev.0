Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 9E3DEDE876
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 02:38:29 +1000 (EST)
Date: Mon, 14 Apr 2008 20:31:46 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] mpc8315: fix USB UTMI Host setup
Message-ID: <20080414163146.GA25082@polina.dev.rtsoft.ru>
References: <20080409135925.GA6905@polina.dev.rtsoft.ru>
	<5545B104-1D7C-4A35-B6AD-7C895CBE9A2F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <5545B104-1D7C-4A35-B6AD-7C895CBE9A2F@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 14, 2008 at 10:22:46AM -0500, Kumar Gala wrote:
>
> On Apr 9, 2008, at 8:59 AM, Anton Vorontsov wrote:
>> Currently USB Host isn't functional on the MPC8315E boards, for two
>> reasons as described below.
>>
>> MPC8315 Reference Manual says:
>> "The USB DR unit must have the same clock ratio as the encryption core
>> unit, unless one of them has its clock disabled."
>>
>> The encryption core also drives I2C clock, so it is enabled and is  
>> equal
>> to 01. That means USBDRCM should be 01 here.
>>
>> Plus, according to MPC8315E-RDB schematics, USB unit consumes CLK_IN
>> clock from the 24.00MHz oscillator, which means we must adjust REFSEL
>> bits as well.
>
> Can you add a comment in the code about the fact that part of this fix  
> is board specific.

Heh, the whole 83xx/usb.c file is board(s) specific, not this particular
fix. :-/

So it doesn't need an explicit comment for this addition. It's just lucky
coincedence that all previous boards were using same (or similar) setup.
That is, it's perfectly possible that some custom MPC831XE board will use
USB setup different from MPC8313E-RDB or MPC8315E-RDB, and the whole thing
will break again. The same applies for MPC837X part of usb.c. There are
board-specific settings all over the place.
