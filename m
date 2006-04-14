Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17472.984.760483.334447@cargo.ozlabs.ibm.com>
Date: Fri, 14 Apr 2006 13:19:36 -0700
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: 7447A strange problem with MSR:POW (WAS: can't boot 2.6.17-rc1)
In-Reply-To: <20060414195436.GC24769@pb15.lixom.net>
References: <Pine.LNX.4.44.0604071010290.18017-100000@zirkon.biophys.uni-duesseldorf.de>
	<1144408805.30891.42.camel@localhost.localdomain>
	<17463.9759.442768.685153@cargo.ozlabs.ibm.com>
	<1144923633.4935.11.camel@localhost.localdomain>
	<21F7D7D8-B9BC-44EB-B07B-F888D89DCF25@freescale.com>
	<17471.62187.774127.783000@cargo.ozlabs.ibm.com>
	<20060414195436.GC24769@pb15.lixom.net>
Cc: Becky Bruce <Becky.Bruce@freescale.com>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> Where is cr0 set now -- you took the dot off of rlwinm?

transfer_to_handler does mfspr r11,SPRN_HID0; mtcr r11 before jumping
to power_save_6xx_restore.  The rlwinm. was wrong anyway since it was
setting cr0.eq based on all the *other* bits in HID0, not HID0_NAP
(doh!).

Paul.
