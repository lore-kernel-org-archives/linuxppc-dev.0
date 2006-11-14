Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id C284267D1B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 21:14:44 +1100 (EST)
Date: Tue, 14 Nov 2006 11:02:35 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: lite5200b low power mode and self refresh
Message-ID: <20061114100235.GA7694@domen-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

I'm trying to implement low power mode on lite5200b board
(everything but sdram is powered off), and I seem to have
problems with putting ram to self-refresh.

As far as I can tell I'm following datasheets, but if it
sleeps for a day or so, contents of RAM get cleared to
zeroes (I get 0x02800100 and similar patterns).

Any ideas, tips, comments... anything really, is appreaciated.

I'm also interested in mpc5200 "deep sleep", anyone had any
success?


Thanks!

	Domen


Code for low power mode via "QT" chip. It is ran from flash,
since sdram isn't accessible after this.

        // put sdram into self-refresh
        lis     r5, 0xf000
        ori     r5, r5, 0x100
        lwz     r4, 0x4(r5)
        oris    r4, r4, 0x8000
        stw     r4, 0x4(r5)     // mode_en
        sync

        ori     r4, r4, 0x0002  // setup soft_pre

        lis     r6, 0xbfff
        ori     r6, r6, 0xffff
        and     r6, r4, r6      // setup !cke
        oris    r6, r6, 0x1000  // setup ref_en

        stw     r4, 0x4(r5)     // soft_pre
        sync

        stw     r6, 0x4(r5)     // ref_en !cke
        sync

        clrlwi  r6, r6, 1       // !mode_en
        stw     r6, 0x4(r5)
        sync

        // turn off with QT chip
        lis     r3, 0xf000
        ori     r3, r3, 0x0c00
        li      r4, 0x02
        stb     r4, 0(r3)       // enable gpio_wkup1
        sync
        stb     r4, 8(r3)       // output
        sync
        stb     r4, 0xc(r3)     // output high
        sync

        lis     r5, 0x0001
delay_10us:
        addi    r5, r5, -1
        cmpi    cr7, r5, 0
        bne     cr7, delay_10us
        sync

        // turn off
        li      r4, 0
        stb     r4, 0xc(r3)     // output low
        sync
