Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415TX02fNqzDrbK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 00:24:00 +1000 (AEST)
Date: Wed, 13 Jun 2018 17:23:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ram Pai <linuxram@us.ibm.com>, Christoph Hellwig <hch@infradead.org>,
 robh@kernel.org, pawel.moll@arm.com,
 Tom Lendacky <thomas.lendacky@amd.com>, aik@ozlabs.ru,
 jasowang@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, joe@perches.com,
 "Rustad, Mark D" <mark.d.rustad@intel.com>,
 david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180613170318-mutt-send-email-mst@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <20180524072104.GD6139@ram.oc3035372033.ibm.com>
 <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
 <20180531204320-mutt-send-email-mst@kernel.org>
 <20180607052306.GA1532@infradead.org>
 <20180607185234-mutt-send-email-mst@kernel.org>
 <20180611023909.GA5726@ram.oc3035372033.ibm.com>
 <20180611060949-mutt-send-email-mst@kernel.org>
 <59e60715f27b10bc6816193eaf324824eff69c46.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <59e60715f27b10bc6816193eaf324824eff69c46.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 11, 2018 at 01:34:50PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2018-06-11 at 06:28 +0300, Michael S. Tsirkin wrote:
> > 
> > > However if the administrator
> > > ignores/forgets/deliberatey-decides/is-constrained to NOT enable the
> > > flag, virtio will not be able to pass control to the DMA ops associated
> > > with the virtio devices. Which means, we have no opportunity to share
> > > the I/O buffers with the hypervisor/qemu.
> > > 
> > > How do you suggest, we handle this case?
> > 
> > As step 1, ignore it as a user error.
> 
> Ugh ... not again. Ram, don't bring that subject back we ALREADY
> addressed it, and requiring the *user* to do special things is just
> utterly and completely wrong.
> 
> The *user* has no bloody idea what that stuff is, will never know to
> set whatver magic qemu flag etc... The user will just start a a VM
> normally and expect things to work. Requiring the *user* to know things
> like that iommu virtio flag is complete nonsense.

You should consider teaching QEMU that the platform has support for the
ultravisor thing so it can set flags for you.

That's true even if something else is done for virtio - if you don't
have the capability right now you will come to regret it, host userspace
is just fundamentally in charge of control-path enumeration in the KVM
stack, I understand you want to take some of it away for security but
trying to hide things from QEMU completely is a mistake IMHO.

Just my $.02.

> If by "user" you mean libvirt, then you are now requesting about 4 or 5
> different projects to be patched to add speical cases for something
> they know nothing about and is completely irrelevant, while it can be
> entirely addressed with a 1-liner in virtio kernel side to allow the
> arch to plumb alternate DMA ops.
> 
> So for some reason you seem to be dead set on a path that leads to
> mountain of user pain, changes to many different projects and overall
> havok while there is a much much simpler and elegant solution at hand
> which I described (again) in the response to Ram I sent about 5mn ago.

What you sent to Ram sounds OK to me - I only hope we do all mean
the same thing because the 3 paragraphs above are all
about the libvirt/QEMU split mess which linux or virtio
should not really care about.

And I'd like to stress that direct path isn't merely legacy.

It's a common sense approach that when you have a hypervisor doing
things like taking care of cache coherency, you do not want to do them
in the guest as well. And the same guest can use a pass-through device
where it does need to do all the coherency mess, so while it's quite
possible to build a platform-specific way to tell guests which devices
need which kind of treatment, people understandably chose to do it in a
portable way through the virtio device.

I understand you guys are working on a new project that is going to use
bounce buffers anyway so what do you care about optimizations but we
can't just slow everyone else down for your benefit.

> > Further you can for example add per-device quirks in virtio so it can be
> > switched to dma api. make extra decisions in platform code then.

Isn't above exactly what you sent to Ram?

-- 
MST
