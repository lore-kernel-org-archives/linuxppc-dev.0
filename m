Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A7A7DDE2C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Nov 2007 20:27:45 +1100 (EST)
Message-ID: <474FD76C.4060700@dlasys.net>
Date: Fri, 30 Nov 2007 04:27:08 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: schardt <g.schardt@fz-juelich.de>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Init hangs on Xilinx4
References: <474D8839.6020609@fz-juelich.de> <474EB36D.1080408@dlasys.net>
	<474EB62D.9000908@fz-juelich.de> <474ECB50.90303@dlasys.net>
	<474ED262.5010408@fz-juelich.de>
In-Reply-To: <474ED262.5010408@fz-juelich.de>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

schardt wrote:
> Hi David,
>
> thanks for your help.
>   
>>>   
>>>     
>>>       
>>     I am presuming you are using PK's UartLite driver.
>>   
>>     
> I use the Kernel from Grant's git server,  and let me look... yes its
> from Peter Korsgaard :)
>
>   
>>     Try printing out membase some time possibly in ulite_console_setup.
>>     If the value of membase is 0x406000000 that is your problem.
>>     It should be something like 0xfdxxxxxxxx I think.
>>   
>>     
> Mmmh, my EDK Project maps the uartlite to 0x40600000, so i think its
> okay. but i can try it at a higher adress
>
> it is very strange. i use the same hardware setup and boot from
> system-ace without any problems.
    Another posibility that I thought of since you are using Peter K's
driver.
    If you have any interrupt problems I think you could get your
current behavior.
   
    During boot console I/O is not interrupt driven. When the OS sends a
string the whole string gets sent and then the console write exits,
    but very close to running init, the console switches to using the
full driver. PK's driver is interrupt driven. If the UartLite TX FIFO
empty interrupt
    is broke in anyway, it will send until the first time the FIFO fills
and then stop.  The interrupt could be broken in firmware - not properly
connected to the PIC, or it could be broken in software - however your
driver is receiving its interrupt configuration, the driver may be
receiving the incorrect intterrupt #.

    At one point I tried to add timer driven polling to PK's driver
similar to that in the 8250 and others - we have clients that run
without any PIC,
    but trying to figure out what was going on proved sufficiently
difficult I just went back to my own driver.    


>  
>
>
> Regards
> Georg
>
>
> -------------------------------------------------------------------
> -------------------------------------------------------------------
> Forschungszentrum Jülich GmbH
> 52425 Jülich
>
> Sitz der Gesellschaft: Jülich
> Eingetragen im Handelsregister des Amtsgerichts Düren Nr. HR B 3498
> Vorsitzende des Aufsichtsrats: MinDirig'in Bärbel Brumme-Bothe
> Geschäftsführung: Prof. Dr. Achim Bachem (Vorsitzender),
> Dr. Ulrich Krafft (stellv. Vorsitzender), Dr. Sebastian M. Schmidt
> -------------------------------------------------------------------
> -------------------------------------------------------------------
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
