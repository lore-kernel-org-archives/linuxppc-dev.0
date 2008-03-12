Return-Path: <timur@FREESCALE.COM>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7B1BDDDF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 03:31:44 +1100 (EST)
Message-ID: <47D7FD9D.2040202@freescale.com>
Date: Wed, 12 Mar 2008 10:58:21 -0500
From: Timur Tabi <timur@FREESCALE.COM>
MIME-Version: 1.0
To: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
Subject: Re: Using the loop feature of the DMA controller on MPC8544 DS
References: <20080312123437.GA1589@Chamillionaire.breakpoint.cc>
In-Reply-To: <20080312123437.GA1589@Chamillionaire.breakpoint.cc>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org, Zhang Wei <wei.zhang@FREESCALE.COM>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sebastian Siewior wrote:
> Hello,
> 
> I have here a MPC8544 DS board and I tried to utilise the dma
> controller. For the transfers I need set the [S|D]AHE bit in the Mode
> Register. This seems to be implemented but is currently unused in the
> driver. 

Which driver?  Zhang's DMA driver?

I haven't looked at Zhang's driver, but I just spotted this code:

case FSL_DMA_IP_85XX:
	new_fsl_chan->toggle_ext_start = fsl_chan_toggle_ext_start;
	new_fsl_chan->toggle_ext_pause = fsl_chan_toggle_ext_pause;
case FSL_DMA_IP_83XX:
	new_fsl_chan->set_src_loop_size = fsl_chan_set_src_loop_size;
	new_fsl_chan->set_dest_loop_size = fsl_chan_set_dest_loop_size;

(Don't let the missing "break" from FSL_DMA_IP_85XX fool you)

So it looks like there already is a way to set the SAHE and DAHE bits.  I guess
this is what you mean by "seems to be implemented but is currently unused"?

> I haven't found a way how to set this bit except globally for
> the whole channel.

Well, the SAHE bit is part of the MR register, so it can only apply to a whole
channel.  This is a hardware limitation.

> Is it possible to solve this nicely except dedicating one channel for
> such an operation?

No.

-- 
Timur Tabi
Linux kernel developer at Freescale
