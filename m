Return-Path: <vasbridge@sanblaze.com>
Received: from mail.gazungle.com (mail.gazungle.com [207.210.240.68])
	by ozlabs.org (Postfix) with ESMTP id F2D9BDDF81
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Jul 2008 07:34:06 +1000 (EST)
From: "Vince Asbridge" <vasbridge@sanblaze.com>
To: <linuxppc-embedded@ozlabs.org>,
	"'Stephen Shirron'" <sshirron@sanblaze.com>,
	"'Mitul Patel'" <mpatel@sanblaze.com>,
	"'Dave Maruska'" <dmaruska@sanblaze.com>,
	"'Geary Sean-R60898'" <sean.geary@freescale.com>,
	"'Hynes, Stephen'" <Stephen.Hynes@lsi.com>
Subject: RE: Migrating from 2.6.11 to 2.6.23 breaks pci-e with LSI 1068 SAS
	chip (solved!)
Date: Wed, 2 Jul 2008 17:40:04 -0400
Message-ID: <037e01c8dc8c$3147a450$4b01a8c0@sanblaze.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_037F_01C8DC6A.AA360450"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_037F_01C8DC6A.AA360450
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Solved!

Problem summary.

LSI logic devices (1068e, 1064e, fc949e) do not work with uBoot version
1.3.0 and Linux kernel 2.6.23, where they work perfectly fine in kernel
2.6.11.

Symptom is that they do not show up at all to Linux once booted (lspci shows
nothing).

We obtained a pci-e analyzer and found the following:

uBoot V1.3.0 now scans the pci configuration, and when it does it assigns
bus numbers to the pci-e devices it finds.  These numbers that are assigned
are different from those that are assigned by Linux when the system boots.

It is legal to change pci-e bus numbers "on the fly" but doing so requires a
config write cycle to the pci-e device, because the pci-e spec states that
the device must register a new bus number if a config write cycle is issues
with the new bus number.

When we boot the Freescale machine with uBoot 1.3.0 and kernel 2.6.23, the
bus number under uBoot gets assigned to 1, and the bus number under Linux
gets assigned to 4.  Between the change of bus numbers we do not see a
config write go to the LSI device with the new bus number, and therefore it
continues to respond on bus 1 and ignore config reads to bus 4.

We temporarily fixed the issue by defining the CONFIG_PCI_NOSCAN flag under
uBoot, which causes the LSI device not to get assigned a bus number at
uBoot, and therefore when Linux begins doing config reads at bus 4 to the
LSI device registers the bus number and responds correctly.

We will do a bit more investigation to see if this has already been fixed in
a newer kernel, but for now not scanning at uBoot fixes the issue.

It's a bit of a mystery why the LSI devices behave differently from any
other pci-e device we put in the system, but they seem to be adhering to the
letter of the specification.

Vince Asbridge

------- original post -------

All,

I'm new to this mailing list, but have not had any luck finding information
on this issue.

Please be kind if I break the forum rules on my first post.

We recently tried to upgrade our Freescale CDS 8548 look-alike module (code
name ATCA1000) from the 2.6.11 based BSP to the 2.6.23 based BSP.

The upgrade went fairly smoothly, until we tried using SOME pci-e devices
(some work fine, some don't show up to lspci).

LSI pci-e controllers no longer show up at all!

We see the ixgbe (intel 10G), SiliconImage SATA controller but do not see
LSI devices (Specifically 1068 SAS, FC949-E fibrechannel).

We're guessing it's a resource issue behind the bridge, because the LSI
devices try to allocate 1 - 3M behind the bridge, but we can't find the bug,
or where we would debug such an issue.

The devices seem to "train" correctly, because we have an LED on the pci-e
switch (PLX 8 port pci-e switch), and it's ON indicating pci-e link between
the bridge and the 1068 device).

We're totally at a loss as to why this always worked on the 2.6.11 kernel
but doesn't work on 2.6.23.

Using lspci, the LSI adapters do not show up in the list at all, as though
they are not plugged into the system.

Is there something that needs to be done with respect to PCI-E devices that
is new in the 2.6.23 based BSP that did not need to be done in the 2.6.11
based kit?  For example, are pci resources allocated by a different piece of
code, that may have some issue allocating resources for the LSI adapters?

I currently do not have access to a pci-e analyzer.

Thanks for any help,
Vince Asbridge




------=_NextPart_000_037F_01C8DC6A.AA360450
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

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

------=_NextPart_000_037F_01C8DC6A.AA360450--
