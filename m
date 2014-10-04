Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 771A81A0315
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Oct 2014 22:02:24 +1000 (EST)
Message-ID: <542FE1C4.7000403@c-s.fr>
Date: Sat, 04 Oct 2014 14:02:12 +0200
From: christophe leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/2] spi: fsl-spi: Fix parameter ram offset setup for
 CPM1
References: <20141003164916.DBD631AAFA2@localhost.localdomain>
 <1412368198.13320.434.camel@snotra.buserror.net>
In-Reply-To: <1412368198.13320.434.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 03/10/2014 22:29, Scott Wood a écrit :
> On Fri, 2014-10-03 at 18:49 +0200, Christophe Leroy wrote:
>> On CPM1, the SPI parameter RAM has a default location. In fsl_spi_cpm_get_pram()
>> there was a confusion between the SPI_BASE register and the base of the SPI
>> parameter RAM. Fortunatly, it was working properly with MPC866 and MPC885
>> because they do set SPI_BASE, but on MPC860 and other old MPC8xx that doesn't
>> set SPI_BASE, pram_ofs was not properly set. This patch fixes this confusion.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>
>> ---
>> Changes from v1 to v2: none
>>
>>   drivers/spi/spi-fsl-cpm.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
>> index 54b0637..0f3a912 100644
>> --- a/drivers/spi/spi-fsl-cpm.c
>> +++ b/drivers/spi/spi-fsl-cpm.c
>> @@ -262,15 +262,14 @@ static unsigned long fsl_spi_cpm_get_pram(struct mpc8xxx_spi *mspi)
>>   		pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 64);
>>   		out_be16(spi_base, pram_ofs);
>>   	} else {
>> -		struct spi_pram __iomem *pram = spi_base;
>> -		u16 rpbase = in_be16(&pram->rpbase);
>> +		u16 rpbase = in_be16(spi_base);
>>   
>> -		/* Microcode relocation patch applied? */
>> +		/* Microcode relocation patch applied | rpbase set by default */
>>   		if (rpbase) {
>>   			pram_ofs = rpbase;
>>   		} else {
>> -			pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 64);
>> -			out_be16(spi_base, pram_ofs);
>> +			pram_ofs = offsetof(cpm8xx_t, cp_dparam[PROFF_SPI]) -
>> +				   offsetof(cpm8xx_t, cp_dpmem[0]);
>>   		}
>>   	}
> Why is PROFF_SPI not coming from the device tree?
That's where it starts to become tricky.

PROFF_SPI is defined in cpm1.h which is included by the driver already. 
It provides the default offset from the start of the parameter RAM.
Previously I had the following in my device tree, and the last part of 
the source above (the one for rpbase == 0) could not work.

             spi: spi@a80 {
                 cell-index = <0>;
                 compatible = "fsl,spi", "fsl,cpm1-spi";
                 reg = <0xa80 0x30 0x3d80 0x30>;

First reg area was the area for SPI registers. Second area was the 
parameter RAM zone, which was just mapped to get access to the SPI_BASE 
pointer (rpbase)

Now I have

                 compatible = "fsl,spi", "fsl,cpm1-spi-reloc";
                 reg = <0xa80 0x30 0x3dac 0x2>;

First reg area is the area for SPI registers. Second area is the 
SPI_BASE, as for the CPM2.

On recent 8xx (885 and 866 at least) it contains the offset (=0x1D80) of 
the parameter RAM. But on old ones (860, ...) it contains 0. Therefore 
we have to get the default index in another way.
What I wanted was to keep something similar to what's done with CPM2.

What should it look like if that offset had to be in the device tree ?

> Why don't I see any
> cpm spi in any device tree nor any binding for it?
There's one in mgcoge.dts:

             spi@11aa0 {
                 cell-index = <0>;
                 compatible = "fsl,spi", "fsl,cpm2-spi";
                 reg = <0x11a80 0x40 0x89fc 0x2>;

Christophe

---
Ce courrier électronique ne contient aucun virus ou logiciel malveillant parce que la protection avast! Antivirus est active.
http://www.avast.com
