Return-Path: <phenning@vastech.co.za>
Received: from www6.jnb1.host-h.net (www6b.your-server.co.za [196.22.132.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE243DE10A
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 01:55:54 +1100 (EST)
Received: from [196.213.226.33] (helo=[172.16.63.116])
	by www6.jnb1.host-h.net with esmtpa (Exim 4.66)
	(envelope-from <phenning@vastech.co.za>) id 1LRSsL-0006ae-19
	for linuxppc-dev@ozlabs.org; Mon, 26 Jan 2009 16:55:45 +0200
Message-ID: <497DCEF3.1070800@vastech.co.za>
Date: Mon, 26 Jan 2009 16:55:47 +0200
From: Pieter <phenning@vastech.co.za>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: Need help creating Device tree source for custom MPC8548 board
References: <497D7B37.9060909@vastech.co.za> <497D7D2A.8090006@grandegger.com>
In-Reply-To: <497D7D2A.8090006@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Grandegger wrote:
> Pieter wrote:
>   
>> Hi all
>>
>> I have inherited  a cusom MPC 8548 board and am currently in the
>> processes of porting to U-Boot 2008 and Linux 2.6.27. The board worked
>> using U-boot 1.2 and linux 2.6.24 not using FDT.
>>
>> I have completed the U-boot source and am able to boot up to the point
>> where control is handed to Linux kernel , where the board hangs. This
>> lead me to believe that my device tree source is not accurate.
>>
>>     ## Transferring control to Linux (at address 00000000) ...
>>        Booting using OF flat tree...
>>
>> I assembled a minimal "equus.dts"  by using the tqm8458.dts and
>> sbc8548.dts as examples and the "Booting the Linux/ppc kernel without
>> Open Firmware" document supplied with Lnux 2.6.27. I am uncertain about
>> assigning interrupts to the variouse nodes.
>>
>> I compiled the blob using dtc Version: 1.1.0:
>> dtc -b 0 -V 17 -p 0x2000 -I dts -R 8 -O dtb -f
>> arch/powerpc/boot/dts/equus.dts > SDH0/tftp/equus.dtb
>>
>> can anyone please help? My device tree source is as follows:
<snip>

> Does this address match the one set by U-Boot? Also check all other
> addresses for PCI, etc.
>
> Wolfgang.
I have checked and confirmed that the addresses do match those in
U-Boot. I have also confirmed that the chosen node gets created and
values that set by U-boot does indeed get set. The boot posses gets
stuck when control is handed to Linux. ( the Linux has been compiled
with ARCH=powerpc ).

I have tried to do the post mortem debug as looking at log_buf in
memory, but the memory is still empty. Where should i focus my
debugging, on linux, u-boot or FDT side?

any other help would be appreciated. thanks pieter
