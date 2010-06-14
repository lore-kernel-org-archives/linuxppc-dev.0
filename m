Return-Path: <nico@fluxnic.net>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by ozlabs.org (Postfix) with ESMTP id 429B4B7DA2
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 02:23:40 +1000 (EST)
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_Jieu1vixw3uCkMJRR0q6Qw)"
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
	(Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008;
	32bit))
	with ESMTP id <0L40001FEIVEONA0@VL-MO-MR002.ip.videotron.ca> for
	linuxppc-dev@ozlabs.org; Mon, 14 Jun 2010 12:23:39 -0400 (EDT)
Date: Mon, 14 Jun 2010 12:23:38 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: Request review of device tree documentation
In-reply-to: <20100614160201.GD9550@shareable.org>
Message-id: <alpine.LFD.2.00.1006141206110.13427@xanadu.home>
References: <4C13430B.5000907@firmworks.com>
	<1276339529.1962.184.camel@pasglop> <1276339684.1962.186.camel@pasglop>
	<4C13B618.1030006@firmworks.com> <1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
	<20100614124438.GF9323@yookeroo>
	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>
	<20100614160201.GD9550@shareable.org>
Cc: microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Mitch Bradley <wmb@firmworks.com>,
	Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	linux-arm-kernel@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Jieu1vixw3uCkMJRR0q6Qw)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Mon, 14 Jun 2010, Jamie Lokier wrote:

> Nicolas Pitre wrote:
> > On Mon, 14 Jun 2010, David Gibson wrote:
> > 
> > > On Sun, Jun 13, 2010 at 11:02:15PM -0600, Grant Likely wrote:
> > > [sni]
> > > > > That's sort of a self-fulfilling prophecy.  If the OS doesn't trust the
> > > > > firmware, there is no pressure for the firmware to "get it right".
> > > > 
> > > > Firmware will not get it right.  Period.  There will always be
> > > > something wrong.  It is never right on PCs.  It will never be right on
> > > > the other architectures.
> > > 
> > > Yes, yes, yes.  And there is a great deal of empirical evidence to
> > > back that assertion.
> > > 
> > > >  That goes for OSes too, but upgrading an OS
> > > > isn't as risky as upgrading firmware.  That isn't to say that it can't
> > > > be close, but every firmware feature that the OS depends on is a
> > > > feature that could force a risky firmware upgrade when the bug in it
> > > > is discovered.
> > > 
> > > Indeed.  In fact, the general rule of thumb is really "put as much as
> > > possible into the most easily replaced layer of the stack".  This is,
> > > incidentally, why I've always been dubious about simple firmwares
> > > supplying a flattened device tree rather than including the device
> > > tree template in the kernel, cuboot style.
> > 
> > The biggest advantage, IMHO, for adding DT to ARM, is actually to 
> > decouple the hardware config information and the kernel.  If in the end 
> > the DT has to be shipped in the kernel then we're losing all this 
> > advantage over the current state of things on ARM which still works 
> > pretty well otherwise.
> > 
> > In the best case, the simple firmware simply has to retrieve the 
> > flattened device tree from flash, and pass it to the kernel just like 
> > some anonymous blob.  And the simple firmware only needs to provide a 
> > way for that DT blob to be updatable, like through an upload of a 
> > replacement blob that was prepared offline.  Just like a ramdisk image 
> > or the like.
> > 
> > That doesn't need to be fancier than that, and the goal of having the DT 
> > data tied to the hardware instead of the kernel is achieved.
> 
> Imho that puts the DT in a similar category as initrd/initramfs, from
> the bootloader's point of view.  It's another blob whose address is
> passed to the kernel, just like initrd.

Exact.

> Some bootloaders can't update blobs independently for technical
> reasons, or to be minimal.
> 
> A device I'm using does kernel updates by updating the whole romfs
> boot image, which contains the kernel and other auxiliary blobs used
> for booting (splash screen, early irq handlers etc.) as well as the
> root filesystem.
> 
> It is done that way to pack everything together in the small flash,
> and because the NOR flash eraseblocks are too large relative to the
> whole flash size to use separate partitions for kernel, boot
> filesystem and other blobs for booting.

If you already have to update everything at once already anyway, then 
the DT blob just has to be in that update.  No need to do otherwise if 
you can't do better than that for the kernel alone.

> Dedicating a 64kiB eraseblock out of 2MB just for a small DT would be
> quite wasteful.  Dedicating two to make it powerfail-safe would be
> even worse.

I hardly see how you can be power fail safe with your 
update-everything-at-once condition above anyway.

Furthermore, if the DT is updated by the bootloader, then that means 
you're not running a live system at that point.  If power fails during 
the DT update, then you simply have to re-update it when power is back 
to allow a successful boot of the kernel afterwards.

> So requiring that a bootloader can update the DT _independently_ of
> everything else is a bit much for some devices.

In my opinion, this use case you're illustrating above simply could 
continue to _not_ use DT at all.  If your NOR flash is so small that you 
cannot spare some extra erase blocks, then this is a deeply embedded 
profile the current DT-on-ARM push is not really meant for.  You would 
be much better with a minimally configured kernel with all the hardware 
info statically compiled into the kernel and get away without all the DT 
parsing code altogether, like you're already doing today.

While I think DT for ARM has advantages, I don't see us dropping the 
legacy ARM methods anytime soon, especially for existing or extremely 
constrained targets.


Nicolas

--Boundary_(ID_Jieu1vixw3uCkMJRR0q6Qw)--
