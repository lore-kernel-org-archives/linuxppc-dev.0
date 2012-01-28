Return-Path: <cernekee@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8C3D4B6F9B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jan 2012 09:38:21 +1100 (EST)
Received: by dadz14 with SMTP id z14so2618749dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2012 14:38:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <66457f7750d7d14229fcf8d0b011aba63185a75d.1322163031.git.mst@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
 <66457f7750d7d14229fcf8d0b011aba63185a75d.1322163031.git.mst@redhat.com>
Date: Sat, 28 Jan 2012 14:38:10 -0800
Message-ID: <CAJiQ=7BPzhWWzU3_nDv3j=ZB4f=iOzeyLyd2L0_3UFaMiLujpw@mail.gmail.com>
Subject: Re: [PATCH-RFC 06/10] mips: switch to GENERIC_PCI_IOMAP
From: Kevin Cernekee <cernekee@gmail.com>
To: Ralf Baechle <ralf@linux-mips.org>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips@linux-mips.org,
 linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, linux@openrisc.net, linux-pci@vger.kernel.org,
 Jesse Barnes <jbarnes@virtuousgeek.org>, Chen Liqin <liqin.chen@sunplusct.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Lennox Wu <lennox.wu@gmail.com>, Jonas Bonn <jonas@southpole.se>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Russell King <linux@arm.linux.org.uk>, linux-hexagon@vger.kernel.org,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-arch@vger.kernel.org,
 Arend van Spriel <arend@broadcom.com>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Lasse Collin <lasse.collin@tukaani.org>,
 Arnd Bergmann <arnd@arndb.de>, Lucas De Marchi <lucas.demarchi@profusion.mobi>,
 microblaze-uclinux@itee.uq.edu.au, Paul Bolle <pebolle@tiscali.nl>,
 Rob Herring <rob.herring@calxeda.com>, Mikael Starvik <starvik@axis.com>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Franky Lin <frankyl@broadcom.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Fabio Baltieri <fabio.baltieri@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Michael Ellerman <michael@ellerman.id.au>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, Paul Gortmaker <paul.gortmaker@windriver.com>,
 linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>,
 Kyle McMartin <kyle@mcmartin.ca>, Paul Mundt <lethal@linux-sh.org>,
 linux-alpha@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 24, 2011 at 12:18 PM, Michael S. Tsirkin <mst@redhat.com> wrote=
:
> mips copied pci_iomap from generic code, probably to avoid
> pulling the rest of iomap.c in. =C2=A0Since that's in
> a separate file now, we can reuse the common implementation.

[snip]

> - =C2=A0 =C2=A0 =C2=A0 if (flags & IORESOURCE_IO)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ioport_map_pci(=
dev, start, len);

While investigating a new warning on the 3.3-rc1 MIPS build (unused
static function ioport_map_pci()), I noticed that this patch has shown
up in Linus' tree as commit eab90291d35438bcebf7c3dc85be66d0f24e3002.

I am not completely clear on the implications it has on mapping PCI I/O reg=
ions:

Prior to this change, the MIPS version of pci_iomap() called a
MIPS-specific function, ioport_map_pci(), which tried to use the PCI
controller's io_map_base field to determine the base address of the
PCI I/O space.  It also had a fallback mechanism to deal with the case
where io_map_base is unset.

Now, in 3.3-rc1, the generic version of pci_iomap() is used instead.
This code just calls arch/mips/lib/iomap.c:ioport_map() on these
regions.  ioport_map() falls through to ioport_map_legacy(), which
always uses mips_io_port_base (not the PCI controller's io_map_base)
as the base address.  But on MIPS, it is still permissible to use
different I/O port bases for PCI devices and for legacy (ISA?)
devices.

Is this new behavior desirable, or are there any supported platforms
on which adverse effects might be seen?

As for my part, I don't use PCI I/O regions at all - just memory
regions.  I'm more worried about making sure my tree builds with 0
warnings.

If we do want to move ahead with the switch to GENERIC_PCI_IOMAP now,
I have patches to scrap iomap-pci.c entirely and squash the unused
function warning.

If we still want to support the case where io_map_base !=3D
mips_io_port_base, maybe it would be better to revert commit eab90291
for 3.3.

Might also want to take a look at SH since it also appears to have an
orphaned ioport_map_pci() function.

What are your thoughts?
