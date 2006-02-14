Return-Path: <atul.sabharwal@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id C62C867B35
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 05:25:59 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k1EIPvtT014405
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Feb 2006 10:25:58 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k1EIPvHE026217
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Feb 2006 10:25:57 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: u-boot relocate_code routine...
Date: Tue, 14 Feb 2006 10:26:40 -0800
Message-ID: <4A062D477D842B4C8FC48EA5AF2D41F201BA2242@us-bv-m23.global.tektronix.net>
From: <atul.sabharwal@exgate.tek.com>
To: <wd@denx.de>
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

>>You can reinvent the wheel, or  read  the  documented  experience  of
>>others who went the same way long time ago.

I don't prefer re-inventing unless it adds some real value.  I had
mentioned the same thing to the design team and changing the memory map
solved the problem.

My hypothesis is that there still is a bug in relocate_code routine as
if I comment out trap_init routine which relocates the exception vectors
from flash to ram (in this case 0x10000000), the processor dies.  With
I-cache Off, and trap_init/interrupt_enable commented, it runs to u-boot
prompt.
With I-cache On, it dies 100% in this code.

Putting memory to 0x0 solves the problem and I am able to enable
trap_init & interrupt enable. Also, can turn I-cache on but seems to be
some cache problem as without BDI, it dies 100% but with BDI connected,
it runs with
Some fpga errors. =20

If you get a chance, you could review the relocate_code routine if it
handles all input data values. I am new to PPC assembly, so if this was
written in C/as, it would have been lot simpler.  That is not important
but handling all data values seems to be a bug.

Best Regards,

Atul
