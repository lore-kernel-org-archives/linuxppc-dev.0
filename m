Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 6A9CFB708B
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Dec 2010 01:52:15 +1100 (EST)
Subject: Re: [MPC52xx]Latency issue with DMA on FEC
From: Steven Rostedt <rostedt@goodmis.org>
To: Jean-Michel Hautbois <jhautbois@gmail.com>
In-Reply-To: <AANLkTi=vAEcPKLqJ_yJt7NLz5JoYvEnt8S8QB99ZBNSX@mail.gmail.com>
References: <AANLkTi=vAEcPKLqJ_yJt7NLz5JoYvEnt8S8QB99ZBNSX@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 01 Dec 2010 09:52:10 -0500
Message-ID: <1291215130.4881.55.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, linux-rt-users@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-12-01 at 09:16 +0100, Jean-Michel Hautbois wrote:
> Hi lists !
> 
> I measured the latency and the jitter of the RX and TX ethernet paths
> on my MPC5200 board.
> The RX path is quite good, but the TX path can be slow.
> 
> [ 1218.976762] [mpc52xx_fec_start_xmit]Delay >30us for dma_map_single
> => 76364 ns
> [ 1219.188405] [mpc52xx_fec_tx_interrupt]Delay >30us for
> dma_unmap_single => 34515 ns
> [ 1220.628785] [mpc52xx_fec_start_xmit]Delay >30us for
> bcom_submit_next_buffer => 97273 ns
> [ 1225.776784] [mpc52xx_fec_tx_interrupt]Delay >30us for
> dma_unmap_single => 95273 ns
> 
> As one can see, this is obviously problematic.
> The first function I analyzed is bcom_submit_next_buffer() => This
> function doesn't do lots of things, except a call to mb().
> 
> I have been looking to the "MPC603e RISC Microprocessor User's Manual"
> and especially the chapter named "2.3.4.7 Memory Synchronization
> Instructions—UISA".
> 
> Here is a paragraph which explains a lot :
> 
> "The functions performed by the sync instruction normally take a
> signiﬁcant amount of time
> to complete; as a result, frequent use of this instruction may
> adversely affect performance.
> In addition, the number of cycles required to complete a sync
> instruction depends on system
> parameters and on the processor's state when the instruction is issued."
> 
> I am using a real time kernel, and this is a problem, as it is not
> deterministic to use this instruction.
> Is there a way to avoid this ?

Don't use that hardware.

When working with drivers there are times you must sync with the device.
And if the device is nondeterministic, then find another set of hardware
to use. Unfortunately, I think you may not find any.

A mb() is usually used if you do a write to device and read from it.
With out it, the CPU could perform the read before the write, which
would give you an incorrect result. There's no other way around that.

-- Steve

> 
> I will now focus on the dma_map_single() and dma_unmap_single functions...
> 
> Thanks in advance for your help,
> Best Regards,
> 
> JM
