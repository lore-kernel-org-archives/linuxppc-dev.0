Return-Path: <jhautbois@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id EB2EEB708B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Dec 2010 20:59:14 +1100 (EST)
Received: by wyf28 with SMTP id 28so9227830wyf.15
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Dec 2010 01:59:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=vAEcPKLqJ_yJt7NLz5JoYvEnt8S8QB99ZBNSX@mail.gmail.com>
References: <AANLkTi=vAEcPKLqJ_yJt7NLz5JoYvEnt8S8QB99ZBNSX@mail.gmail.com>
Date: Wed, 1 Dec 2010 10:59:12 +0100
Message-ID: <AANLkTimnxhzdpuixSaN=g2bVo2gT8Ys1qxQQ6X_AX5bV@mail.gmail.com>
Subject: Re: [MPC52xx]Latency issue with DMA on FEC
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Cc: Eric Dumazet <eric.dumazet@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/12/1 Jean-Michel Hautbois <jhautbois@gmail.com>:
> Hi lists !
>
> I measured the latency and the jitter of the RX and TX ethernet paths
> on my MPC5200 board.
> The RX path is quite good, but the TX path can be slow.
>
> [ 1218.976762] [mpc52xx_fec_start_xmit]Delay >30us for dma_map_single
> =3D> 76364 ns
> [ 1219.188405] [mpc52xx_fec_tx_interrupt]Delay >30us for
> dma_unmap_single =3D> 34515 ns
> [ 1220.628785] [mpc52xx_fec_start_xmit]Delay >30us for
> bcom_submit_next_buffer =3D> 97273 ns
> [ 1225.776784] [mpc52xx_fec_tx_interrupt]Delay >30us for
> dma_unmap_single =3D> 95273 ns
>
> As one can see, this is obviously problematic.
> The first function I analyzed is bcom_submit_next_buffer() =3D> This
> function doesn't do lots of things, except a call to mb().
>
> I have been looking to the "MPC603e RISC Microprocessor User's Manual"
> and especially the chapter named "2.3.4.7 Memory Synchronization
> Instructions=E2=80=94UISA".
>
> Here is a paragraph which explains a lot :
>
> "The functions performed by the sync instruction normally take a
> signi=EF=AC=81cant amount of time
> to complete; as a result, frequent use of this instruction may
> adversely affect performance.
> In addition, the number of cycles required to complete a sync
> instruction depends on system
> parameters and on the processor's state when the instruction is issued."
>
> I am using a real time kernel, and this is a problem, as it is not
> deterministic to use this instruction.
> Is there a way to avoid this ?
>
> I will now focus on the dma_map_single() and dma_unmap_single functions..=
.
>
> Thanks in advance for your help,
> Best Regards,
>
> JM
>

dma_map_single() and dma_unmap_single() have the same instruction set
used inside (sync) because there is a cleaning of cache.
eieio instruction doesn't seem to be faster and I think that because
cache is not inhibited, this is not a good way to do that.

The delay introduced by the use of these instructions can be really
big (about 70-90=C2=B5s) whereas in most cases it is relatively good (about
10-20=C2=B5s).
This jitter is a problem in my use case, and I think I am not the only one =
:).

One other thing to say : I am using little packets (about 200 bytes).

JM
