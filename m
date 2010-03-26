Return-Path: <glikely@secretlab.ca>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by ozlabs.org (Postfix) with ESMTP id 32CF8B7CED
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Mar 2010 05:22:53 +1100 (EST)
Received: by pvg12 with SMTP id 12so4537208pvg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Mar 2010 11:22:52 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100317051521.GA16826@feather>
References: <20100317051521.GA16826@feather>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 26 Mar 2010 12:22:32 -0600
Message-ID: <fa686aa41003261122s7c03244bm2ffc3347263af613@mail.gmail.com>
Subject: Re: Failing to get DMA working with MPC5200 (TQM5200) and
	CompactFlash
To: Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 16, 2010 at 11:17 PM, Josh Triplett <josh@joshtriplett.org> wro=
te:
> Hello,
>
> We've tried both 2.6.33 and DENX-v2.6.33.1, and we haven't managed to
> successfully use any form of DMA with the TQM5200 and a CompactFlash
> card. =A0We know the CF card supports DMA (or, at least, it says "UDMA"
> right on the card, and various reports say Lexar Professional CF cards
> do DMA), but the kernel always puts the card in PIO4 mode. =A0We tried
> libata.force=3Dmwdma2 and libata.force=3Dudma2 , and many other modes, bu=
t
> this always led to failures like this:
>
> [ =A0 31.994311] ata1: lost interrupt (Status 0x58)
> [ =A0 32.020435] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x=
6 frozen
> [ =A0 32.027712] ata1.00: failed command: READ DMA
> [ =A0 32.032236] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 d=
ma 4096 in
> [ =A0 32.032249] =A0 =A0 =A0 =A0 =A0res 40/00:00:00:00:00/00:00:00:00:00/=
00 Emask 0x4 (timeout)
> [ =A0 32.047212] ata1.00: status: { DRDY }
> [ =A0 32.051050] ata1: soft resetting link
> [ =A0 32.218796] ata1.00: FORCE: xfer_mask set to udma2
> [ =A0 32.230618] ata1.00: configured for UDMA/33
> [ =A0 32.235000] ata1.00: device reported invalid CHS sector 0
> [ =A0 32.240629] ata1: EH complete
> [ =A0 62.994310] ata1: lost interrupt (Status 0x58)
> [ =A0 63.020443] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x=
6 frozen
> [ =A0 63.027722] ata1.00: failed command: READ DMA
> [ =A0 63.032246] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 d=
ma 4096 in
> [ =A0 63.032259] =A0 =A0 =A0 =A0 =A0res 40/00:00:00:00:00/00:00:00:00:00/=
00 Emask 0x4 (timeout)
> [ =A0 63.047221] ata1.00: status: { DRDY }
> [ =A0 63.051060] ata1: soft resetting link
> [ =A0 63.218778] ata1.00: FORCE: xfer_mask set to udma2
> [ =A0 63.238603] ata1.00: configured for UDMA/33
> [ =A0 63.242978] ata1.00: device reported invalid CHS sector 0
> [ =A0 63.248609] ata1: EH complete
>
> We have the MPC5200C revision of the silicon.
>
> Does this sound like a known issue? =A0Can we do anything to troubleshoot
> this further?

Not all CF adapters have all the pins wired up that are needed for
*DMA modes.  That is the most likely problem.

g.
