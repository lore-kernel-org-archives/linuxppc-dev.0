Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 5D301B6F6F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2012 09:44:04 +1100 (EST)
Date: Mon, 30 Jan 2012 00:45:07 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH-RFC 06/10] mips: switch to GENERIC_PCI_IOMAP
Message-ID: <20120129223339.GA22666@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
 <66457f7750d7d14229fcf8d0b011aba63185a75d.1322163031.git.mst@redhat.com>
 <CAJiQ=7BPzhWWzU3_nDv3j=ZB4f=iOzeyLyd2L0_3UFaMiLujpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAJiQ=7BPzhWWzU3_nDv3j=ZB4f=iOzeyLyd2L0_3UFaMiLujpw@mail.gmail.com>
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
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Richard Kuo <rkuo@codeaurora.org>, Kyle McMartin <kyle@mcmartin.ca>,
 Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jan 28, 2012 at 02:38:10PM -0800, Kevin Cernekee wrote:
> On Thu, Nov 24, 2011 at 12:18 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > mips copied pci_iomap from generic code, probably to avoid
> > pulling the rest of iomap.c in.  Since that's in
> > a separate file now, we can reuse the common implementation.
> 
> [snip]
> 
> > -       if (flags & IORESOURCE_IO)
> > -               return ioport_map_pci(dev, start, len);
> 
> While investigating a new warning on the 3.3-rc1 MIPS build (unused
> static function ioport_map_pci()), I noticed that this patch has shown
> up in Linus' tree as commit eab90291d35438bcebf7c3dc85be66d0f24e3002.
> 
> I am not completely clear on the implications it has on mapping PCI I/O regions:

Yes, my bad, I missed the difference between ioport_map_pci
and ioport_map for both MIPS and SH.
I'll post a patch to fix this, which is probably preferable
to reintroducing the code duplication where it might
trip us up again.

-- 
MST
