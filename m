Return-Path: <josh@joshtriplett.org>
Received: from slow3-v.mail.gandi.net (slow3-v.mail.gandi.net [217.70.178.89])
	by ozlabs.org (Postfix) with ESMTP id C503AB7D4C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Mar 2010 16:28:38 +1100 (EST)
Received: from relay4-v.mail.gandi.net (relay4-v.mail.gandi.net
	[217.70.178.78])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 680D43852D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Mar 2010 06:17:39 +0100 (CET)
Received: from mfilter4-v.gandi.net (mfilter4-v.gandi.net [217.70.178.38])
	by relay4-v.mail.gandi.net (Postfix) with ESMTP id 7C9DDBA1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Mar 2010 06:17:33 +0100 (CET)
Received: from relay4-v.mail.gandi.net ([217.70.178.78])
	by mfilter4-v.gandi.net (mfilter4-v.gandi.net [217.70.178.38])
	(amavisd-new, port 10024)
	with ESMTP id aiPVmvwNdwNd for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Mar 2010 06:17:33 +0100 (CET)
Received: from feather (host-246-209.pubnet.pdx.edu [131.252.246.209])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-v.mail.gandi.net (Postfix) with ESMTP id ADE9CBA17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Mar 2010 06:17:32 +0100 (CET)
Date: Tue, 16 Mar 2010 22:17:27 -0700
From: Josh Triplett <josh@joshtriplett.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: Failing to get DMA working with MPC5200 (TQM5200) and CompactFlash
Message-ID: <20100317051521.GA16826@feather>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

We've tried both 2.6.33 and DENX-v2.6.33.1, and we haven't managed to
successfully use any form of DMA with the TQM5200 and a CompactFlash
card.  We know the CF card supports DMA (or, at least, it says "UDMA"
right on the card, and various reports say Lexar Professional CF cards
do DMA), but the kernel always puts the card in PIO4 mode.  We tried
libata.force=mwdma2 and libata.force=udma2 , and many other modes, but
this always led to failures like this:

[   31.994311] ata1: lost interrupt (Status 0x58)
[   32.020435] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[   32.027712] ata1.00: failed command: READ DMA
[   32.032236] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
[   32.032249]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   32.047212] ata1.00: status: { DRDY }
[   32.051050] ata1: soft resetting link
[   32.218796] ata1.00: FORCE: xfer_mask set to udma2
[   32.230618] ata1.00: configured for UDMA/33
[   32.235000] ata1.00: device reported invalid CHS sector 0
[   32.240629] ata1: EH complete
[   62.994310] ata1: lost interrupt (Status 0x58)
[   63.020443] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[   63.027722] ata1.00: failed command: READ DMA
[   63.032246] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
[   63.032259]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   63.047221] ata1.00: status: { DRDY }
[   63.051060] ata1: soft resetting link
[   63.218778] ata1.00: FORCE: xfer_mask set to udma2
[   63.238603] ata1.00: configured for UDMA/33
[   63.242978] ata1.00: device reported invalid CHS sector 0
[   63.248609] ata1: EH complete

We have the MPC5200C revision of the silicon.

Does this sound like a known issue?  Can we do anything to troubleshoot
this further?

Thanks,
Josh Triplett and Jamey Sharp
Portland State Aerospace Society
