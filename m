Date: Mon, 6 Jan 2003 08:45:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Matt Porter <porter@cox.net>
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/linuxppc-2.5
Message-ID: <20030106154523.GA796@opus.bloom.county>
References: <200301061203.EAA16917@hostme.bitkeeper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200301061203.EAA16917@hostme.bitkeeper.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jan 06, 2003 at 04:03:28AM -0800, ppc@bkbits.net wrote:

> ChangeSet@1.778, 2003-01-06 21:55:54+11:00, paulus@samba.org
>   Small walnut update: don't reference todc_* unless CONFIG_GEN_RTC
>   is set, plus minor syntax fix.
>
>   arch/ppc/platforms/4xx/walnut.c@1.9, 03-01-06 21:55:49+11:00, paulus@samba.org
>     take out parentheses in #ifdef, add #ifdef CONFIG_GEN_RTC around
>     todc_* references

Ack!  I really think this is the wrong approach, as now CONFIG_GEN_RTC=m
will still not work on Walnut (/ 40x in general).  I think what we
really need is on 40x to either mimic how the 'classic' boards do it,
and have CONFIG_WALNUT, CONFIG_ASH, etc reference todc_time.o, and
always get it, or start defining attributes like had been suggested many
times in the past (ie a walnut, ash, spruce and so on would set
CONFIG_PPC32_USE_TODC_SUPPORT or something).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
