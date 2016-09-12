Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXZzw58h1zDsMB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 14:47:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Borislav Petkov <bp@alien8.de>
Cc: dougthompson@xmission.com, mchehab@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, arnd@arndb.de
Subject: Re: [PATCH] drivers/edac: NO_IRQ removal from powerpc-only drivers
In-Reply-To: <20160910145320.bg6s6wo5ya7zzw2n@pd.tnic>
References: <1473501428-8217-1-git-send-email-mpe@ellerman.id.au>
 <20160910145320.bg6s6wo5ya7zzw2n@pd.tnic>
Date: Mon, 12 Sep 2016 14:47:37 +1000
Message-ID: <874m5lrafq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Borislav Petkov <bp@alien8.de> writes:

> On Sat, Sep 10, 2016 at 07:57:08PM +1000, Michael Ellerman wrote:
>> We'd like to eventually remove NO_IRQ on powerpc, so remove usages of it
>> from powerpc-only drivers.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  drivers/edac/mpc85xx_edac.c | 6 +++---
>>  drivers/edac/mv64x60_edac.c | 8 ++++----
>>  drivers/edac/ppc4xx_edac.c  | 6 +++---
>>  3 files changed, 10 insertions(+), 10 deletions(-)
>> 
>> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
>> index ca63d0da8889..e12b8e166a53 100644
>> --- a/drivers/edac/mpc85xx_edac.c
>> +++ b/drivers/edac/mpc85xx_edac.c
>> @@ -267,7 +267,7 @@ static int mpc85xx_pci_err_probe(struct platform_device *op)
>>  
>>  	pdata = pci->pvt_info;
>>  	pdata->name = "mpc85xx_pci_err";
>> -	pdata->irq = NO_IRQ;
>> +	pdata->irq = 0;
>>  
>>  	plat_data = op->dev.platform_data;
>>  	if (!plat_data) {
>
> So all of those pdata structs come from kzalloc() so you don't really
> have to assign to 0 - simply kill the line.

OK.

>> @@ -1058,7 +1058,7 @@ static int mpc85xx_mc_err_probe(struct platform_device *op)
>>  
>>  	pdata = mci->pvt_info;
>>  	pdata->name = "mpc85xx_mc_err";
>> -	pdata->irq = NO_IRQ;
>> +	pdata->irq = 0;
>>  	mci->pdev = &op->dev;
>>  	pdata->edac_idx = edac_mc_idx++;
>>  	dev_set_drvdata(mci->pdev, mci);
>
> That part went into drivers/edac/fsl_ddr_edac.c which is only the
> freescale memory controller being shared between ARM and PPC, see
>
> http://git.kernel.org/cgit/linux/kernel/git/bp/bp.git/log/?h=for-next
>
> But that shouldn't change the issue wrt ->irq as now it is implicitly 0.

Ah OK.

NO_IRQ is -1 on ARM (or at least it can be?), see arch/arm/include/asm/irq.h.

So I'll leave that one alone for now.

> IOW, you can drop this hunk.
>
> Please send v2 against the above branch or linux-next.

OK will do.

cheers
