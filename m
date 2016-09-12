Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXjs73fdGzDrcD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 19:57:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>, dougthompson@xmission.com,
 mchehab@kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] drivers/edac: NO_IRQ removal from powerpc-only drivers
In-Reply-To: <4413035.eY2sIBJ9x6@wuerfel>
References: <1473501428-8217-1-git-send-email-mpe@ellerman.id.au>
 <20160910145320.bg6s6wo5ya7zzw2n@pd.tnic>
 <874m5lrafq.fsf@concordia.ellerman.id.au> <4413035.eY2sIBJ9x6@wuerfel>
Date: Mon, 12 Sep 2016 19:57:11 +1000
Message-ID: <871t0pqw3s.fsf@concordia.ellerman.id.au>
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

Arnd Bergmann <arnd@arndb.de> writes:

> On Monday, September 12, 2016 2:47:37 PM CEST Michael Ellerman wrote:
>> >> @@ -1058,7 +1058,7 @@ static int mpc85xx_mc_err_probe(struct platform_device *op)
>> >>  
>> >>      pdata = mci->pvt_info;
>> >>      pdata->name = "mpc85xx_mc_err";
>> >> -    pdata->irq = NO_IRQ;
>> >> +    pdata->irq = 0;
>> >>      mci->pdev = &op->dev;
>> >>      pdata->edac_idx = edac_mc_idx++;
>> >>      dev_set_drvdata(mci->pdev, mci);
>> >
>> > That part went into drivers/edac/fsl_ddr_edac.c which is only the
>> > freescale memory controller being shared between ARM and PPC, see
>> >
>> > http://git.kernel.org/cgit/linux/kernel/git/bp/bp.git/log/?h=for-next
>> >
>> > But that shouldn't change the issue wrt ->irq as now it is implicitly 0.
>> 
>> Ah OK.
>> 
>> NO_IRQ is -1 on ARM (or at least it can be?), see arch/arm/include/asm/irq.h.
>> 
>> So I'll leave that one alone for now.
>
> I don't think there is any way to build the mpc85xx on ARM, it depends
> on the powerpc-specific "FSL_SOC" symbol and it uses the in_be32/out_be32
> MMIO helpers that are not defined on ARM.

Yeah you're right. The common code between powerpc and arm64 is in
fsl_ddr_edac.c, not mpc85xx_edac.c. There are no uses of NO_IRQ

Will send a v2 with all uses removed from drivers/edac.

cheers
