Message-ID: <3FC59BAE.3020801@paulidav.org>
Date: Wed, 26 Nov 2003 22:37:34 -0800
From: "Vladimir A. Gurevich" <vag@paulidav.org>
MIME-Version: 1.0
To: Brian Kuschak <bkuschak@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org, linuxppc@opqua.com
Subject: Re: routing performance w/embedded linux on ppc?
References: <20031126181826.50858.qmail@web40911.mail.yahoo.com>
In-Reply-To: <20031126181826.50858.qmail@web40911.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Kuschak wrote:
> The performance on 4xx is dependent on how much work
> you want to do in the ethernet driver.
>
> A (nearly) stock kernel will be able to forward 64
> byte packets at around 15,000 pps on 200MHz 405GP.
> The interrupts burn alot of CPU cycles.  If you
> implement a timer-based interrupt mitigation scheme
> using the FIT timer interrupt to clean out the RX and
> TX rings, you will be able to hit about 35K to 40K
> pps.

I definitely agree with Brian's numbers and recommendations :)

Just a couple of comments:

Starting with 2.4.19 or so, I'd recommend looking at NAPI to do
interrupt mitigation instead. Please look at
ftp://robur.slu.se/pub/Linux/net-development/NAPI/

> On top of that, you can implement
> CONFIG_NET_FASTROUTE in the driver, bypassing most of
> the IP stack.

But, of course, you'll loose IP tables. Also, CONFIG_NET_FASTROUTE won't
help in case you use a DHCP client (or any other app that uses raw
sockets). This might not be that important for a router but be warned!

Regards,
Vladimir


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
