Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 443EAB6F65
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Dec 2011 09:59:20 +1100 (EST)
Message-ID: <1323385148.19891.5.camel@pasglop>
Subject: Re: ibm_newemac tx problem with jumbo frame enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Prashant Bhole <prashantsmailcenter@gmail.com>
Date: Fri, 09 Dec 2011 09:59:08 +1100
In-Reply-To: <CAD6p20eC22MUMjbnDW55mfkojrBTWLwvMDjpM-DPZYcgxKTbZg@mail.gmail.com>
References: <CAD6p20dmksH7YEjijdqLRG06aigaKTpzLPdoL0SCNGD3Ji9d2A@mail.gmail.com>
 <1322198727.32635.25.camel@pasglop>
 <CAD6p20chCnh+PN5ekPz20BJQMdTaisb5toLA9rySaYJTeivRfQ@mail.gmail.com>
 <1323295383.12793.3.camel@pasglop>
 <CAD6p20eC22MUMjbnDW55mfkojrBTWLwvMDjpM-DPZYcgxKTbZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Tirumala Marri <tmarri@apm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-12-08 at 18:31 +0530, Prashant Bhole wrote:

> 
> I checked RX descriptor status and TX descriptor status and ethtool
> output.
> However I don't know about pause packet/frame, how do I check if pause
> frames are properly negotiated on both sides? 
> I need to try changing pause and FIFO thresholds.
> 
> ethtool output after disconnection is as follows:
> # ethtool -S eth0
> NIC statistics:
>      rx_packets: 330939
>      rx_bytes: 804963241
>      tx_packets: 248554
>      tx_bytes: 798853638
>      rx_packets_csum: 330716
>      tx_packets_csum: 179526
>      tx_undo: 0

 .../...

Ok so none of the error counters seem to trip, odd. No idea what's up,
you may want to ask the folks at APM (CCed Tirumala).

I wonder also if we are properly enabling the reporting of error
interrupts... if we got that wrong we may never detect FIFO overruns.
What you describe really looks like a fifo overrun to me.

Additionally, look at emac_configure(), sees how it configures the pause
packet thresholds, maybe you can tweak the watermark to be more
aggressive. Also check that pause is actually enabled (with ethtool) and
that the PHY negociated it properly (that the link partner supports
pause frames).

Cheers,
Ben.
