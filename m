Return-Path: <prabhakar@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A59A32C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 14:49:00 +1100 (EST)
Message-ID: <52D9F996.4060506@freescale.com>
Date: Sat, 18 Jan 2014 09:18:38 +0530
From: Prabhakar Kushwaha <prabhakar@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2][v3] driver/memory:Move Freescale IFC driver to a
 common driver
References: <1389850929-19873-1-git-send-email-prabhakar@freescale.com>
 <E7780BC2-F914-4D0C-8AB9-9FE7437A5C48@kernel.crashing.org>
In-Reply-To: <E7780BC2-F914-4D0C-8AB9-9FE7437A5C48@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 1/17/2014 10:38 PM, Kumar Gala wrote:
> On Jan 15, 2014, at 11:42 PM, Prabhakar Kushwaha <prabhakar@freescale.com> wrote:
>
>> Freescale IFC controller has been used for mpc8xxx. It will be used
>> for ARM-based SoC as well. This patch moves the driver to driver/memory
>> and fix the header file includes.
>>
>> Also remove module_platform_driver() and  instead call
>> platform_driver_register() from subsys_initcall() to make sure this module
>> has been loaded before MTD partition parsing starts.
>>
>> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> Changes for v2:
>> 	- Move fsl_ifc in driver/memory
>>
>> Changes for v3:
>> 	- move device tree bindings to memory
>>
>> .../{powerpc => memory-controllers}/fsl/ifc.txt    |    0
>> arch/powerpc/sysdev/Makefile                       |    1 -
>> drivers/memory/Makefile                            |    1 +
>> {arch/powerpc/sysdev => drivers/memory}/fsl_ifc.c  |    8 ++++++--
>> drivers/mtd/nand/fsl_ifc_nand.c                    |    2 +-
>> .../include/asm => include/linux}/fsl_ifc.h        |    0
>> 6 files changed, 8 insertions(+), 4 deletions(-)
>> rename Documentation/devicetree/bindings/{powerpc => memory-controllers}/fsl/ifc.txt (100%)
>> rename {arch/powerpc/sysdev => drivers/memory}/fsl_ifc.c (98%)
>> rename {arch/powerpc/include/asm => include/linux}/fsl_ifc.h (100%)
> The Kconfig option for FSL_IFC should move into drivers/memory/Kconfig

Thanks Kumar for taking time and review this patch.

You are correct. I was checking sysdev/Kconfig  but it is defined in 
powerpc/Kconfig
I missed it :)

Regards,
Prabhakar
