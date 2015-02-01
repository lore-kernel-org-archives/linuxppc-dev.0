Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BDB91A0D87
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 19:43:12 +1100 (AEDT)
Date: Sun, 1 Feb 2015 08:42:45 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: nvram and generic_nvram modules are problematic, was Re: [PATCH]
 arch: m68k: mac: misc.c: Remove some unused functions
Message-ID: <20150201084245.GF26493@n2100.arm.linux.org.uk>
References: <1420131732-31039-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <alpine.LNX.2.00.1501041045020.15927@nippy.intranet>
 <CAMuHMdXFu3n4d0dMZop186UF+QG=MtLHV=oQr+VszftpEA1kFQ@mail.gmail.com>
 <alpine.LNX.2.00.1502011230150.32582@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1502011230150.32582@nippy.intranet>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 01, 2015 at 02:39:42PM +1100, Finn Thain wrote:
> I find the ARM support in drivers/char/nvram to be surprising, not to say 
> questionable. The /proc/driver/nvram implementation, given 
> defined(__arm__), decodes the NVRAM contents in exactly the same format as 
> when defined(__i386__) || defined(__x86_64__).

That's because it's used on the Netwinder and EBSA285 platforms, which
are PCI-like, complete with a southbridge which makes them look like a
PC.

> Whereas, only MIPS and 
> PowerPC defconfigs set CONFIG_RTC_DRV_CMOS at all, and without that symbol 
> the driver will never be built for ARM. This raises the question, does 
> /proc/driver/nvram do anything useful on any ARM platforms?

Yes.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
