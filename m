Return-Path: <miesfeld@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 54B19DDE98
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 09:35:27 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so835856ywt.39
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 16:35:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090429232818.A15B683420EE@gemini.denx.de>
References: <1241042419-19774-1-git-send-email-fkan@amcc.com>
	<20090429232818.A15B683420EE@gemini.denx.de>
Date: Wed, 29 Apr 2009 16:35:26 -0700
Message-ID: <5d74c5720904291635q7371bf2ck82b272abe92d7660@mail.gmail.com>
Subject: Re: [PATCH 1/2] Add support for Designware SATA controller driver
From: Mark Miesfeld <miesfeld@gmail.com>
To: Feng Kan <fkan@amcc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Feng,

Can you just insert my Signed off by line, using Mark Miesfeld
<miesfeld@gmail.com>

I always goof up the formatting.  If that is okay with you and meets
your ethical standards.

--
Mark Miesfeld
miesfeld@gmail.com

On Wed, Apr 29, 2009 at 4:28 PM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Feng Kan,
>
> In message <1241042419-19774-1-git-send-email-fkan@amcc.com> you wrote:
>> Signed-off-by: Feng Kan <fkan@amcc.com>
>> ---
>> =A0drivers/ata/Kconfig =A0 =A0| =A0 76 +-
>> =A0drivers/ata/Makefile =A0 | =A0 =A01 +
>> =A0drivers/ata/sata_dwc.c | 2047 +++++++++++++++++++++++++++++++++++++++=
+++++++++
>> =A03 files changed, 2091 insertions(+), 33 deletions(-)
>> =A0create mode 100644 drivers/ata/sata_dwc.c
>>
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index 0bcf264..5321e47 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -72,56 +72,66 @@ config SATA_FSL
>>
>> =A0 =A0 =A0 =A0 If unsure, say N.
>>
>> -config ATA_SFF
>> - =A0 =A0 bool "ATA SFF support"
>> - =A0 =A0 default y
>> +config SATA_DWC
>> + =A0 =A0 tristate "DesignWare Cores SATA support"
>> + =A0 =A0 depends on 460EX
>> =A0 =A0 =A0 help
>> - =A0 =A0 =A0 This option adds support for ATA controllers with SFF
>> - =A0 =A0 =A0 compliant or similar programming interface.
>> + =A0 =A0 =A0 This option enables support for the Synopsys DesignWare Co=
res SATA
>> + =A0 =A0 =A0 controller.
>> + =A0 =A0 =A0 It can be found on the AMCC 460EX.
>>
>> - =A0 =A0 =A0 SFF is the legacy IDE interface that has been around since
>> - =A0 =A0 =A0 the dawn of time. =A0Almost all PATA controllers have an
>> - =A0 =A0 =A0 SFF interface. =A0Many SATA controllers have an SFF interf=
ace
>> - =A0 =A0 =A0 when configured into a legacy compatibility mode.
>> + =A0 =A0 =A0 If unsure, say N.
>>
>> - =A0 =A0 =A0 For users with exclusively modern controllers like AHCI,
>> - =A0 =A0 =A0 Silicon Image 3124, or Marvell 6440, you may choose to
>> - =A0 =A0 =A0 disable this uneeded SFF support.
>> +config ATA_SFF
>> +bool "ATA SFF support"
>> +default y
>> +help
>> + =A0This option adds support for ATA controllers with SFF
>> + =A0compliant or similar programming interface.
>>
>> - =A0 =A0 =A0 If unsure, say Y.
>> + =A0SFF is the legacy IDE interface that has been around since
>> + =A0the dawn of time. =A0Almost all PATA controllers have an
>> + =A0SFF interface. =A0Many SATA controllers have an SFF interface
>> + =A0when configured into a legacy compatibility mode.
>> +
>> + =A0For users with exclusively modern controllers like AHCI,
>> + =A0Silicon Image 3124, or Marvell 6440, you may choose to
>> + =A0disable this uneeded SFF support.
>> +
>> + =A0If unsure, say Y.
>
> Why are you reformatting exiting, correct help text, into brokenness?
>
> ...
>> +static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
>> +{
> ...
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(ap->dev, "%s non-NCQ cmd interrupt, pr=
otocol: %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, prot_2_txt(qc->tf.pr=
otocol));
>> +DRVSTILLBUSY:
> ^^^^^^^^^^^^^^^^
> ...
>> +PROCESS: =A0/* process completed commands */
> ^^^^^^^^^^^
>
> ...
>> +STILLBUSY:
> ^^^^^^^^^^^^^
> ...
>> +DONE:
> ^^^^^^^^
>
> etc. =A0Please do not use all-caps identifier names (not even for
> labels).
>
> ...
>> +/**********************************************************************=
*********
>> + * Function : sata_dwc_port_start
>> + * arguments : struct ata_ioports *port
>> + * Return value : returns 0 if success, error code otherwise
>> + * This function allocates the scatter gather LLI table for AHB DMA
>> + **********************************************************************=
********/
>
> Here and elsewhere: incorrect multiline comment style.
>
> ...
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Mark Miesfeld <mmiesfeld@amcc.com>");
>
> Should not Mark add his Signed-off-by: line, too?
>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH, =A0 =A0 MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> Conscious is when you are aware of something, and conscience is =A0when
> you wish you weren't.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
