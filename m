Date: Sat, 15 Sep 2001 14:43:58 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: HDLC - Char or Network driver?
Message-ID: <20010915144358.A6415@ecam.san.rr.com>
References: <6B546A602AD2D211BFF00008C7A42889041D6BE9@hrtades2.atea.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6B546A602AD2D211BFF00008C7A42889041D6BE9@hrtades2.atea.be>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Sep 14, 2001 at 06:31:30PM +0200, Goddeeris Frederic wrote:
>
> Hi,
>
> I need to exchange data between an MPC860 and other components over an HDLC
> bus. I found a "PPP over HDLC" driver for the MPC850. Out of this I made a
> (quick and dirty) new driver for HDLC and it seems to work so I will be able
> to make a nice driver out of this but I am unsure whether this needs to be
> char driver of a network driver.
>
> From an application I need to send and receive native HDLC packets, so no
> additional protocol is needed.
>
> All examples and documents I find about network-drivers are so IP-related. A
> network driver registers itself but how can an application reach it? An
> Ethernet driver seems to be linked to the TCP/IP stack by using ifconfig.
> But what about an HDLC driver for example?

This would be better on a netdev mailling list.

look at linux/if_ether.h and pick a type from there or a number that won't
class with anything else you use. In the driver you will key off of skb->protocol
with that number and then at the app level you will use raw sockets bound to the
same protocol. ETH_P_WAN_PPP may be a good choice.

Look at drivers/wan/*.c in how the skb is setup before netif_rx. Also look at
hardheader functions if you want. They can be left out.

There should be plenty of examples of raw socket code. Even if it is IP based
it will show you how to use them to get raw packets down to and from the driver.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
