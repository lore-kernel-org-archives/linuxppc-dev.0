Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 189EADDF2E
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 00:28:00 +1100 (EST)
Message-ID: <45CB254F.9010602@freescale.com>
Date: Thu, 08 Feb 2007 07:27:43 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Li Yang-r58472 <LeoLi@freescale.com>
Subject: Re: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys to
	generic iopa
References: <989B956029373F45A0B8AF02970818900D43E9@zch01exm26.fsl.freescale.net>
In-Reply-To: <989B956029373F45A0B8AF02970818900D43E9@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Li Yang-r58472 wrote:

> No, we don't know if the BD ring is in MURAM or main memory as it is
> configurable.  iopa() is best choice to handle both case, IMHO.

The above code would only be used if the BD is in MURAM.  The "if 
bd_mem_part == MEM_PART_MURAM" would stay.

If the BD ring can be in main memory, then I don't think we should be 
using a function called "iopa" to get its physical address.  It's 
conceivable that one day, iopa() will only work on memory that's been 
ioremap'ed.
