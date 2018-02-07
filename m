Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zc2yb6TzbzF13V
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Feb 2018 01:00:07 +1100 (AEDT)
Received: by mail-oi0-x244.google.com with SMTP id l8so713214oig.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Feb 2018 06:00:07 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180207124839.GX3404@piout.net>
References: <20180206220534.9929-1-alexandre.belloni@bootlin.com>
 <CAK8P3a0Wmh6acO7W=weX37B2GNbecJQzPhZdVZcXXAwfT6jZ5A@mail.gmail.com>
 <20180207015509.GV3404@piout.net>
 <CAK8P3a3dkAESaqGgLAV9uKKet20rVtBXqBJ-eNGbwQv1i05K7A@mail.gmail.com>
 <20180207124839.GX3404@piout.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Feb 2018 15:00:04 +0100
Message-ID: <CAK8P3a2HscUSs-iV_3dp7+htN+LPFK2LnmiZNTKamQZwMSVxMA@mail.gmail.com>
Subject: Re: [PATCH] char: nvram: disable on ARM
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 7, 2018 at 1:48 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 07/02/2018 at 11:33:55 +0100, Arnd Bergmann wrote:
>> On Wed, Feb 7, 2018 at 2:55 AM, Alexandre Belloni

>> >> $ cat /proc/driver/nvram
>> >> Checksum status: valid
>> >> # floppies     : 0
>> >> Floppy 0 type  : none
>> >> Floppy 1 type  : none
>> >> HD 0 type      : none
>> >> HD 1 type      : none
>> >> HD type 48 data: 0/0/0 C/H/S, precomp 0, lz 0
>> >> HD type 49 data: 156/0/0 C/H/S, precomp 0, lz 0
>> >> DOS base memory: 635 kB
>> >> Extended memory: 65535 kB (configured), 65535 kB (tested)
>> >> Gfx adapter    : EGA, VGA, ... (with BIOS)
>> >> FPU            : not installed
>> >>
>> >
>> > I really don't think anyone is using that but I don't really know much
>> > about x86 and the specification this may be part of.
>> >
>> > I see the info may be used in drivers/video/fbdev/ and
>> > drivers/platform/x86/thinkpad_acpi.c
>>
>> The thinkpad_acpi driver seems to look at some other bytes
>> in the nvram, which have a platform specific meaning.
>>
>
> Yeah, I was more concerned that they need drivers/char/nvram.c for
> nvram_read_byte so we can't simply remove the driver.

Ok, so the procfs interface may be obsolete, but we still need an
interface into the CMOS NVRAM data.

I see that the x86 version of nvram_read_byte is just a wrapper
around CMOS_READ(14 + addr). We also have some drivers
that call the low-level function directly:

arch/x86/include/asm/floppy.h:  val = CMOS_READ(0x10) & 15;
arch/x86/kernel/bootflag.c:     v = CMOS_READ(sbf_port);
drivers/char/mwave/smapi.c:     usSmapiID = CMOS_READ(0x7C);
drivers/input/misc/wistron_btns.c:              qlen = CMOS_READ(cmos_address);

I suppose we could make the thinkpad driver do the same,
or provide a 'static inline' version of nvram_read_byte somewhere.

      Arnd
