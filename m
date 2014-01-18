Return-Path: <prabhakar@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 05C982C0099
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 14:47:18 +1100 (EST)
Message-ID: <52D9F92C.3030003@freescale.com>
Date: Sat, 18 Jan 2014 09:16:52 +0530
From: Prabhakar Kushwaha <prabhakar@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/configs: Enbale Freescale IFC controller
References: <1389938981-30858-1-git-send-email-prabhakar@freescale.com>	
 <B2E40837-4025-4975-8DAC-BB47E2B07E1A@kernel.crashing.org>
 <1389984587.24905.249.camel@snotra.buserror.net>
In-Reply-To: <1389984587.24905.249.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 1/18/2014 12:19 AM, Scott Wood wrote:
> On Fri, 2014-01-17 at 11:02 -0600, Kumar Gala wrote:
>> On Jan 17, 2014, at 12:09 AM, Prabhakar Kushwaha <prabhakar@freescale.=
com> wrote:
>>
>>> Currently IFC NAND driver is enabled in corenet32smp_defconfig. But I=
FC
>>> controller is not enabled
>>>
>>> So, Enable IFC controller in corenet32smp_defconfig.
>>>
>>> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
>>> ---
>>> Based upon git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/li=
nux.git
>>> branch master
>>>
>>> arch/powerpc/configs/corenet32_smp_defconfig |    1 +
>>> 1 file changed, 1 insertion(+)
>> Shouldn=E2=80=99t the NAND driver get the IFC controller enabled by Kc=
onfig dependancies?
> Yes (by select, not dependencies).
>
> Prabhakar, was there an actual problem you saw before?  Did you run
> savedefconfig after making this change?
>
> CONFIG_FSL_IFC isn't even user-selectable (though it probably should be=
,
> as how else would it get enabled in the absence of NAND for catching NO=
R
> errors?).
>

Thanks Kumar and Scott for reviewing this patch.

Yes, it should be enabled by Kconfig dependency.   as we have
config FSL_IFC
     bool
         depends on FSL_SOC

The only reason I changed this code because i wanted all powerpc/configs=20
to be similar as they have CONFIG_FSL_IFC enabled by default.

arch/powerpc/configs/mpc85xx_smp_defconfig:54:CONFIG_FSL_IFC=3Dy
arch/powerpc/configs/corenet64_smp_defconfig:29:CONFIG_FSL_IFC=3Dy
arch/powerpc/configs/mpc85xx_defconfig:51:CONFIG_FSL_IFC=3Dy

So either I should add in corenet32smp_defconfig to make similar to other=
s.
or
remove from all.

I chose first option.

Regards,
Prabhakar
