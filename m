Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 568B3B7BA1
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 16:02:00 +1100 (EST)
Message-ID: <4AD7FE37.1060705@embedded-sol.com>
Date: Fri, 16 Oct 2009 07:01:43 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: UBIFS problem on MPC8536DS
References: <4AD5ADC9.30503@embedded-sol.com>	<4AD5C5B4.3060303@nokia.com>	<4AD5D053.9000901@embedded-sol.com>	<4AD5FFE7.7080703@nokia.com>	<4AD60EF4.4080306@embedded-sol.com>	<4AD614E4.6030005@freescale.com>
	<4AD7811A.6040501@freescale.com>
In-Reply-To: <4AD7811A.6040501@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	Adrian Hunter <adrian.hunter@nokia.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Scott

Scott Wood wrote:
> Scott Wood wrote:
>> Felix Radensky wrote:
>>> Yes, NAND and NOR are on the same local bus controller.
>>>
>>> Maybe powerpc folks can provide some insight here.
>>> Is it possible that simultaneous access to NOR and NAND
>>> on MPC8536 can result in NAND timeouts ?
>>
>> I've heard other reports of such problems with eLBC, but was unable to 
>> reproduce it myself last time I tried.  Could you reduce this down to 
>> a minimal set of specific reproduction instructions (e.g. eliminate 
>> UBI if possible, or else explain how to set up UBI)?
> 
> OK, I was able to reproduce the problem on mpc8572 simply by sticking a 
> read to NOR flash inside fsl_elbc_run_command -- I'm not sure what 
> happened last time I tried.
> 
> I suppose we'll need a special NOR mapping driver that does some sync 
> with the NAND driver.
> 
> 

Thanks for confirmation. So the real problem is eLBC ?
What happens if I access other devices on eLBC (e.g. FPGA)
simultaneously with NAND or NOR ?

Felix.
