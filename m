Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E95632C0086
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2012 08:05:05 +1000 (EST)
Message-ID: <4FF76100.1000006@freescale.com>
Date: Fri, 6 Jul 2012 17:04:48 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 2/3] powerpc/e500: add paravirt QEMU platform
References: <20120627235005.GB9100@tyr.buserror.net>
 <36624A62-88AD-404A-A7A8-02D62E8700F0@suse.de>
 <4FF71164.3040501@freescale.com>
 <D89B244E-C8E0-4CCD-9118-2E84A13B6633@suse.de>
 <4FF717D3.1020005@freescale.com> <0C067161-2FF3-4EF6-BC4D-B3C93828ED36@suse
In-Reply-To: <0C067161-2FF3-4EF6-BC4D-B3C93828ED36@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/06/2012 11:59 AM, Alexander Graf wrote:
> 
> On 06.07.2012, at 18:52, Scott Wood wrote:
> 
>> On 07/06/2012 11:30 AM, Alexander Graf wrote:
>>> 
>>> On 06.07.2012, at 18:25, Scott Wood wrote:
>>> 
>>>> Then what would we do if we want to add an ePAPR virtual PIC
>>>> instead? Or if something replaces MPIC on future FSL chips?
>>> 
>>> Then we need a different compatible anyways, because we wouldn't
>>> be backwards compatible, no?
>> 
>> No, that's exactly what I'm trying to avoid.  This notion of a
>> toplevel compatible that tells you everything you need to know
>> about the machine (even if Linux chooses to be device-tree-based
>> for some arbitrary subset of that information) is incompatible with
>> a flexible virtual platform.
>> 
>> All this compatible is saying is "see the rest of the device
>> tree". How well Linux does so is a quality of implementation issue
>> that can be addressed as needed.  The information about what sort
>> of interrupt controller you have is already in the device tree.
>> The device tree is the machine spec.
>> 
>> Another assumption this patch makes is that it doesn't need
>> SWIOTLB.  Is "has more than 4GiB RAM" a machine attribute that
>> would warrant a separate toplevel compatible?  SWIOTLB for PCI is
>> handled due to the previous patch that provides common PCI code --
>> but in a previous version of the patch it was not handled.  Is it
>> yet another incompatible machine spec if RAM must be less than 4GiB
>> minus PCICSRBAR (ignoring the QEMU bug that PCICSRBAR is not
>> implemented)?
> 
> Well, the thing that I'm wary of is the following. Imagine we make
> this the default machine type for all e500 user cases. Which is
> reasonable. Now we release 3.6 which works awesome with QEMU 1.2. We
> change something in QEMU. QEMU 1.3 comes out. It can no longer boot
> your old kernel 3.6.

Do you expect your old kernel to boot when you get new hardware?  QEMU
is basically hardware that is easy to change.

The only thing that using a more specific compatible would do is make
sure that the kernel wouldn't boot whenever it changes, rather than just
having a chance of certain combinations having problems.

Obviously we should make a reasonable effort to avoid gratuitous
breakage in the default config, but I just don't see how overspecifying
things is going to help.

> That's the type of situation I don't want to be in. We need to be
> backwards compatible with what we used to be able to run. We can get
> away with declaring things as experimental for now, until we settled
> on a reasonable compromise to achieve said compatibility. But it
> needs to be our goal somewhere.
> 
> One idea would be to version the machine type according to what Linux
> implements. If Linux finds a machine type that is newer than what it
> implements, it spawns a warning.

What does it mean to have a version number for a platform which is
intended to eventually be arbitrarily configurable?

> If we want, we can implement
> backwards compatible machine types in QEMU, similar to how we
> implement -M pc-0.12 and friends today.

Heh, I was just about to respond by saying "how would you version a PC"? :-)

If you want a stable versioned platform that happens to not pretend to
be a real board, go ahead and add one -- that's not what this is for.
Maybe instead of documenting things like "has an MPIC", there should be
some comment mentioning that this platform is intended to be flexible
and device tree driven, not static.  The device tree is the machine
spec.  I could see an argument for versioning individual devices, OTOH,
rather than e.g. pretending the PCI is really equivalent to an
mpc8540-pci despite significant missing functionality.

BTW, could you point me to the documentation that explains exactly what
a pc-0.12 is?  And is there any place in Linux that actually sees this
version number and does anything with it?  How would a user know what
version of a PC to request?  What version do you get by default?  Under
what conditions are the version number bumped?

> Again, no need to do so as long as we tell users to not use it. As
> soon as we want them to actually run the machine, we need to have
> independent upgrade paths in place. New QEMU needs to be able to run
> old kernels. New kernels need to be run on old QEMU.

They will, usually.  We can't guarantee this will always be true
regardless of a versioning scheme, since bugs will happen.

>>>> Better to change the Linux implementation as needed than to
>>>> change a spec.
>>> 
>>> Why not keep the 2 in sync in the same patch? Just throw a file
>>> with a rough outline of the machine in Documentation/.
>> 
>> Because that would give people the wrong impression about what
>> this machine is, and be unlikely to stay in sync or be a complete
>> listing of current assumptions.  You're basically suggesting to use
>> Documentation/ as a bug tracker.
> 
> I'm just saying that every time we hardcode assumptions, we need to
> make sure we document it somewhere. And currently we do hardcode
> assumptions, even though only a few.

If you want a bug tracker, use a bug tracker.  Linux already has plenty
of assumptions regarding the real hardware it runs on, how firmware
configures it, etc.  Most of these assumptions are not documented, and
things get changed when new hardware comes along that breaks an
assumption.  Most of the assumptions this platform would be making come
from outside the platform file itself.  If I tried to document it, it
would be incomplete and quickly become out of date.

-Scott
