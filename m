Message-ID: <20021204230047.98430.qmail@web40912.mail.yahoo.com>
Date: Wed, 4 Dec 2002 15:00:47 -0800 (PST)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: 4xx critical exceptions
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've seen a few postings regarding critical exceptions
on the 405GP, but I don't see anything new in the
linuxppc_2_5 versions of the relevant files.

I'm interested in using the watchdog interrupt as a
critical exception.  I have somthing that sort-of
works, in that I get wdt interrupts and service them
appropriately, but I'm getting panics on a regular
basis.

The COMMON_PROLOG in head_4xx.S uses SPRG0,1 to
temporarily save r20, r21 for scratch use.  Problem is
this prologue is used for both critical and
non-critical interrupts.  As I understand it, MSR[EE]
is cleared for external interrupts, but MSR[CE] is
not.  If a critical interrupt occurs while handling a
non-critical interrupt, the SPRG0,1 can be overwritten
while handling the critical interrupt.

I'm guessing we don't have any unused SPRGx registers
to use here.  I was thinking about temporarily
disabling CE until saving SPRG0,1, but that can't be
done without using at least one register, and none of
them are saved at that point.

Any ideas?

Regards,
Brian

P.S. BTW, is bk://ppc.bkbits.net/linuxppc_2_5 the
right place for the latest 2.5 code?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
