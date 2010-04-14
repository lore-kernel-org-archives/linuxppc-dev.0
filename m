Return-Path: <benh@kernel.crashing.org>
Subject: Re: Resetting PCI-E devices after linux boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jake Magee <jakemagee@gmail.com>
In-Reply-To: <t2wa8142e731004140655p230f7094idc29e489ea09e848@mail.gmail.com>
References: <4BAC0D4B.3030507@fulcrummicro.com>
	<t2wa8142e731004140655p230f7094idc29e489ea09e848@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Apr 2010 08:25:23 +1000
Message-ID: <1271283923.13059.150.camel@pasglop>
Mime-Version: 1.0
Cc: Dan Wilson <dwilson@fulcrummicro.com>, Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-04-14 at 08:55 -0500, Jake Magee wrote:
> On Thu, Mar 25, 2010 at 8:26 PM, Dan Wilson <dwilson@fulcrummicro.com>
> wrote:
>         We are building a PCI-E device for use in an embedded system
>         with an 85xx processor.  One of our customers is adamant that
>         linux PCI-E hot-swap support will not allow us to either bring
>         the device up after linux boot (i.e., the PCI-E device must be
>         present when linux scans for PCI-E devices at startup) or to
>         reset the device once linux is up.  It was our impression that
>         the PCI-E hot-swap support should allow for devices to appear
>         after linux boot, be properly initialized, and then later be
>         able to shut them down and bring them back up again.
>         
>         Has anyone successfully used the PCI-E hot-swap capabilities
>         in the linux kernel in a PPC 85xx environment?  Any known
>         gotchas we need to be aware of?
>         
>         Thanks in advance for your responses,

It should be possible to get that working, but I suspect not without
some code changes. I know the current PCIe hotswap driver has ACPI hooks
that would need to be replaced by appropriate hooks into the powerpc
code to perform the right resource manipulation etc...

We do PCIe hotswap on IBM pSeries, but this is using specific FW
interfaces for which we have a dedicated PCI hotplug driver.

Can the slot power be SW controlled on the Canyonlands PCIe slot ? In
that case I should be able to toy with that myself at some stage (but
not for a couple of weeks).

Cheers,
Ben.
