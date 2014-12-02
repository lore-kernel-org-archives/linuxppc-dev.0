Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C13561A06ED
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 01:55:13 +1100 (AEDT)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id C24CE440E58_47DD2CCB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 14:55:08 +0000 (GMT)
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 81D1843E069_47DD2CBF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 14:55:07 +0000 (GMT)
Received: by mail-wi0-f178.google.com with SMTP id em10so1771359wid.17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Dec 2014 06:55:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1417496585.15957.210.camel@freescale.com>
References: <1417011468-13485-1-git-send-email-alessio.bogani@elettra.eu>
 <1417040495.15957.176.camel@freescale.com>
 <CAPk1OjGGnF6jxxXOOqK4dB9-g2=CyT7DsS8U+KgW3-g2PooXdQ@mail.gmail.com>
 <1417496585.15957.210.camel@freescale.com>
Date: Tue, 2 Dec 2014 15:55:05 +0100
Message-ID: <CAPk1OjE7pAdLucb3+54MnONsNiBgzjvxsA_o-jOdXk9W2CVJAw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] powerpc/85xx: Add support for Emerson/Artesyn
 MVME2500.
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

On 2 December 2014 at 06:03, Scott Wood <scottwood@freescale.com> wrote:
[...]
> I was referring to the final ranges entry:
>
>> +                         0x5 0x0 0x0 0xffdf0000 0x00001000>;
>
> The localbus ranges should reflect what was programmed into BRn/ORn.
> The smallest size that can be programmed into ORn is 32 KiB.

Sorry I'll use 0x8000 instead of 0x1000.

>> The pq3-gpio-0.dtsi defines an gpio controller in this way:
>>
>> gpio-controller@f000 {
>>      reg = <0xf000 0x100>;
>>      [...]
>>
>> But MVME2500 board requires a slightly different definition:
>>
>>      reg = <0xfc00 0x100>;
>
> The GPIO CCSR registers on a P2010 don't change based on what board you
> put it on.  It looks like pq3-gpio-0.dtsi is just wrong, for all chips
> that use it.  It should be fixed there.

I have to admit that I'm not using GPIO at the moment so a typo into
board's manufacturer manual is more probable.

>> > Better still would be if we could have address map tweaks be kconfig
>> > fragments that get mixed in by the user, with merge_config.sh.
>>
>> Personally I would prefer see something more simple like this:
>>
>> %_defconfig: scripts/kconfig/conf
>>    # Grab the platform generic config file (for a SoC family)
>>    $(Q)$< --defconfig=arch/$(SRCARCH)/configs/mpc$(shell dirname
>> $@)_defconfig Kconfig
>
> What is the dirname here trying to do?

Extract string "85xx" from "make 85xx/mvme2500_defconfig" command.

So the above mentioned Makefile snip grabs
arch/powerpc/configs/mpc85xx_defconfig and applies (using
merge_config.sh) options present in
arch/powerpc/configs/85xx/mvme2500_defconfig.

It should reduces the size of the board specific defconfig without
using any other fragments and without change anything in user habits.

In my humble opinion that hardware is so rigid that flexibility given
by config fragments don't seem very useful.

Using this approach the mvme2500_defconfig file could looks like this:

CONFIG_MVME2500=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
# CONFIG_PCIEASPM is not set
CONFIG_SERIAL_8250_NR_UARTS=6
CONFIG_SERIAL_8250_RUNTIME_UARTS=6
CONFIG_BROADCOM_PHY=y
CONFIG_MTD_SPI_NOR=y
CONFIG_MTD_M25P80=y
CONFIG_HWMON=m
CONFIG_SENSORS_LM90=m
CONFIG_EDAC_MPC85XX=y
CONFIG_ADVANCED_OPTIONS=y
CONFIG_LOWMEM_SIZE_BOOL=y
CONFIG_LOWMEM_SIZE=0x40000000
CONFIG_PAGE_OFFSET_BOOL=y
CONFIG_PAGE_OFFSET=0x80000000
CONFIG_KERNEL_START_BOOL=y
CONFIG_TASK_SIZE_BOOL=y
CONFIG_TASK_SIZE=0x80000000
CONFIG_STAGING=y
CONFIG_VME_BUS=y
CONFIG_VME_TSI148=y
CONFIG_VME_USER=y

I know it is a very stupid idea so feel free to ignore me on this point :)

>> > I gues the point here is to avoid using highmem just for the last 256
>> > MiB?
>>
>> Yes. Can you suggest me a better solution, please?
>
> Not if the performance benefit from getting rid of highmem is worth
> carrying this around...  But it would still be good if the board support
> were build in the standard defconfig as well.  It's unlikely to get much
> build coverage (by people who don't use this board) in a board-specific
> defconfig.

Ok I changed mpc85xx_defconfig and it works with few addiction. So we
have two possibilities: use mpc85xx_defconfig (but without VME_USER
and Highmem tweak) or add mvme2500_defconfig: Which do you prefer? I
would prefer the mvme2500_defconfig but I think that my vote doesn't
count (rightly).

What do you think about move board setup code from
platform/85xx/mvme2500.c to platform/platforms/85xx/mpc85xx_ds.c?

Thank you very much.

Ciao,
Alessio
