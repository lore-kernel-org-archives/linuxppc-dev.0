Date: Wed, 6 Oct 1999 08:47:03 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
Subject: Re: update on macserial/DMA
In-Reply-To: <19991006103527.016707@mailhost.mipsys.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.991006082634.2962A-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 6 Oct 1999, Benjamin Herrenschmidt wrote:

> It breaks (crash) on the wallstreet's internal modem. The reason is that
> this machines has two SCCs (4 channels) but the device tree only declares
> channel A on the second SCC (so we have only 3 channels visible). This

I see.  That would be a problem.

> breaks the channel cross-references you use to access channel B's
> registers. I'll try to make a simple fix if I find some time today and I
> think I'll just rewrite the probe code by the end of the week or next
> week end since it's too much dependent on the device tree layout.

I've just tried your fix, and, as expected, it causes no harm for PMac
7600.  Thanks.  It's not a big problem, but I think we don't want the
"fake" channel to take up "/dev/ttyS3" or such in case another serial
driver is to be used concurrently.

> 
> BTW. Paul: The patches on my test page (url below + .../test.html)
> include among other things support for the PowerBooks 3400/3500
> ethernet/modem combo interrupt. It looks like there is a second ohare
> chip with cascaded interrupt controller either in the combo itself or on
> the motherboard (or a chip that mimmics the ohare chip). It's not
> referenced by name in the device tree but by vendorid/deviceid. I'm
> wondering if it might contains also an SCC cell for the modem but I can't
> test, I don't have access to one of those machines. I think you have a
> 3400, don't you ? I'll make sure my new probe code can easily be used to

I think ehternet/modem combo is only for the US model of PowerBook
3400/3500.  If Paul had it, the combo should be working a long ago. :)

> declare SCC cells for this kind of cases (but just passing the addresses
> in) just in case...
> 


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
