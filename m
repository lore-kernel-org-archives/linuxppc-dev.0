Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id 9884DDE1D6
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 05:58:30 +1000 (EST)
Received: by gxk20 with SMTP id 20so2218675gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 12:58:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090521165008.A020D710053@mail54-sin.bigfish.com>
References: <20090521162202.10880.34056.stgit@localhost.localdomain>
	<20090521162434.10880.62883.stgit@localhost.localdomain>
	<20090521165008.A020D710053@mail54-sin.bigfish.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 21 May 2009 13:58:01 -0600
Message-ID: <fa686aa40905211258j1e99734dmc1c0bf2bed0c01b7@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] powerpc/virtex: Add Xilinx ML510 reference
	designsupport
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Roderick Colenbrander <thunderbird2k@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 21, 2009 at 10:50 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>> diff --git a/arch/powerpc/platforms/44x/Kconfig
> b/arch/powerpc/platforms/44x/Kconfig
>> index 0d83a6a..af1c51d 100644
>> --- a/arch/powerpc/platforms/44x/Kconfig
>> +++ b/arch/powerpc/platforms/44x/Kconfig
>> @@ -156,7 +156,7 @@ config YOSEMITE
>> =A0# =A0 =A0 =A0This option enables support for the IBM PPC440GX evaluat=
ion
> board.
>>
>> =A0config XILINX_VIRTEX440_GENERIC_BOARD
>> - =A0 =A0 bool "Generic Xilinx Virtex 440 board"
>> + =A0 =A0 bool "Xilinx Virtex 5 support"
>
> 'Virtex 5' is a little ambiguous.. =A0I'd suggest keeping the old wording=
,
> or saying 'Virtex 5 FXT support'. =A0Even then it's somewhat ambiguous,
> since you could conceivably run linux on microblaze on V5FXT and use the
> powerpc for something else..

Considering that this option only appears when AMCC 44x is selected, I
think the ambiguity is minimal.  :-)
I'll add the FXT though.

>> diff --git a/arch/powerpc/platforms/44x/virtex_ml510.c
> b/arch/powerpc/platforms/44x/virtex_ml510.c
>> new file mode 100644
>> index 0000000..ba4a6e3
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/44x/virtex_ml510.c
>> @@ -0,0 +1,29 @@
>> +#include <asm/i8259.h>
>> +#include <linux/pci.h>
>> +#include "44x.h"
>> +
>> +/**
>> + * ml510_ail_quirk
>
> Tpyo, but is the comment even necessary if it doesn't say anything
> useful?

Oops; I started writing a comment and then never completed it.
Roderick; care to contribute some lines as to the purpose of this
block?

>> diff --git a/arch/powerpc/sysdev/xilinx_intc.c
> b/arch/powerpc/sysdev/xilinx_intc.c
>> index 90b5772..3ee1fd3 100644
>> --- a/arch/powerpc/sysdev/xilinx_intc.c
>> +++ b/arch/powerpc/sysdev/xilinx_intc.c
>> @@ -257,6 +257,11 @@ static void __init
> xilinx_i8259_setup_cascade(void)
>> =A0 =A0 =A0 i8259_init(cascade_node, 0);
>> =A0 =A0 =A0 set_irq_chained_handler(cascade_irq, xilinx_i8259_cascade);
>>
>> + =A0 =A0 /* Program irq 7 (usb/audio), 14/15 (ide) to level sensitive *=
/
>> + =A0 =A0 /* This looks like a dirty hack to me --gcl */
>> + =A0 =A0 outb(0xc0, 0x4d0);
>> + =A0 =A0 outb(0xc0, 0x4d1);
>> +
>
> Yeow... I agree about the dirty hack part... =A0shouldn't this be in the
> device tree somewhere, or in the ali driver?

Chatting with Roderick on IRC today, it may be that these two lines
aren't even necessary.  They come from an old guide for porting Linux
to the ml410 in the pre-arch/powerpc days.  Now that IRQ sense is
encoded into the device tree, this probably isn't needed.

> I'm curious if this works on ml410 as well.. =A0(Yes, I know, does this
> really matter much? =A0But there are still a bunch of them floating aroun=
d
> in universities.)

It should do (at least I hope it does).  If I get my hands on an
ML410, then I'll try it out.

> =A0It may be nice to factor this out so ml410/ppc405 and
> microblaze can get it as well.

indeed.

--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
