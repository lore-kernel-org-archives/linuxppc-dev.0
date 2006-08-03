Return-Path: <edb@datadesigncorp.net>
Received: from pyramid-04.kattare.com (pyramid-04.kattare.com [65.212.180.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.kattare.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2E07967B52
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 01:40:15 +1000 (EST)
Message-ID: <44D20980.3030702@datadesigncorp.net>
Date: Thu, 03 Aug 2006 10:34:40 -0400
From: Edward Bockhoefer <edb@datadesigncorp.net>
MIME-Version: 1.0
To: dhlii@comcast.net, ammubhai@gmail.com, linuxppc-embedded@ozlabs.org
Subject: Re: Xilinx TEMAC
References: <44CE4C1D.6050103@datadesigncorp.net>
	<44CE5EA5.3030306@gmail.com>	<44CF89B5.7080906@datadesigncorp.net>
	<44D07B38.5060700@gmail.com> <44D1991A.2070208@dlasys.net>
In-Reply-To: <44D1991A.2070208@dlasys.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: edb@datadesigncorp.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thank you for the reply David,
I have started the montavista 10/100 enet port from the xilinx edk 
generated 2.4 driver to the 2.6 driver. Unfortunately, I can't post the 
driver port publicly because it's not GLP'd, as far as I know. We only 
needed a 10/100 mac, so we didn't bother with a TEMAC. I got the obp and 
enet directories to compile but I crash on link with an undefined reference:

**********************************************
[root@bockhoefer linux-2.6.17.6]# make
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.init.text+0x246c): In function `fbcon_bmove':
drivers/video/console/fbcon.c:1887: undefined reference to `init_etherdev'
make: *** [.tmp_vmlinux1] Error 1
[root@bockhoefer linux-2.6.17.6]#     

*********************************************
I will work on this more today. If you want to send me your TEMAC code, 
please do so. I can always use the reference.

-- 
Best Regards,

Edward Bockhoefer
Data Design Corporation
7851-A Beechcraft Ave.
Gaithersburg, MD 20879
Ph: 301-670-1157 ext 36
Fax: 301-926-6441 



David H. Lynch Jr. wrote:

>Ameet Patil wrote:
>  
>
>> > Did you happen to get an Ethernet mac going on the virtex2 or
>> > virtex4 with the 2.6 kernel?
>>
>>Nope! :-(
>>Rumour has it that Montavista is soon going to release the source for 
>>2.6 kernel to run on Xilinx platforms.
>>
>>  
>>    
>>
>    I have 2 different TEMAC's working under 2.6 with a V4.
>
>    The MontaVista driver that has been posted on the list that I think
>is from MontaVista for the PLB TEMAC with very minor modifications to
>get it to work at speeds other than GigaBit.
>
>    A driver I wrote for the LocalLink TEMAC that works limpingly. I
>have been unable to figure out how to get a receive interrupt from the
>LocalLink TEMAC so receives are polled and performance is poor.
>    I have pretty much abandoned work on it  - my client wants the
>smallest possible FPGA footprint BUTanother OS I am porting requires
>interrupt driven  IO and we are looking for a single minimal hardware
>implimentation for all platforms.
>
>    Anyway, if anyone wants the LL TEMAC in its current state I can post it.
>    Currently it sends fine. It drops about 50% of all received packets
>- but that is probably debugging overhead and poll rate tuning.
>   
>
>
>
>
>  
>
