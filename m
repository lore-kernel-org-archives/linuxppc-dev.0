Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 82D6D68304
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 21:40:23 +1000 (EST)
Message-ID: <433146A5.7010008@ru.mvista.com>
Date: Wed, 21 Sep 2005 15:40:21 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: "Landau, Bracha" <BLandau@nds.com>
References: <02AA386EB831044F8537A696BA785C78076299@ILEX5.IL.NDS.COM>
In-Reply-To: <02AA386EB831044F8537A696BA785C78076299@ILEX5.IL.NDS.COM>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: using SCC4 on MPC8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Landau, Bracha wrote:
> I reconfigured the kernel so that only SCC1 and SCC4 are supported. The same thing happens as before.
> Another bit of info is that if I run with console=ttyCPM1 as a kernel command line parameter, so that u-boot outputs to one port and the kernel outputs to the other, if I type "ls > /dev/ttyCPM0" the system hangs.
> 

Heh, didn't noticed, that you should use the latest rc of the linux 
kernel. I used to fix second UART in rc7 AFAIR.
> 
> -----Original Message-----
> From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]
> Sent: Wednesday, September 21, 2005 1:56 PM
> To: Landau, Bracha
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: using SCC4 on MPC8272ADS
> 
> 
> Landau, Bracha wrote:
> 
>>I am using the MPC8272ADS with kernel 2.6.10. The kernel is configured to support 4 CPM SCCs, of which 1 and 4 are connected on the board.
>>I created device files as follows:
>>
>>mknod /dev/ttyCPM0 c 204 46
>>mknod /dev/ttyCPM1 c 204 47
>>mknod /dev/ttyCPM2 c 204 48
>>mknod /dev/ttyCPM3 c 204 49
>>
>>If I boot the kernel using console=ttyCPM3 I see that it uses SCC4. But when I boot with console=ttyCPM0 and write to the second port using a command like "echo hello > /dev/ttyCPM3" I don't see that anything is being outputted to the second console.
>>
>>What am I doing wrong?
>> 
> 
> Funny - you said that SCC 1 and 4 are connected to the board; than why 
> you are enabling SCC2 and SCC3?
> 
> This board does have 2 SCCs assigned for UARTs. No need to configure 
> SCC2 and SCC3 - this is useless and may lead to kernel crash. This board 
> will use in the correct configuration /dev/ttyCPM0 <SCC1> and 
> /dev/ttyCPM1 <SCC4>.
> 
> 
> 


-- 
Sincerely,
Vitaly
