Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0153.outbound.protection.outlook.com [207.46.163.153])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0DF5D2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 10:22:40 +1100 (EST)
Message-ID: <1391469748.6733.99.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2][v8] driver/memory:Move Freescale IFC driver to a
 common driver
From: Scott Wood <scottwood@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Date: Mon, 3 Feb 2014 17:22:28 -0600
In-Reply-To: <1391161199-28018-1-git-send-email-prabhakar@freescale.com>
References: <1391161199-28018-1-git-send-email-prabhakar@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-01-31 at 15:09 +0530, Prabhakar Kushwaha wrote:
>  Freescale IFC controller has been used for mpc8xxx. It will be used
>  for ARM-based SoC as well. This patch moves the driver to driver/memory
>  and fix the header file includes.
> 
>  Also remove module_platform_driver() and  instead call
>  platform_driver_register() from subsys_initcall() to make sure this module
>  has been loaded before MTD partition parsing starts.
> 
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Again, when did Arnd ack this?

>  .../{powerpc => memory-controllers}/fsl/ifc.txt    |    0
>  arch/powerpc/Kconfig                               |    4 ----
>  arch/powerpc/sysdev/Makefile                       |    1 -
>  drivers/memory/Kconfig                             |    8 ++++++++
>  drivers/memory/Makefile                            |    1 +
>  {arch/powerpc/sysdev => drivers/memory}/fsl_ifc.c  |    8 ++++++--
>  drivers/mtd/nand/fsl_ifc_nand.c                    |    2 +-
>  .../include/asm => include/linux}/fsl_ifc.h        |    0
>  8 files changed, 16 insertions(+), 8 deletions(-)
>  rename Documentation/devicetree/bindings/{powerpc => memory-controllers}/fsl/ifc.txt (100%)
>  rename {arch/powerpc/sysdev => drivers/memory}/fsl_ifc.c (98%)
>  rename {arch/powerpc/include/asm => include/linux}/fsl_ifc.h (100%)

Do we need a MAINTAINERS entry for this?  I don't see anything covering
drivers/memory currently.

-Scott
