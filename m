Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 6133ADE05F
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 04:06:53 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1349258ugf
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 09:06:51 -0800 (PST)
Message-ID: <528646bc0701150906o253c898dobe3b55ffb91add70@mail.gmail.com>
Date: Mon, 15 Jan 2007 10:06:50 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Matt Sealey" <matt@genesi-usa.com>,
	"linuxppc-dev Development" <linuxppc-dev@ozlabs.org>
Subject: Re: Discussion on SOC device tree bindings
In-Reply-To: <45ABA20E.30008@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <528646bc0701131555n3249b503i3b6e8c37db41dd52@mail.gmail.com>
	<45AA098C.70101@246tNt.com>
	<6189b01379f62aa4516484872f4ef86f@kernel.crashing.org>
	<1168810790.4803.11.camel@localhost.localdomain>
	<ccc8fbc935d8f8d3e30870d43959f6c7@kernel.crashing.org>
	<1168817449.4803.28.camel@localhost.localdomain>
	<ef64a4198a02929a00c28abb5f0934b5@kernel.crashing.org>
	<1168818533.4803.37.camel@localhost.localdomain>
	<a1af25147ea7308c394d243511b96f69@kernel.crashing.org>
	<45ABA20E.30008@genesi-usa.com>
Cc: Sven Luther <sven@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Note: I had forgot to start this thread on the mailing list; but I'm
moving it there now.

On 1/15/07, Matt Sealey <matt@genesi-usa.com> wrote:
> Can someone summarise why we are talking about exposing clock controllers
> for anything more than informational purposes?

Isn't the whole device tree all about "informational purposes?"  :-)

>
> I seem to have missed some mails, had some spam filtered and deleted by
> automation this weekend, and I am not following the general discussion
> so well (from a "I don't understand" standpoint) as it is.
>
> I am not sure from my point of view that it is relevant to expose such
> details in the tree since the information is not useful or changable by
> Linux. What clock controls what device, the cascading down the tree and
> so on doesn't seem to give me any more information than no information
> at all when the clocks are relatively fixed at boot time (Linux should
> not be reconfiguring internal SoC bus clocks)

No, we're not talking about SoC bus clocks.  In fact, we're not
talking about clocks at all.  :-) Shared clock registers just happen
to be a convenient example for the topic we're really talking about.

The thread started with discussion about the 5200 device tree binding
conventions, but has moved to a specific issue.  Now we are talking
about how to deal with shared registers.  ie. There are 2 I2C
controllers on the 5200, but they share one register.  How is that
best represented in the device tree?

Here's the quick summary of the points so far:
1. We all agree that the device tree is about how best to describe the
hardware; not how Linux or anyone else intends to use it.  (ie.
provide as much relevant information as possible without building an
insanely large tree and regardless of whether or not Linux uses the
info.)
2. It is not reasonable to try to describe every chip register in the
device tree
3. It is reasonable to assume that the OS has SoC specific code to
deal with variations in implementation.
4. I think that the general consensus is that the device tree should
have a node for shared SoC registers and a node for each on chip
device.  One will point to the other (phandle?) to indicate which node
device drivers should look to for twiddling the shared bits.
5. The contentious issue is which direction those links should be
constructed.  Does the device node describe where to find it's SoC
parent node and what the device index is?  Or does the SoC node
describe which device nodes it provides shared register service for?
6. Paramount in this discussion is making sure that the device tree is
detailed enough that if any of the above information is missing
(because firmware is never going to have everything we want), the
information can still be determined and filled in.  For example, as
long as we know the processor is a mpc5200b; then the shared register
bindings can be filled in at fixup time.

>
> It may come in useful and this may be a bad example, for ATA drivers
> where I always see the message "assuming 33MHz bus lock for PIO" - rather
> than assume, it would be reported, but is this all that we are discussing
> here or is there something a lot more complicated coming off it that just
> went right over my head?

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
