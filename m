Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC0591007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Jun 2010 15:51:18 +1000 (EST)
Subject: Re: [PATCH 3/3] fsl_rio: fix non-standard HID1 register access
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AANLkTind1zMrnldhZmeacglmVyfX8VN2qO_JJlkPAe0v@mail.gmail.com>
Date: Fri, 18 Jun 2010 00:51:02 -0500
Message-Id: <E50EF7DA-34F9-4AD2-9496-D03F163ECE89@kernel.crashing.org>
References: <1276838958-28947-1-git-send-email-leoli@freescale.com>
	<1276838958-28947-2-git-send-email-leoli@freescale.com>
	<1276838958-28947-3-git-send-email-leoli@freescale.com>
	<AANLkTind1zMrnldhZmeacglmVyfX8VN2qO_JJlkPAe0v@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 18, 2010, at 12:46 AM, Geert Uytterhoeven wrote:

> On Fri, Jun 18, 2010 at 07:29, Li Yang <leoli@freescale.com> wrote:
>> The access to HID1 register is only legitimate for e500 v1/v2 cores.
>> 
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> ---
>>  arch/powerpc/sysdev/fsl_rio.c |    7 +++++--
>>  1 files changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
>> index 954a754..785a882 100644
>> --- a/arch/powerpc/sysdev/fsl_rio.c
>> +++ b/arch/powerpc/sysdev/fsl_rio.c
>> @@ -1523,9 +1523,12 @@ int fsl_rio_setup(struct of_device *dev)
>>  #ifdef CONFIG_E500
>>        saved_mcheck_exception = ppc_md.machine_check_exception;
>>        ppc_md.machine_check_exception = fsl_rio_mcheck_exception;
>> -#endif
>> -       /* Ensure that RFXE is set */
>> +
>> +#ifndef CONFIG_E500MC
>> +       /* Ensure that RFXE is set on e500 v1/v2 */
>>        mtspr(SPRN_HID1, (mfspr(SPRN_HID1) | 0x20000));
>> +#endif /* !E500MC */
>> +#endif /* E500 */
>> 
>>        return 0;
>>  err:
> 
> This prevents you from building a kernel for both normal E500 and E500MC.
> 
> Gr{oetje,eeting}s,

Also, not a fan of the magic number 0x20000.

- k
