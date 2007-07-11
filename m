Return-Path: <mederle_nicolas@yahoo.fr>
Received: from smtp007.mail.ukl.yahoo.com (smtp007.mail.ukl.yahoo.com
	[217.12.11.96]) by ozlabs.org (Postfix) with SMTP id 8D9CBDDE3E
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 01:46:03 +1000 (EST)
Message-ID: <4694F9BD.4090406@yahoo.fr>
Date: Wed, 11 Jul 2007 17:39:41 +0200
From: Nicolas Mederle <mederle_nicolas@yahoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org,  linuxppc-embedded@ozlabs.org
Subject: PageFault when I write in the Serial registers, MMU ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

    I am porting linux on a custom board equipped with a PPC750, and I 
will like to have some advices on the MMU. I used the powerpc arch, and 
I built my device tree.
    I will like to know in which files we can configure the 
authorizations access for the I/O registers. When I use the function 
md_ppc.progress, I have a data access fault. I modified the head. S 
files, for add the BAT config. But I think that it is not correct, and 
that it is possible to do it elsewhere (platform_init?). Moreover the 
kernel modify the MMU config, it removes the BATs, and configures the 
Registers Segments. So, must I remake the configuration? Or is it 
possible to indicate, at the beginning, which space is reserved for I/O?
    I studied several patch (sandpoint, PrPMC2800) but none configures 
really the MMU for I/O registers. In the same way, I read several books, 
but I am not able to have information that I seek, therefore I am really 
blocked. I warmly thank you for the assistance which you will be able to 
bring to me.

    Mapping :     0x0000 0000    ->  0x0FFF FFFF   :   RAM
                         0x2000 0000   ->   0x201F FFFF   :   ASIC ( 
UART, DMA, GPIO, PIC...)
                         0x8000 0000   ->   0x8FFF FFFF   :   PCI
                         0xF000 0000   ->   0xFFFF FFFF   :   Flash
    The kernel is load at 0x0, an the system is a Run In Memory. 
Currently, I don't use the flash.


Best regards,
Nicolas MEDERLE

-- 
Cordialement,

Nicolas MEDERLE. 
