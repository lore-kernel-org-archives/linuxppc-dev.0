Return-Path: <linuxppc-embedded@ml.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ACF7DDDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 04:20:29 +1100 (EST)
Date: Wed, 12 Mar 2008 18:20:24 +0100
From: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
To: Timur Tabi <timur@FREESCALE.COM>
Subject: Re: Using the loop feature of the DMA controller on MPC8544 DS
Message-ID: <20080312172024.GB7255@Chamillionaire.breakpoint.cc>
References: <20080312123437.GA1589@Chamillionaire.breakpoint.cc>
	<47D7FD9D.2040202@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <47D7FD9D.2040202@freescale.com>
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

* Timur Tabi | 2008-03-12 10:58:21 [-0500]:

>Sebastian Siewior wrote:
>> Hello,
>> 
>> I have here a MPC8544 DS board and I tried to utilise the dma
>> controller. For the transfers I need set the [S|D]AHE bit in the Mode
>> Register. This seems to be implemented but is currently unused in the
>> driver. 
>
>Which driver?  Zhang's DMA driver?
Yes, fsldma.c, that's the only one in tree for the CPU unless there are
some hidden trees :)

>I haven't looked at Zhang's driver, but I just spotted this code:
>
>case FSL_DMA_IP_85XX:
>	new_fsl_chan->toggle_ext_start = fsl_chan_toggle_ext_start;
>	new_fsl_chan->toggle_ext_pause = fsl_chan_toggle_ext_pause;
>case FSL_DMA_IP_83XX:
>	new_fsl_chan->set_src_loop_size = fsl_chan_set_src_loop_size;
>	new_fsl_chan->set_dest_loop_size = fsl_chan_set_dest_loop_size;
>
>(Don't let the missing "break" from FSL_DMA_IP_85XX fool you)
>
>So it looks like there already is a way to set the SAHE and DAHE bits.  I guess
>this is what you mean by "seems to be implemented but is currently unused"?
Yes it is :)

>> I haven't found a way how to set this bit except globally for
>> the whole channel.
>
>Well, the SAHE bit is part of the MR register, so it can only apply to a whole
>channel.  This is a hardware limitation.
Argh, I hoped that could be hidden at the offset 0x1c in the link
descriptor which is marked as reserved.

>> Is it possible to solve this nicely except dedicating one channel for
>> such an operation?
>
>No.
I need to hold src & dst each with one and two bytes makes four
channels. And then I need one for normal transfers. So I guess I have to
talk to my HW ppl that we have to change something :)

Sebastian
