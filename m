Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f178.google.com (mail-qy0-f178.google.com
	[209.85.221.178]) by ozlabs.org (Postfix) with ESMTP id CDFE6B7C98
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 01:42:52 +1100 (EST)
Received: by qyk8 with SMTP id 8so781924qyk.4
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 07:42:50 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<fa686aa41003232307s39af071bn6377800951d6615c@mail.gmail.com>
	<ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>
	<90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>
	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
	<4BAA4C8A.70104@freescale.com>
	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
From: Timur Tabi <timur@freescale.com>
Date: Thu, 25 Mar 2010 09:42:24 -0500
Message-ID: <ed82fe3e1003250742t5affee7dudca651ab3352bc16@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 24, 2010 at 8:49 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:

> I do; I consider that indirection thing (and putting firmware blobs
> in the device tree at all, but to a lesser extent) as making a mess
> of your device binding.

I guess we'll just have to agree to disagree.

> Let's forget that I do not like putting a firmware blob in the
> device tree if you can at all avoid that; Grant is on that already.

The initrd thing is a good idea, but it doesn't help non-Linux
operating systems.  Then again, those OS's might not have any GPL
issues, so it could be a moot point.

> As far as I can see, you want that indirection node so that you
> safe space in the DTB.

No, I want the indirection node so that I can have multiple QE nodes
point to the same binary data in the DTB.  I don't want to have to do
this:

qe@e8000000 {
    fsl,firmware =3D /incbin/("firmware-file-name.bin");
    ...
}

qe@e9000000 {
    fsl,firmware =3D /incbin/("firmware-file-name.bin");
    ...
}

In this case, I have an SOC with two QE devices, so it has two QE
nodes.  Each needs to be initialized by uploading the same microcode
to it.

>=A0With real OF it is trivial to not have
> multiple copies of the data if you want a few properties with
> the same data. =A0There is no reason this could not be done in DTB
> as well (and some way in DTS to express that, or maybe the tools
> could auto-detect it, whatever).

So you're suggesting a change to DTC to support an enhanced syntax?

> Or you could just zip the DTB.

Sorry, I don't understand how that would help me.

> Can't you link it into the kernel then? =A0Seems a better place for
> it to me. =A0Of course you said something about GPL, heh.

Yes, the firmware is not GPL, so I can't link it into the kernel.
Believe me, it would have solved a lot of problems if we could.

--=20
Timur Tabi
Linux kernel developer at Freescale
