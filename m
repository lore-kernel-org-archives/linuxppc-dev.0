Return-Path: <pku.leo@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id 90317DDDA5
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 20:36:38 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so2217584wfg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 02:36:36 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <OF6D5FFE1D.1843C7FE-ONC1257589.00328D91-C1257589.00336B8B@transmode.se>
References: <1237987849.2194.9.camel@gentoo-jocke.transmode.se>
	<20090325142540.GA20944@oksana.dev.rtsoft.ru>
	<OF3C4E8131.4223FD1A-ONC1257584.0061D2E6-C1257584.0062233E@transmode.se>
	<2a27d3730903300134q673de9cbg6c92e981efc12695@mail.gmail.com>
	<OF6D5FFE1D.1843C7FE-ONC1257589.00328D91-C1257589.00336B8B@transmode.se>
Date: Mon, 30 Mar 2009 17:36:36 +0800
Message-ID: <2a27d3730903300236j79cc3035raef2bf5e895fe429@mail.gmail.com>
Subject: Re: [PATCH] ucc_geth: Move freeing of TX packets to NAPI context.
From: Li Yang <leoli@freescale.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 30, 2009 at 5:21 PM, Joakim Tjernlund
<Joakim.Tjernlund@transmode.se> wrote:
> pku.leo@gmail.com wrote on 30/03/2009 10:34:47:
>>
>> On Thu, Mar 26, 2009 at 1:51 AM, Joakim Tjernlund
>> <Joakim.Tjernlund@transmode.se> wrote:
>> > Anton Vorontsov <avorontsov@ru.mvista.com> wrote on 25/03/2009
> 15:25:40:
>> >> On Wed, Mar 25, 2009 at 02:30:49PM +0100, Joakim Tjernlund wrote:
>> >> > >>From 1c2f23b1f37f4818c0fd0217b93eb38ab6564840 Mon Sep 17 00:00:00
>> > 2001
>> >> > From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
>> >> > Date: Tue, 24 Mar 2009 10:19:27 +0100
>> >> > Subject: [PATCH] ucc_geth: Move freeing of TX packets to NAPI
> context.
>> >> > =C2=A0Also increase NAPI weight somewhat.
>> >> > =C2=A0This will make the system alot more responsive while
>> >> > =C2=A0ping flooding the ucc_geth ethernet interaface.
>> >>
>> >> Some time ago I've tried a similar thing for this driver, but during
>> >> tcp (or udp I don't quite remember) netperf tests I was getting tx
>> >> watchdog timeouts after ~2-5 minutes of work. I was testing with a
>> >> gigabit and 100 Mbit link, with 100 Mbit link the issue was not
>> >> reproducible.
>> >>
>> >> Though, I recalling I was doing a bit more than your patch: I was
>> >> also clearing the TX events in the ucce register before calling
>> >> ucc_geth_tx, that way I was trying to avoid stale interrupts. That
>> >> helped to increase an overall performance (not only responsiveness),
>> >> but as I said my approach didn't pass the tests.
>> >>
>> >> I don't really think that your patch may cause this, but can you
>> >> try netperf w/ this patch applied anyway? And see if it really
>> >> doesn't cause any issues under stress?
>> >
>> > Does the line(in ucc_geth_tx()) look OK to you:
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((bd =3D=3D ugeth->txBd[txQ]) && (netif_=
queue_stopped(dev) =3D=3D
> 0))
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;
>> >
>> > Sure does look fishy to me.
>>
>> There are two cases when txBd=3DConfBd: the BD ring is full or empty.
>> The condition used here ensures that it is the empty case. =C2=A0Because=
 in
>> hard_start_xmit, the queue will be stopped when the BD ring is full.
>> Maybe some comment is needed here.
>
> But how do you know that the queue hasn't been stopped by someone else
> than
> the driver?
> If it is stopped by higher layers, the if stmt will fail.

It looks like from existing code that only the driver can legally stop
the queue.  I'm not 100% sure though.  Correct me if I'm wrong.

- Leo
