Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6955B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Oct 2010 16:41:22 +1100 (EST)
Subject: Re: Problem with Infiniband adapter on IBM p550
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Finnegan <pat@computer-refuge.org>
In-Reply-To: <201010072324.33062.pat@computer-refuge.org>
References: <201010072324.33062.pat@computer-refuge.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Oct 2010 16:41:10 +1100
Message-ID: <1286516470.2463.403.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-10-07 at 23:24 -0400, Patrick Finnegan wrote:
> I seem to be running into a problem getting a Mellanox Infinihost  
> Infiniband adapter working on my IBM p550 (a 9113-550).  I'm using 
> Debian squeeze, and tried upgrading to the 2.6.35.7 kernel without any 
> help.
> 
> I get the following messages in dmesg:
> [    4.972548] ib_mthca: Mellanox InfiniBand HCA driver v1.0 (April 4, 
> 2008)
> [    4.972564] ib_mthca: Initializing 0000:c1:00.0
> [    4.972674] ib_mthca 0000:c1:00.0: Missing DCS, aborting.

Ok, so from what I can tell, the driver is unhappy because either BAR 0
hasn't been assigned a memory resource or the size doesn't match what
the driver expects.

Let's see...

> The problem looks the same as a problem I ran into with OpenFirmware on 
> a Sun V880, which was fixed with this patch by Dave Miller:
> http://ns3.spinics.net/lists/linux-rdma/msg01779.html
> 
> I spent some time looking at the equivalent function on powerpc, but 
> didn't a block of code that looked similar.

I don't think we are hitting the same problem. I believe our code in
that area differs enough.

In your lspci, however, I see:

	Memory at <unassigned> (64-bit, non-prefetchable)
	Memory at <unassigned> (64-bit, prefetchable)

Which doesn't look good...

>From your OF log

> Any suggestions?
> 
> I have dmesg, the dev .properties from openfirmware, and lspci -v from 
> the machine:
> 
> http://ned.rcac.purdue.edu/p550-ib/dmesg
> http://ned.rcac.purdue.edu/p550-ib/ib-of-device
> http://ned.rcac.purdue.edu/p550-ib/lspci-v
> 
> Pat
