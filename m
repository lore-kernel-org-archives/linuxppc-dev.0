Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id B44171A0C78
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 17:11:56 +1100 (AEDT)
Date: Tue, 3 Feb 2015 17:11:25 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: nvram and generic_nvram modules are problematic, was Re: [PATCH]
 arch: m68k: mac: misc.c: Remove some unused functions
In-Reply-To: <20150201084245.GF26493@n2100.arm.linux.org.uk>
Message-ID: <alpine.LNX.2.00.1502031453160.21644@nippy.intranet>
References: <1420131732-31039-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <alpine.LNX.2.00.1501041045020.15927@nippy.intranet>
 <CAMuHMdXFu3n4d0dMZop186UF+QG=MtLHV=oQr+VszftpEA1kFQ@mail.gmail.com>
 <alpine.LNX.2.00.1502011230150.32582@nippy.intranet>
 <20150201084245.GF26493@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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


On Sun, 1 Feb 2015, Russell King - ARM Linux wrote:

> On Sun, Feb 01, 2015 at 02:39:42PM +1100, Finn Thain wrote:
> > I find the ARM support in drivers/char/nvram to be surprising, not to 
> > say questionable. The /proc/driver/nvram implementation, given 
> > defined(__arm__), decodes the NVRAM contents in exactly the same 
> > format as when defined(__i386__) || defined(__x86_64__).
> 
> That's because it's used on the Netwinder and EBSA285 platforms, which 
> are PCI-like, complete with a southbridge which makes them look like a 
> PC.

Well, that explains the presence of RTC NVRAM, but the question was also 
about the format of that NVRAM.

The the code in question in drivers/char/nvram.c decodes RTC NVRAM on ARM 
as if it took the same format as x86 PC RTC NVRAM. Apparently they are not 
in the same format (for EBSA-285 at least).

I downloaded the EBSA-285 BIOS,
ftp://ftp.arm.linux.org.uk/pub/armlinux/source/boot/bios-1.11.tar.gz

This is from bios/init/cfg.c --

        img_nr = rtc_read_cmos(0);
        root_dev = rtc_read_cmos(2) | rtc_read_cmos(3) << 8;

        for (i = 0; i < 80; i++) {
                extra_args[i] = rtc_read_cmos(128+i);
                if (!extra_args[i])
                        break;
        }
        extra_args[79] = '\0';

(Like /dev/nvram, file offset 0 is actually device offset 14.)

This EBSA-285 BIOS code uses bytes 128 through 208 as "extra_args", 
whereas /dev/nvram has only 114 bytes in total. The EBSA-285 BIOS doesn't 
read or write any checksum.

The first two bytes aren't reported in /proc/driver/nvram, whereas 
EBSA-285 BIOS uses them for img_nr and root_dev. The next one is reported 
as "floppy type" on x86 PC, though the EBSA-285 BIOS uses it for 
root_dev >> 8.

This is from an x86 PC, for example:

# cat /proc/driver/nvram 
Checksum status: valid
# floppies     : 1
Floppy 0 type  : none
Floppy 1 type  : none
HD 0 type      : 01
HD 1 type      : none
HD type 48 data: 512/0/0 C/H/S, precomp 0, lz 256
HD type 49 data: 1/124/0 C/H/S, precomp 0, lz 0
DOS base memory: 640 kB
Extended memory: 64512 kB (configured), 64512 kB (tested)
Gfx adapter    : EGA, VGA, ... (with BIOS)
FPU            : installed

My original question was whether the CONFIG_PROC_FS support found in 
drivers/char/nvram.c should be moved to arch/x86 and arch/m68k.

So that question now seems to hinge on the Netwinder ROM ("nettrom") which 
I gather is proprietary (I didn't find any source code). Does anyone know 
what format the Netwinder NVRAM takes?

If NVRAM on Netwinder has a different format to x86 PC, then the 
CONFIG_PROC_FS code in drivers/char/nvram should go elsewhere.

And if the NVRAM on Netwinder had no checksum, drivers/char/nvram.c would 
become a generic /dev/nvram misc device, and drivers/char/generic_nvram.c 
could go away, along with its inherent problems.

-- 
