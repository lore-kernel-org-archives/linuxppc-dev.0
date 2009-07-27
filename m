Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E0E9FB7DEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 07:59:31 +1000 (EST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4A6E0AE2.3090600@embeddedarm.com>
References: <4A6DDF80.209@embeddedarm.com>
	<20090727183155.7FA16832E416@gemini.denx.de>
	<4A6E0AE2.3090600@embeddedarm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 27 Jul 2009 15:53:01 -0600
Message-ID: <fa686aa40907271453sd6463c2h62d798af1baf720a@mail.gmail.com>
Subject: Re: image/wrapper script questions
To: Eddie Dawydiuk <eddie@embeddedarm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss <devicetree-discuss@ozlabs.org>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(Adding cc:devicetree-discuss)

On Mon, Jul 27, 2009 at 2:15 PM, Eddie Dawydiuk <eddie@embeddedarm.com> wro=
te:
> Thanks for the link. Although, I'm not looking for info on optimizing
> boot time. Rather I'm looking for information on what the path of least
> resistance is to boot a kernel with an initrd being loaded from it's
> own partition. To clarify currently I am using a simpleImage.initrd which
> is a single image with the flattened device tree, kernel, and initial
> ramdisk in a single file. One can simply load this image in RAM(assuming
> 1 to 1 MMU mapping) and jump into it. Now what I would like to do is to
> load a kernel, device tree, and initial ramdisk into RAM at different
> locations.

Quick word of warning, if you do split the kernel and .dtb images (which
is a good thing to do for several reasons, and I strongly recommend it),
make sure you do *not* hard code the .dtb image into firmware.=A0 If the
end user isn't able to update the .dtb image as easily as updating the
kernel image, then you are asking for a world of hurt for yourself and
your users.

> I'm in the process of coming back up to speed on the low-level boot
> details of the powerpc kernel/architecture. It looks like one can
> accomplish this by loading R3 with the phys address of the device
> tree block, R4 with the phys address of the kernel, and R5 with Null.
> It also looks like the kernel, already has several routines which know
> about these details(prom_init() and __start()) and I was hoping I could
> reuse this code to accomplish this rather than rewriting the bootrom to
> handle this. That is I was hoping there is a boot wrapper image that
> would allow me to accomplish my goal of creating a single image
> containing a kernel and device tree block, and an interface to specify
> where the bootrom loads the initial ramdisk in RAM. I'll continue
> reading through the docs and code, but if anyone could provide any
> pointers on how to do this I would really appreciate it.

It really sounds like you're asking for a new board-specific dtbImage
(which is what dtbImages are designed for).  simpleImage is really just
a dtbImage with the assumption that firmware provides no boot information.

*HOWEVER* dtbImages were really designed for older firmware that cannot
handle the kernel and .dtb images separately.  If you've got control of
the firmware then I strongly recommend *not* relying on the dtbImage
approach of binding the device tree into the kernel image.  You ignore
a lot of the advantages of the device tree model if you do.  In particular
you take on maintenance of a new dtbImage variant in the kernel tree and
loose the ability to build and boot a more or less 'standard' 440 kernel
image.

Honestly, I think you'd be better off adapting your firmware to parse and
boot either a raw vmlinux elf image or a u-boot uImage wrapped image and
pass in the .dtb and initrd pointers.  I predict it will result in far
less confusion for your users (they don't need to know about a particular
'dtbImage.<board>', less maintenance pain for you, and less cursing from
the rest of the powerpc community about an oddball firmware that behaves
differently from everything else (from a boot perspective).

In other words, don't try to adapt the kernel boot to your firmware;
adapt the firmware to an established boot mechanism.

g.

--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
