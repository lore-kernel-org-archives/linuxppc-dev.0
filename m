Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C471B6F57
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jun 2011 03:00:16 +1000 (EST)
Date: Wed, 8 Jun 2011 12:00:04 -0500
From: Scott Wood <scottwood@freescale.com>
To: Vijay Nikam <vijay.t.nikam@gmail.com>
Subject: Re: [gianfar]bandwidth management problem on mpc8313 based board
Message-ID: <20110608120004.37d024c3@schlenkerla.am.freescale.net>
In-Reply-To: <BANLkTino1HgB2SL=S6ZeZ-z3o1MczWJ+8w@mail.gmail.com>
References: <BANLkTi=TVsXiWR1qS5upnM31kVk9qqXTmw@mail.gmail.com>
	<20110607142213.2851f92e@schlenkerla.am.freescale.net>
	<BANLkTino1HgB2SL=S6ZeZ-z3o1MczWJ+8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 8 Jun 2011 16:21:03 +0530
Vijay Nikam <vijay.t.nikam@gmail.com> wrote:

> Hello Scott,
> 
> Thanks for the prompt reply.
> 
> > What's your CPU utilization?  The CPU may just not be able to keep up with
> > that much traffic, with the software you're running.
> The software I am using to check bandwidth is 'iperf'.

Plus the Linux network stack.

> Without running iperf the
> CPU utilization varies around 30-50% and with iperf running it shoots
> upto 99.9%.

OK, so you're CPU limited.

You might want to try a newer kernel; things may have improved in the past
several years.

If the reason you're running such an old kernel is because you're using the
Freescale BSP, contact Freescale support and ask what performance you're
supposed to be able to get (as well as if they have a newer BSP available).

> > What packet size are you using?
> The packet size is - 1518 + VLAN_Tag (4Bytes) = 1522 Bytes
> 
> Another point which I would like to clear is that mpc8313 has eth0 (eTsec1) of
> 1Gbps, if more than 50% of CPU Time is available then why the total bandwidth
> should limit to less than 100 Mbps?  At least 400Mbps should be expected, please
> correct if I am wrong!

I assume the remote end isn't CPU limited...  Is the test limited by latency
or bandwidth?  You're sure that you've actually got a gigabit link
end-to-end?  Didn't you say the 30-50% was without running iperf at all --
did you mean running it only on one port?

Beyond that, I guess you'd have to do some debugging to see where the
packets are getting dropped.

-Scott
