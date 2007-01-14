Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 1F448DDE28
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 09:29:26 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1141874ugf
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 14:29:25 -0800 (PST)
Message-ID: <528646bc0701141429q577f87f1oe65aa7033c09b62b@mail.gmail.com>
Date: Sun, 14 Jan 2007 15:29:24 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Matt Sealey" <matt@genesi-usa.com>, "Sylvain Munaut" <tnt@246tnt.com>,
	"Sven Luther" <sven@genesi-usa.com>, "Nicolas DET" <nd@bplan-gmbh.de>
Subject: Re: Discussion on SOC device tree bindings
In-Reply-To: <528646bc0701131555n3249b503i3b6e8c37db41dd52@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <528646bc0701131555n3249b503i3b6e8c37db41dd52@mail.gmail.com>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bah!  I forgot to CC the mailing list on this email; so this is a resend.

On 1/13/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> A number of us spent a bit of time discussing this Thursday and today
> on IRC; here is a summary for everyone else's benefit.
>
> Most of this conversation centered around the mpc5200, but there are
> implications for other soc's too.
>
> The issue discussed was whether or not the description of the
> compatible field in
> Documentation/powerpc/mpc5200-device-tree-bindings.txt is the best way
> to describe the hardware.  At the moment, it recommends something like
> "mpc5200b-psc-uart\0mpc52xx-psc-uart" to describe a PSC in UART mode.
> This isn't the first time these issues have come up; but it is the
> first time we've discussed it in any depth.
>
> The problems with this are:
> 1. it's a bit premature to define mpc52xx when there are only 2
> devices in the family and the primary reason they are named
> differently is that the 5200b has bug fixes that are not 100%
> backwards compatible with the 5200.
> 2. It still doesn't give enough information; ie. it doesn't give any
> information about silicon revision for a particular board.  ie. If
> there is a bug in M08A but not in M62C, then driver doesn't get that
> from the current scheme.
>
> When I wrote the document, I based it on the assumption that the
> driver would have all the information it needs based on the compatible
> property (which is naive).  'compatible' is supposed to be a
> description of the interface; not a full description of the hardware
> revision.
>
> It also makes the assumption that names matter.  They don't.  If we
> call an fec on the 5200 "mpc5200-fec", it will always be
> "mpc5200-fec", even if it shows up on a mpc5233 or a mpc5400, or any
> other chip.  All that matters is that two incompatible device are not
> named the same thing.  So, using 52xx-* in compatible lists is
> premature as we have no idea how many other 52xx parts will arrive
> using the same device, and a future 52xx could use an incompatible FEC
> that would have to be called something different (because 52xx-fec is
> already taken)
>
> The main value of the bindings document is so we do have a list of
> already assigned device names to be used in the compatible property.
>
> What *is* interesting is to know exactly which silicon version of the
> device it is.  In a perfect world, device drivers shall never need
> this information.  However, if a bug is found in the future, this
> information is needed to enable/disable bug fix code.
>
> It's also interesting to know about extra features and quirks of a
> device.  ie. gpt0 has a watchdog timer feature.  The device interface
> is mostly the same; but probably not different enough to warrant a
> separate device driver.  (things get hazy here; more of an art than
> science to decide whether this information is encoded in 'compatible'
> or with an extra property)  ie. The gpt0 node could have an empty
> property called 'has-wdt'.
>
> So, the following changes are proposed:
> 1. "mpc52xx-*" items will be dropped from the compatible property
> because they are premature.  Unless the 5200B device is incompatible
> with the 5200, then the 5200B will specify "mpc5200b-*\0mpc5200-*".
> (strong recommendation, but not required; if a 5200b board just has
> "mpc5200-*", in most cases it won't cause breakage).
> 2. known quirks/extra features will be reported with additional
> properties to the device.  ie. gpt0 will add a 'has-wdt' empty
> property
> 3. an /soc5200/model property will be added for last resort
> determination of chip version (The soc5200 node is called 'builtin' on
> the efika)
> 4. most of the 5200 drivers will be changed to bind on 5200-* instead
> of 52xx-*.  Drivers will not bind on 5200b-* unless truly incompatible
> with the 5200.
> 5. new 5200-ish devices, like a fictional 5300 or a 5437 (random
> numbers out of my head) will use something like
> "mpc5300-psc-uart\0mpc5200-psc-uart" (strong recommendation)
> 6. A /soc5200/model property shall be added to describe the chip type
> (ie model="mpc5200b").
> 7. A /soc5200/version property shall be added to describe the silicon
> revision (ie. version="M62C")
>
> Note: the presence of the soc node is important, but I don't think the
> name of it matters much.  It should be sufficient to define it as the
> parent of the device node.  What matters is that device drivers know
> how to reach it.
>
> Implications:
> 1. Encoding /soc/model and /soc/version is probably a good idea for
> *all* SOCs.  If everyone agrees, then I'll add it to
> booting_without_of.txt.
> 2. It means the Efika compatible properties match without fixups.  I'm
> still not happy with using "mpc5200-xxx" instead of "mpc5200-psc-xxx"
> for PSC functions because it means there is a collision between the
> two different SPI devices.  However, if names don't matter then I
> shouldn't get my nickers in a knot over this one.  It's more important
> to document what is done.
>
> Comments?
> g.
>
> --
> Grant Likely, B.Sc. P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
>


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
