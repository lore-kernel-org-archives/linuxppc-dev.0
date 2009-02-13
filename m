Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1BB80DDED6
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 01:42:40 +1100 (EST)
Date: Fri, 13 Feb 2009 17:42:38 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: [PATCH 10/11] sdhci: Add quirk for Freescale eSDHC controllers
Message-ID: <20090213144238.GA12304@oksana.dev.rtsoft.ru>
References: <20090206180520.GA16123@oksana.dev.rtsoft.ru>
	<20090206180701.GJ11548@oksana.dev.rtsoft.ru>
	<20090208221209.628ae782@mjolnir.drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090208221209.628ae782@mjolnir.drzeus.cx>
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 08, 2009 at 10:12:09PM +0100, Pierre Ossman wrote:
> On Fri, 6 Feb 2009 21:07:01 +0300
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > This patch adds SDHCI_QUIRK_FSL quirk. The quirk is used to instruct
> > the sdhci driver about various FSL eSDHC host incompatibilities:
> > 
> 
> No device quirks please. They should be for specific bugs, not lumping
> things together like this. Otherwise we'll soon have an unmanageable
> mess.

OK.

> > 1) FSL eSDHC controllers can support maximum block size up to 4096
> >    bytes. The MBL (Maximum Block Length) field in the capabilities
> >    register extended by one bit.
> > 
> >    (Should we implement a dedicated quirk for this? I.e.
> >     SDHCI_QUIRK_MAX_BLK_SZ_4096?)
> > 
> 
> Yes please. It would have to mean "always support 4096" though, not
> "turn reserved bit 18 into a block length bit".

OK.

> > 2) sdhci_init() is needed after error conditions.
> > 
> >    (Can we safely do this for all controllers?)
> > 
> 
> Please investigate which part of sdhci_init() is needed. How does it
> break without this?

After reset eSDHC lose signal/interrupt enable states:

Before reset:

sdhci: ============== REGISTER DUMP ==============
sdhci: Sys addr: 0x00000008 | Version:  0x00000000
sdhci: Blk size: 0x00000008 | Blk cnt:  0x00000000
sdhci: Argument: 0x000001aa | Trn mode: 0x00000000
sdhci: Present:  0xff850000 | Host ctl: 0x00000021
sdhci: Power:    0x00000000 | Blk gap:  0x00000000
sdhci: Wake-up:  0x00000000 | Clock:    0x00001077
sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
sdhci: Int enab: 0x007f0003 | Sig enab: 0x007f0003
sdhci: AC12 err: 0x00000000 | Slot int: 0x00000001
sdhci: Caps:     0x01e30000 | Max curr: 0x00000000
sdhci: ===========================================

after sdhci_reset(host, SDHCI_RESET_CMD):

sdhci: ============== REGISTER DUMP ==============
sdhci: Sys addr: 0x00000008 | Version:  0x00000000
sdhci: Blk size: 0x00000008 | Blk cnt:  0x00000000
sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
sdhci: Present:  0xff850000 | Host ctl: 0x00000021
sdhci: Power:    0x00000000 | Blk gap:  0x00000000
sdhci: Wake-up:  0x00000000 | Clock:    0x00001077
sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
sdhci: Int enab: 0x017f0003 | Sig enab: 0x00700002
sdhci: AC12 err: 0x00000000 | Slot int: 0x00000001
sdhci: Caps:     0x01e30000 | Max curr: 0x00000000
sdhci: ===========================================

After sdhci_reset(host, SDHCI_RESET_DATA):

sdhci: ============== REGISTER DUMP ==============
sdhci: Sys addr: 0x00000008 | Version:  0x00000000
sdhci: Blk size: 0x00000008 | Blk cnt:  0x00000000
sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
sdhci: Present:  0xff850000 | Host ctl: 0x00000021
sdhci: Power:    0x00000000 | Blk gap:  0x00000000
sdhci: Wake-up:  0x00000000 | Clock:    0x00001077
sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
sdhci: Int enab: 0x117f003f | Sig enab: 0x00000000
sdhci: AC12 err: 0x00000000 | Slot int: 0x00000001
sdhci: Caps:     0x01e30000 | Max curr: 0x00000000
sdhci: ===========================================

> > 3) Small udelay is needed to make eSDHC work in PIO mode. Without
> >    the delay reading causes endless interrupt storm, and writing
> >    corrupts data. The first guess would be that we must wait for
> >    some bit in some register, but I didn't find any reliable bits
> >    that changes before and after the delay. Though, more investigation
> >    on this is in my todo list.
> 
> Please try to investigate more, but if you cannot improve it further
> then a specific quirk can be added.

No luck so far... :-/


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
