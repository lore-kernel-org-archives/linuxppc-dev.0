Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8801DB6F9D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jun 2011 01:17:24 +1000 (EST)
Message-ID: <4DF8CCD5.3080005@zytor.com>
Date: Wed, 15 Jun 2011 08:16:37 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
References: <20110614190850.GA13526@linux-mips.org>
	<987664A83D2D224EAE907B061CE93D5301E7281306@orsmsx505.amr.corp.intel.com>
	<4DF8359F.10809@zytor.com>
	<20110615073935.GA28989@n2100.arm.linux.org.uk>
In-Reply-To: <20110615073935.GA28989@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Helge Deller <deller@gmx.de>, "x86@kernel.org" <x86@kernel.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Matt Turner <mattst88@gmail.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"microblaze-uclinux@itee.uq.edu.au" <microblaze-uclinux@itee.uq.edu.au>,
	Chris Metcalf <cmetcalf@tilera.com>, Mikael Starvik <starvik@axis.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
	"Luck, Tony" <tony.luck@intel.com>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@mcmartin.ca>,
	Paul Mundt <lethal@linux-sh.org>,
	"linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/15/2011 12:39 AM, Russell King - ARM Linux wrote:
> On Tue, Jun 14, 2011 at 09:31:27PM -0700, H. Peter Anvin wrote:
>> On 06/14/2011 03:08 PM, Luck, Tony wrote:
>>> I took a look at the back of all my ia64 systems - none of them
>>> have a parallel port.  It seems unlikely that new systems will
>>> start adding parallel ports :-)
>>>
>>> So even if I had a printer (or other device) that used a parallel
>>> port, I have no way to test it.
>>
>> If it has PCI slots, it can have a parallel port.
> 
> Is that a clue about where a select statement should be?

Not really, because it's a sufficient condition, not a required one.

All a platform needs to expose a PC-style parallel port interface is a
minimum of 3 contiguous I/O locations, and although in the PC they are
I/O mapped, they don't need to be.

The basic (SPP) parallel port interface is really just a glorified set
of GPIOs and could at least in theory be implemented as-is on any
platform with contiguous GPIO ports.  The faster modes (EPP and ECP) do
contain logic, and ECP depends on the ISA DMA API (thanks to Russell for
pointing out that actual ISA DMA is not required, any slave DMA solution
will do.)


	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
