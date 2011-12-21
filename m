Return-Path: <jwboyer@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DE0E1B7140
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2011 07:20:07 +1100 (EST)
Received: by wgbds13 with SMTP id ds13so11880153wgb.14
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 12:20:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e10be3d24de889e9e80d2fd76de9dcd8@mail.gmail.com>
References: <1324385081-30824-1-git-send-email-vhtnguyen@apm.com>
 <CA+5PVA41Haf-_H3UoR1O3VFbC3XtgScyo5hekNjt0VWxunL-fg@mail.gmail.com>
 <e10be3d24de889e9e80d2fd76de9dcd8@mail.gmail.com>
Date: Wed, 21 Dec 2011 15:20:03 -0500
Message-ID: <CA+5PVA4cjiUvn4YavkFs6Jx87YpO8yHZZbm4pcPJQn1r1cggUA@mail.gmail.com>
Subject: Re: [PATCH 3/3] powerpc/44x: Add support PCI-E for APM821xx SoC and
 Bluestone board
From: Josh Boyer <jwboyer@gmail.com>
To: Vinh Huu Tuong Nguyen <vhtnguyen@apm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ayman El-Khashab <ayman@elkhashab.com>,
 Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
 Lucas De Marchi <lucas.demarchi@profusion.mobi>,
 Rob Herring <rob.herring@calxeda.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 20, 2011 at 11:47 PM, Vinh Huu Tuong Nguyen
<vhtnguyen@apm.com> wrote:
>> +
>> + =A0 =A0 =A0 mtdcri(SDR0, port->sdr_base + PESDRn_RCSSET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mfdcri(SDR0, port->sdr_base + PESDRn_RCSSE=
T) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (PESDRx_RCSSET_RSTGU | PESDRx_RCSSET_RSTPY=
N));
>> +
>> + =A0 =A0 =A0 /* Poll for PHY reset */
>> + =A0 =A0 =A0 timeout =3D 0;
>> + =A0 =A0 =A0 while ((!(mfdcri(SDR0, PESDR0_460EX_RSTSTA +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (port->index * 0x55)) & 0x=
1)) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(timeout < PCIE_PHY_RESET_TIMEOUT)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (timeout < PCIE_PHY_RESET_TIMEOUT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtdcri(SDR0, port->sdr_base + PESDRn_RCSSE=
T,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mfdcri(SDR0, port->sdr_ba=
se + PESDRn_RCSSET) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~(PESDRx_RCSSET_RSTGU | PE=
SDRx_RCSSET_RSTDL)) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PESDRx_RCSSET_RSTPYN);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->has_ibpre =3D 1;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "PCIE: Can't reset PHY\n"=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> + =A0 =A0 =A0 }
>
> If we can't reset the PHY, does this whole function essentially fail?
> Do the devices not get renumbered, etc? =A0If so, you probably want to
> make that KERN_ERR.
> [Vinh Nguyen] if we can't reset the PHY, maybe the device can't work
> properly. I will update codes to return the error in case PHY can't reset=
.

OK.

>> @@ -1751,9 +1856,9 @@ static void __init
> ppc4xx_configure_pciex_PIMs(struct ppc4xx_pciex_port *port,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * if it works
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_le32(mbase + PECFG_PIM0LAL, 0x0000000=
0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_le32(mbase + PECFG_PIM0LAH, 0x00000000=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_le32(mbase + PECFG_PIM0LAH, 0x00000008=
); /* Moving
> on HB */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_le32(mbase + PECFG_PIM1LAL, 0x0000000=
0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_le32(mbase + PECFG_PIM1LAH, 0x00000000=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_le32(mbase + PECFG_PIM1LAH, 0x0000000c=
); /* Moving
> on HB */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_le32(mbase + PECFG_PIM01SAH, 0xffff00=
00);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_le32(mbase + PECFG_PIM01SAL, 0x000000=
00);
>
> Why are these values changed, and are those changes only needed on
> APM821xx?
> [Vinh Nguyen] In system memory map of 460EX chip, we have an "alias DDR
> SDRAM" area that is Local Memory Alias for HB(high bandwidth), so we trie=
d
> to initialize it for speedup. For APM821xx, although we didn't mention
> about this area, this configuration still works well. So we keep it.

This function isn't just called for 460EX or APM821xx SoCs.  It's
called on any 4xx SoC with PCIe configured.
Is this change going to work on them all?  If not, it needs to be
conditionalized.

>> diff --git a/arch/powerpc/sysdev/ppc4xx_pci.h
> b/arch/powerpc/sysdev/ppc4xx_pci.h
>> index 32ce763..faf3017 100644
>> --- a/arch/powerpc/sysdev/ppc4xx_pci.h
>> +++ b/arch/powerpc/sysdev/ppc4xx_pci.h
>> @@ -441,6 +441,7 @@
>> =A0/*
>> =A0* Config space register offsets
>> =A0*/
>> +#define PECFG_ECDEVCTL =A0 =A0 =A0 =A0 0x060
>> =A0#define PECFG_ECRTCTL =A0 =A0 =A0 =A0 =A00x074
>>
>> =A0#define PECFG_BAR0LMPA =A0 =A0 =A0 =A0 0x210
>> @@ -448,6 +449,7 @@
>> =A0#define PECFG_BAR1MPA =A0 =A0 =A0 =A0 =A00x218
>> =A0#define PECFG_BAR2LMPA =A0 =A0 =A0 =A0 0x220
>> =A0#define PECFG_BAR2HMPA =A0 =A0 =A0 =A0 0x224
>> +#define PECFG_ECDEVCAPPA =A0 =A0 =A0 0x25c
>>
>> =A0#define PECFG_PIMEN =A0 =A0 =A0 =A0 =A0 =A00x33c
>> =A0#define PECFG_PIM0LAL =A0 =A0 =A0 =A0 =A00x340
>> @@ -494,5 +496,7 @@ enum
>> =A0 =A0 =A0 =A0LNKW_X8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x8
>> =A0};
>>
>> +/* Timout for reset phy */
>> +#define PCIE_PHY_RESET_TIMEOUT 10
>
> Is this value applicable to all the 44x devices with PCI-e?
> [Vinh Nguyen] At this time, we only checked this on APM821xx chips.

Then it should probably be conditionalized somehow.  Or put as a
worst-case value that will work for them all.

josh
