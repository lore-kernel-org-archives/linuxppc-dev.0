Date: Mon, 14 Jun 2004 08:46:25 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH][RFC] OCP support for MPC107 and relatives
Message-ID: <20040614084625.A29057@home.com>
References: <1087207803.7360.83.camel@newt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1087207803.7360.83.camel@newt>; from adrian@humboldt.co.uk on Mon, Jun 14, 2004 at 11:10:04AM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jun 14, 2004 at 11:10:04AM +0100, Adrian Cox wrote:
> The attached patch is a start at adding the internal peripherals of the
> MPC107/MPC8240/MPC8245 to the OCP bus. I've used thus in the 2.6 port of
> my MPC107 I2C driver, which follows shortly. I intend to use this for
> the DMA controller later, once I decide what device ID to give it.

Excellent...I was hoping someone would take care of this for MPC10x-ish
on-chip devices.

> I'm a little uncertain about OCP device IDs. Should there be a separate
> I2C device ID for each different I2C programming interface from the same
> vendor? Motorola have already given us two separate implementations on
> PowerPC.

Well, I've been asked this question a few times in similar contexts,
but I haven't had a solid answer to give yet.  Basically, the question
boils down to, "What are the rules for assigning new OCP IDs?". Right
now, there are no written rules.  However, we have a software "bus"
abstraction with a massive amount (32-bit) of IDs available for our
use per vendor.

My current suggestion is to use this space to assign unique IDs
per device even though devices don't show up between architectures
(normally).  I can actually see cases where two different OCP systems might
share a device, but it would be rare if anybody ever implements such
a thing at all. Please assign unique IDs per device and per vendor
for now.  If it gets out of hand in the future, we can revisit the
situation.

> This is a little bit different from the PPC40x use of OCP, because it's
> hard to calculate everything at compile time. This is particularly
> caused by the pcore boards, which use the MPC107 but don't use the
> interrupt controller.

Mark Greer and Kumar Gala each have platforms doing runtime mods, so the
Marvell and 85xx ports are good examples to follow.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
