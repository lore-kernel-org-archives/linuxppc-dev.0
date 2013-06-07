Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CC83D2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jun 2013 08:40:05 +1000 (EST)
Message-ID: <1370644793.3766.423.camel@pasglop>
Subject: Re: FSL 64-bit DMA window question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Sat, 08 Jun 2013 08:39:53 +1000
In-Reply-To: <1370644475.6813.17@snotra>
References: <1370644475.6813.17@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>, Timur Tabi <timur@tabi.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-06-07 at 17:34 -0500, Scott Wood wrote:
> > You also need to account for other on-chip MMIOs no ? Or do you never
> > intend to let PCI devices hit them ?
> 
> I don't think we normally need that (other than MSIs, which have a  
> special window under 4G)...  The question is whether it's better to let  
> odd use cases work without having to manually move the DMA window, at  
> the cost of decreased out-of-the-box performance with common PCIe cards.

Sorry, I didn't parse what the tradeoff is here...

Putting the inbound window above memory seems like a reasonable option then
(at least as a default that the board can override).

I sincerely hope those radeons are the only remaining things with that sort of
limitation but you never know ... it's all x86 fault of course for never having
used high DMA windows :-)

Cheers,
Ben.
