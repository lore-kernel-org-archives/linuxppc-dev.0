Return-Path: <jamie@shareable.org>
Received: from mail2.shareable.org (mail2.shareable.org [80.68.89.115])
	by ozlabs.org (Postfix) with ESMTP id D0108B7D84
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 02:02:14 +1000 (EST)
Date: Mon, 14 Jun 2010 17:02:01 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Request review of device tree documentation
Message-ID: <20100614160201.GD9550@shareable.org>
References: <4C13430B.5000907@firmworks.com>
	<1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop>
	<4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
	<20100614124438.GF9323@yookeroo>
	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <alpine.LFD.2.00.1006141044510.13427@xanadu.home>
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

Nicolas Pitre wrote:
> On Mon, 14 Jun 2010, David Gibson wrote:
> 
> > On Sun, Jun 13, 2010 at 11:02:15PM -0600, Grant Likely wrote:
> > [sni]
> > > > That's sort of a self-fulfilling prophecy.  If the OS doesn't trust the
> > > > firmware, there is no pressure for the firmware to "get it right".
> > > 
> > > Firmware will not get it right.  Period.  There will always be
> > > something wrong.  It is never right on PCs.  It will never be right on
> > > the other architectures.
> > 
> > Yes, yes, yes.  And there is a great deal of empirical evidence to
> > back that assertion.
> > 
> > >  That goes for OSes too, but upgrading an OS
> > > isn't as risky as upgrading firmware.  That isn't to say that it can't
> > > be close, but every firmware feature that the OS depends on is a
> > > feature that could force a risky firmware upgrade when the bug in it
> > > is discovered.
> > 
> > Indeed.  In fact, the general rule of thumb is really "put as much as
> > possible into the most easily replaced layer of the stack".  This is,
> > incidentally, why I've always been dubious about simple firmwares
> > supplying a flattened device tree rather than including the device
> > tree template in the kernel, cuboot style.
> 
> The biggest advantage, IMHO, for adding DT to ARM, is actually to 
> decouple the hardware config information and the kernel.  If in the end 
> the DT has to be shipped in the kernel then we're losing all this 
> advantage over the current state of things on ARM which still works 
> pretty well otherwise.
> 
> In the best case, the simple firmware simply has to retrieve the 
> flattened device tree from flash, and pass it to the kernel just like 
> some anonymous blob.  And the simple firmware only needs to provide a 
> way for that DT blob to be updatable, like through an upload of a 
> replacement blob that was prepared offline.  Just like a ramdisk image 
> or the like.
> 
> That doesn't need to be fancier than that, and the goal of having the DT 
> data tied to the hardware instead of the kernel is achieved.

Imho that puts the DT in a similar category as initrd/initramfs, from
the bootloader's point of view.  It's another blob whose address is
passed to the kernel, just like initrd.

Some bootloaders can't update blobs independently for technical
reasons, or to be minimal.

A device I'm using does kernel updates by updating the whole romfs
boot image, which contains the kernel and other auxiliary blobs used
for booting (splash screen, early irq handlers etc.) as well as the
root filesystem.

It is done that way to pack everything together in the small flash,
and because the NOR flash eraseblocks are too large relative to the
whole flash size to use separate partitions for kernel, boot
filesystem and other blobs for booting.

Dedicating a 64kiB eraseblock out of 2MB just for a small DT would be
quite wasteful.  Dedicating two to make it powerfail-safe would be
even worse.

So requiring that a bootloader can update the DT _independently_ of
everything else is a bit much for some devices.

But requiring that it's generally treated like other separate blob,
i.e. in a similar way to initrd, and the kernel image itself, seems
not unreasonable.

Like initrd, some people will find they need to compile it in to the
kernel image to fit some bootloader they can't change, or daren't risk
changing in already rolled out devices that they want to update to a
DT-using kernel.

I won't be surprised if I see some vendor SDK containing a kernel
patch to early-parse the bootloader-supplied ROMFS image to extract
"devicetree.bin.gz" at some point :-)

We can discourage that sort of thing (but not prevent it) by ensuring
the open source bootloaders support a DT blob as easily as possible.

-- Jamie
