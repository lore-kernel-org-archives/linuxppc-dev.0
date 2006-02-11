Return-Path: <atul.sabharwal@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id A68D767B8E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 11:27:47 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k1B0RktT001351
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 16:27:46 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k1B0RkxW026782
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 16:27:46 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: kernel startup
Date: Fri, 10 Feb 2006 16:28:28 -0800
Message-ID: <4A062D477D842B4C8FC48EA5AF2D41F201BA2089@us-bv-m23.global.tektronix.net>
From: <atul.sabharwal@exgate.tek.com>
To: <galak@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>I'm not that familiar with 8xx, but can't you move IMMR?

Not much choice with IMMR as it can be 0x0 or 0x00f00000 or 0xFF000000
Or 0xFFF00000. =20

Flash is from 0xfe000000 thru 0xffffffff.  Now on POR,
Processor goes to offset 0x100 on CS0.  So, if IMMR is overlapping with
flash, it might not boot.

On 870, it seems that reset value for BR0/OR0 is undefined.
Data fetch goes on CS0 and then in cpu_init_f BR0 & OR0
Are remapped.  So, I could put flash at a non-standard address like
0xDE000000 and move IMMR to 0xFF000000.

The problem this creates is that I can set IIP to 0 or 1. So, exception
Vector prefix can be 0 or 0xfff.  Since no flash at 0xfff00000 base=20
Address I cannot have any exceptions in my code till the u-boot code
has relocated to RAM.  Which should be acceptable as what can I do
if there is exception so early in the system.=20

Unless there is a better design ?

Thanks,

Atul
