Date: Wed, 4 Dec 2002 17:11:53 -0700
From: Matt Porter <porter@cox.net>
To: Brian Kuschak <bkuschak@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 4xx critical exceptions
Message-ID: <20021204171152.A11934@home.com>
References: <20021204230047.98430.qmail@web40912.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021204230047.98430.qmail@web40912.mail.yahoo.com>; from bkuschak@yahoo.com on Wed, Dec 04, 2002 at 03:00:47PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 04, 2002 at 03:00:47PM -0800, Brian Kuschak wrote:

<snip>

> The COMMON_PROLOG in head_4xx.S uses SPRG0,1 to
> temporarily save r20, r21 for scratch use.  Problem is
> this prologue is used for both critical and
> non-critical interrupts.  As I understand it, MSR[EE]
> is cleared for external interrupts, but MSR[CE] is
> not.  If a critical interrupt occurs while handling a
> non-critical interrupt, the SPRG0,1 can be overwritten
> while handling the critical interrupt.
>
> I'm guessing we don't have any unused SPRGx registers
> to use here.  I was thinking about temporarily
> disabling CE until saving SPRG0,1, but that can't be
> done without using at least one register, and none of
> them are saved at that point.
>
> Any ideas?

The linuxppc-2.5 tree has a (partial) implementation of critical
exceptions.  The method used is to save the registers into a
region preallocated in head_*.S.

> P.S. BTW, is bk://ppc.bkbits.net/linuxppc_2_5 the
> right place for the latest 2.5 code?

That's a dead tree.  You want bk://ppc.bkbits.net/linuxppc-2.5

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
