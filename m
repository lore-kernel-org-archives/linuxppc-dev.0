Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (rav-az.mvista.com [65.200.49.157])
	by ozlabs.org (Postfix) with ESMTP id E6EA7679EF
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Jun 2005 04:42:02 +1000 (EST)
Message-ID: <42A49A80.9000405@mvista.com>
Date: Mon, 06 Jun 2005 11:48:32 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: Edward Hong <edward.qin.hong@gmail.com>
References: <21fb73bc0506041640736e3020@mail.gmail.com>	<20050605002832.6311AC1512@atlas.denx.de>
	<21fb73bc050605223311af6408@mail.gmail.com>
In-Reply-To: <21fb73bc050605223311af6408@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: kernel ported from ELDK 3.0 hangs (loops in idled()) on
 my	custom MPC870 Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Edward Hong wrote:
> 
> Yes. rest_init() got called and executed kernel_thread(init,...) ...
> and got into cpu_idle().

Hi Edward,
   I've seen these symptoms before. The problem was traced to external 
interrupts being disabled (MSR[EE] not set). Without external 
interrupts, there is no decrementer interrupt (at least on 7xx 
processors). Without the decrementer, there in no system clock tick and 
without the clock tick, the scheduler won't run which means that the 
init task won't start. To verify that this is the problem, use mfmsr() 
to get the MSR and print it. I'd suggest that you add something like:

     printk("MSR = %x\n", mfmsr());

to rest_init just before call to cpu_idle. Or you can use:

     if (irqs_disabled()) printk(....

if you don't want to decode the MSR yourself.


			Randy Vinson
