Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id CE1D0DE2BA
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 05:09:59 +1000 (EST)
Message-ID: <47FD1485.6070209@matrix-vision.de>
Date: Wed, 09 Apr 2008 21:09:57 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: MPC8343 - "unable to handle paging request @ 0"
References: <47F73625.9040903@matrix-vision.de>
	<20080407161036.GA2688@loki.buserror.net>
	<47FB7822.6090401@matrix-vision.de>
	<20080408164853.GH2552@loki.buserror.net>
	<47FCBC73.40703@matrix-vision.de> <47FD118F.8050407@freescale.com>
In-Reply-To: <47FD118F.8050407@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood schrieb:
> Andre Schwarz wrote:
>>  -> find_legacy_serial_port()
>> stdout is /soc8343@e0000000/serial@4500
>
> It looks like you have some memory corruption between here...
>
>> clocksource: timebase mult[3c00001] shift[22] registered
>>
>> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
>>  -> check_legacy_serial_console()
>>  can't find stdout package /soc8343@e0000000/serial@4500 !
>> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
>
> ...and here.
>
> -Scott

Scott,

are you talking about a possible hardware problem or misbehaving code ?

Does it look like something gets overwritten during initrd 
extraction/movement ?

The system has 512MB RAM which means that we need 2 BAT regs to map the 
memory. I've found comments in Freescale u-boot header files that 
currently a max of 256MB is supported. I never understood why ? Could 
this problem be related to this ?

Do I need to supply reserved memory regions ? I thought u-boot is doing 
so for initrd and the kernel don't need it ...


I'll rebuild u-boot with 256MB memory size and do an extra run with 
memory test - just to make sure.


Any hints where to look else ?


regards,
Andre


MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
