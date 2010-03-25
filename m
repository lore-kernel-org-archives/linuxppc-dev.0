Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3AA80B7067
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 12:49:44 +1100 (EST)
Message-ID: <65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
In-Reply-To: <4BAA4C8A.70104@freescale.com>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<fa686aa41003232307s39af071bn6377800951d6615c@mail.gmail.com>
	<ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>
	<90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>
	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
	<4BAA4C8A.70104@freescale.com>
Date: Thu, 25 Mar 2010 02:49:20 +0100 (CET)
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Timur Tabi" <timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> Why the phandle redirection?  Why not just put the firmware blob into
>>>>> a property in the QE node, or as a subnode?
>>>>
>>>> Because there might be multiple QE devices on a single chip, and each
>>>> will need to upload the same firmware.  So instead of embedding the
>>>> firmware multiple times, just embed it once, and have a pointer.
>>>
>>> You're messing up the binding because of a (perceived) deficiency in
>>> the DTB format?
>
> Huh?  Who says anything about messing up?

I do; I consider that indirection thing (and putting firmware blobs
in the device tree at all, but to a lesser extent) as making a mess
of your device binding.

Let's forget that I do not like putting a firmware blob in the
device tree if you can at all avoid that; Grant is on that already.

As far as I can see, you want that indirection node so that you
safe space in the DTB.  With real OF it is trivial to not have
multiple copies of the data if you want a few properties with
the same data.  There is no reason this could not be done in DTB
as well (and some way in DTS to express that, or maybe the tools
could auto-detect it, whatever).

Or you could just zip the DTB.

>> That is a good question.  Why is it necessary to pass the blob via the
>> tree?
>
> Because sometimes the firmware is needed before networking or serial I/O
> can function.

Can't you link it into the kernel then?  Seems a better place for
it to me.  Of course you said something about GPL, heh.


Segher
