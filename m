Return-Path: <duykynguyen@hotmail.com>
Received: from bay0-omc1-s33.bay0.hotmail.com (bay0-omc1-s33.bay0.hotmail.com
	[65.54.246.105]) by ozlabs.org (Postfix) with ESMTP id C163DDDE17
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Oct 2008 17:14:01 +1100 (EST)
Message-ID: <BLU119-DAV245BF96B99DC961FFF9EFBB380@phx.gbl>
From: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.1.1223341202.18311.linuxppc-embedded@ozlabs.org>
Subject: Trying to vfree() nonexistent vm area
Date: Mon, 6 Oct 2008 23:14:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

My driver uses ioremap() the IMMR_BASE @ 0xE0000000 to access registers.
A user-space app opens and close the deive file on every access to register.

There's no problem with FreeScale Linuc BSP 2..6.20 for eva board 
MPC83813E-RDB.

For the latest FreeScale Linuc BSP 2..6.24 , I have NO problem for the very 
FIRST run.
But after the 1st run, I have problem with the new FreeScale Linuc BSP 
2..6.24 with the following error message

        Trying to vfree() nonexistent vm area (c98a0000)

where c98a0000 is the mapped address of IMMR_BASE 0xE0000000.

So, it appears to me that the device file could be closed improperly as it's 
closed after the 1st run.

I really appreciate your time and help

Best Regards,

Duy-Ky

///////////////////////
Below is outline of the driver

init:
     ppc_base = (unsigned long) ioremap_nocache(PPC_BASE, PPC_SIZE);

//     ppc_base = (unsigned long) ioremap(PPC_BASE, PPC_SIZE);    // failure 
with this way too


close:
    iounmap((void __iomem *)ppc_base);
//    iounmap(PPC_BASE);        // failure with this way too !
