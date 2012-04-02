Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D5002B6FFB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2012 08:52:57 +1000 (EST)
Date: Mon, 2 Apr 2012 23:52:23 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map; use
 irq_alloc_desc() instead
Message-ID: <20120402225223.GN24211@n2100.arm.linux.org.uk>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <m2hax2qeqs.fsf@igel.home>
 <20120402202848.1EB833E02A7@localhost>
 <20120402215524.GM24211@n2100.arm.linux.org.uk>
 <1333406005.30734.61.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333406005.30734.61.camel@pasglop>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, Andreas Schwab <schwab@linux-m68k.org>,
 Milton Miller <miltonm@bga.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 03, 2012 at 08:33:25AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2012-04-02 at 22:55 +0100, Russell King - ARM Linux wrote:
> > Well, presumably someone is calling irq_set_irq_type() asking explicitly
> > for IRQ_TYPE_NONE.  The code will now (as it always used to before David's
> > change) do exactly what you ask this to: it will ask the type to be set
> > to none.
> > 
> > If you don't want to set the type to none, don't call the interface asking
> > for that to happen. 
> 
> I think part of the idea with NONE is to use it as "reset that interrupt
> to the "default" setting, whatever that means ...

No, it never was (anyone who thought that is plain wrong because that
wasn't my original design.)

NONE really did mean "I don't want any trigger level" for set_irq_type()
as it was originally designed on ARM, and there's a number of PCMCIA
socket drivers which rely on that behaviour: the reason is that with
edge triggered interrupts, Linux normally remembers edges which happen
with the interrupt disabled, and delivers those events when the interrupt
is re-enabled.  There are situations (such as edge triggered status GPIOs)
where we _really_ do want to ignore transitions on an edge triggered
input.  And PCMCIA soc_common uses set_irq_type() with NONE to do this.

The reason you can't request an interrupt with a NONE type is because
I saw that to be pointless - and in any case, the type is a bitmask and
NONE ended up being zero.  Zero is also what you get with request_irq()
used with drivers which don't pass any IRQ trigger flags, so request_irq()
has to ignore this case.

Now, arguably, we could say that there should be an interface for clearing
pending edges in our interrupt model, but traditionally there hasn't been,
even when my ARM IRQ stuff was moved forward into genirq.  However,
subsequently changing genirq in a way which breaks previously working
stuff is a regression, and that's what my revert addresses.

If we want to fix it a better way, then sure, that'll be good.  But what
we shouldn't do is re-introduce one regression to fix a different
regression.

So, Thomas, what do you think about providing a way that a disabled
interrupt could have its pending status cleared such that when it's
enabled, any queued events are ignored?  Maybe an enable_and_clear_irq() ?
