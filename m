Return-Path: <avorontsov@ru.mvista.com>
Date: Thu, 26 Mar 2009 20:33:02 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 3/4] powerpc: NAND: FSL UPM: document new bindings
Message-ID: <20090326173302.GA23187@oksana.dev.rtsoft.ru>
References: <1237975701-23201-4-git-send-email-wg@grandegger.com>
	<fa686aa40903251048g479d63f8i5a715defdbfc33d4@mail.gmail.com>
	<49CA9899.30604@grandegger.com>
	<fa686aa40903252209r52a1bc1cn995a7da16bc3527f@mail.gmail.com>
	<49CB31CB.2010704@grandegger.com>
	<fa686aa40903260727y3266e394g5e574680fe70bbbf@mail.gmail.com>
	<49CBA062.5050000@grandegger.com>
	<fa686aa40903260904s67258fbbge3c87e06946c5f58@mail.gmail.com>
	<49CBAED4.8030802@grandegger.com>
	<fa686aa40903261002l2c8e0d41s6e5ad4bc049058bf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <fa686aa40903261002l2c8e0d41s6e5ad4bc049058bf@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>,
	linux-mtd@lists.infradead.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 26, 2009 at 11:02:06AM -0600, Grant Likely wrote:
[]
> >> Here is another thought.  The binding is describing that address lines
> >> are used to activate CS lines.  Offset for chip access purposes is
> >> derived from the address line, but it doesn't directly describe the
> >> hardware.  The following may be a better description of the hardware.
> >>
> >> fsl,upm-addr-line-cs = <9 10>;
> >
> > The TQM8548 hardware has some logic connected to the two address lines
> > allowing to select up to 4 chips with two address lines:
> >
> >  fsl,upm-addr-line-cs-offsets = <0x0 0x200 0x400 0x600>
> 
> Ah.  I see.  This is board specific then.  I think it is premature to
> try and define a generic solution here because it depends on custom
> board hardware and different boards could use very different logic.
> The next board could end up doing something completely different.  I'd
> rather start to see trends in multiple boards implementing the same
> scheme before trying to craft a generic scheme.
> 
> In other words, this device is not register-level compatible with the
> fsl,upm-nand device.  Give the node a new compatible value
> (tqc,tqm8548-upm-nand) and add another entry to the of_fun_match table
> for the new device.  Use the .data element in the match table to
> supply an alternate fun_cmd_ctrl() function for this board (instead of
> using a property value do decide which fun_cmd_ctrl() behaviour to
> use).  New boards that *do* use the same addressing scheme can claim
> compatibility with tqc,tqm8548-upm-nand.

I don't like this. :-/

UPM is an universal thing, so there are thousands of ways we can
connect NAND to the UPM. Of which only ~10 would be sane (others are
insane, and nobody would do this. If they do, _then_ we'll fall back
to <board>-upm-nand scheme for a particular board).

I don't see any problem with fsl,upm-addr-line-cs-offsets. It can
describe any scheme in "addr lines are cs" connection, it's a common
setup for multi-chip memory, we shouldn't treat it is as something
extraordinary.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
