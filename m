Return-Path: <tnt@246tNt.com>
Received: from mailrelay006.isp.belgacom.be (mailrelay006.isp.belgacom.be
	[195.238.6.172]) by ozlabs.org (Postfix) with ESMTP id 778B3DDE34
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jul 2007 21:45:23 +1000 (EST)
Message-ID: <469DFD4F.7010009@246tNt.com>
Date: Wed, 18 Jul 2007 13:45:19 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Miguel Angel Alvarez <ma.alvarez@ziv.es>
Subject: Re: mpc52xx: Correct calculation of FEC RX errors???
References: <469DFC03.9080201@ziv.es>
In-Reply-To: <469DFC03.9080201@ziv.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> Hi
>
> We are showing figures of more than 4 billion error frames in our
> ethernet interfaces. We have tested that the problem is in a
> substraction (the number of errors decrements with the number of frames).
>
> So... looking in the fec driver (fec.c) for the calculations we have
> seen that the number of multicast packets is added to the number of
> correct frames in order to get the frame errors...
>
> But the interesting thing is that we have checked that this
> calculation is something that we have added with a patch by Grzegorz
> Bernacki in this list.
>
> So... The funny thing is... Why a patch that solves the problem for
> Grzegorz produces "the same problem" for us?
>
> And... by the way... I have seen IEEE802.3, and when they talk about
> aFramesReceivedOK (which I suppose is the ieee_r_frame_ok in the
> driver), and they do not say a word about not including multicast
> packets in it...
>
> Any comment will be appreciate.
The only comment I have, is that yes, the computation are flawed.
And that's not very high in my priority list.

I don't think the path posted on the list fully fix the issue but I
really don't want to spend hours trying to figure out exactly what
values are reported in all those counters. You're welcome to do so if
you have some free time ...

There are other stuff wrong in this driver (try ifconfig eth0 down, then
send some broad cast traffic on the network .... you'll see some fifo
error popping up ) ...


Sylvain
