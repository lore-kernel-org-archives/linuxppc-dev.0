Date: Sun, 19 Aug 2001 12:00:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philip Decker <pdecker@wavewireless.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Liu HongXun-a16975 <a16975@motorola.com>,
	"'Matthew Locke'" <mlocke@mvista.com>,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: Is there a PCI based 802.11b device driver for ppc linux?
Message-ID: <20010819120051.E5117@zax>
References: <0E97488D670BD411B8BD00C0F03BDF64AD6593@SPEEDCOM3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0E97488D670BD411B8BD00C0F03BDF64AD6593@SPEEDCOM3>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Aug 17, 2001 at 05:53:39PM -0400, Philip Decker wrote:
>
> If Liu plans to use a mini-PCI 802.11b radio, and that radio is based on
> Prism 2.5, and it uses the ISL3874 MAC/BBP (which interfaces directly to the
> PCI Bus), then there is no Linux driver yet (that I'm aware of).
>
> On the other hand, if his mini PCI radio is Prism II, or Prism 2.5 but using
> the ISL3873 MAC/BBP, then that radio contains a PCI to PCMCIA bridge and the
> existing Linux drivers will work.

Assuming the kernel has drivers for the PCI to PCMCIA bridge in
question.  Many such bridges are not well supported at the moment,
particularly with the in-kernel PCMCIA subsystem rather than the David
Hinds' pcmcia-cs package.

> I don't know about Linux drivers for Agere/Lucent Orinoco/WaveLAN mini-PCI
> radio.

I've heard rumours that someone has successfully adapted the orinoco
driver to work on the Mini-PCI cards, but I have no details.  I wish I
could find out because I'd like to merge the changes into the standard
orinoco driver.

Actually for a Prism II or Agere/Lucent based PCI card (actually the
same chipset with somewhat different firmware) it should be quite easy
to add support.  The orinoco driver already has the initialisation
code abstracted out from the driver core and supports both PCMCIA
cards and the Apple Airport (AFAIK basically PCI plus some custom
Apple power control stuff).  It should be quite easy to add a PCI
"front-end" to the driver.

--
David Gibson			| Microsoft: Making the easy things hard
david@gibson.dropbear.id.au	| and the hard things buggy
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
