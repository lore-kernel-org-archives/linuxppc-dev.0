Date: Tue, 20 Jan 2004 18:05:01 -0800
From: Andrew May <acmay@acmay.homeip.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Small UDP packet performance
Message-ID: <20040121020501.GA22956@acmay.homeip.net>
References: <00b101c3de3e$9c34f200$9104050a@JACKYLAM> <20040119052806.GA26841@gate.ebshome.net> <015501c3deef$27263030$9104050a@JACKYLAM> <20040120010227.GA32018@gate.ebshome.net> <20040120232342.GA20399@acmay.homeip.net> <20040121011650.GA3905@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040121011650.GA3905@gate.ebshome.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jan 20, 2004 at 05:16:50PM -0800, Eugene Surovegin wrote:
> On Tue, Jan 20, 2004 at 03:23:42PM -0800, Andrew May wrote:
> > Here is what I have done for a NAPI version of the driver. I don't have time
> > either to do a patch or merge this up to the latest kernel. I have frozen down
> > at 2.4.21-pre4 somewhere and I won't be merging anytime soon. It is stable for
> > me.
>
> Looks OK, although I chose another way to disable RX IRQs :)

Do tell.

> Sad thing is because of bad MAL design NAPI will be limited to one
> EMAC per MAL (there is no way to disable IRQ generation on channel
> basis), it's not an issue for 405, but for 440 I haven't figured
> out how to overcome this limitation yet.

Yep it is a problem and even for the 405's with more than one ethernet.

> Andrew, I'm just curious, you probably did some measurements with
> your NAPI driver, care to share them :) ?

It may be hard to compare them. I am adding some data to each packet
and routing them to another PCI device. I think things max out around
18kpps one way. Going full-duplex things even out pretty good both
ways with the total pps being slightly higher. The most important
thing is that when the input rate goes higher the output stays at
the max instead of going down.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
