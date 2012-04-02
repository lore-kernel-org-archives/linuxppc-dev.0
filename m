Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8E5B9B6F9A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2012 06:28:53 +1000 (EST)
Received: by pbcwy12 with SMTP id wy12so5356697pbc.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Apr 2012 13:28:50 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map;
 use irq_alloc_desc() instead
To: Andreas Schwab <schwab@linux-m68k.org>
In-Reply-To: <m2hax2qeqs.fsf@igel.home>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <m2hax2qeqs.fsf@igel.home>
Date: Mon, 02 Apr 2012 14:28:48 -0600
Message-Id: <20120402202848.1EB833E02A7@localhost>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Rob Herring <rob.herring@calxeda.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 02 Apr 2012 18:29:15 +0200, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Andreas Schwab <schwab@linux-m68k.org> writes:
> 
> > Grant Likely <grant.likely@secretlab.ca> writes:
> >
> >> This patch drops the powerpc-specific irq_map table and replaces it with
> >> directly using the irq_alloc_desc()/irq_free_desc() interfaces for allocating
> >> and freeing irq_desc structures.
> >
> > This breaks irqs on PowerMac G5.  I see lost irq errors from the sata
> > driver.
> 
> When I revert a09b659cd68c10ec6a30cb91ebd2c327fcd5bfe5 ("genirq: Fix
> long-term regression in genirq irq_set_irq_type() handling") on top of
> 3.4-rc1 the sata irq errors disappear, but I see a lot of spurious
> interrupts.  Also the X server is broken somehow, though I don't know
> whether that is related or a different bug.

That change is:

@@ -61,8 +61,7 @@ int irq_set_irq_type(unsigned int irq, unsigned int type)
                return -EINVAL;
 
        type &= IRQ_TYPE_SENSE_MASK;
-       if (type != IRQ_TYPE_NONE)
-               ret = __irq_set_trigger(desc, irq, type);
+       ret = __irq_set_trigger(desc, irq, type);
        irq_put_desc_busunlock(desc, flags);
        return ret;

So presumably irq_set_irq_type() is getting called with type ==
IRQ_TYPE_NONE.  From Russell's description, presumably that would mean
the G5 sata driver isn't setting the correct type for the interrupt,
but I have *no* idea how that intersects with the change removing the
powerpc irq map.

Can you dump out /debug/powerpc/virq_mapping from both before and
after the irq_map patch is applied?

g.
