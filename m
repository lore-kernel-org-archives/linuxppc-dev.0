Return-Path: <markc@mail.com>
Received: from smtp1.us4.outblaze.com (smtp1.us4.outblaze.com [205.158.62.78])
	by ozlabs.org (Postfix) with SMTP id 6EE4A67B3F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 May 2006 00:22:26 +1000 (EST)
Message-ID: <009401c67a86$79463b50$6401a8c0@CHUCK2>
From: "Mark Chambers" <markc@mail.com>
To: "Gosiuua" <gosiuua@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
References: <ee10e9f40605180640g12a2671bo530c3ccbba8b3829@mail.gmail.com>
	<ee10e9f40605180656q58f989bcg562b48d765afdba5@mail.gmail.com>
Subject: Re: About BDI2000 and mpc8247
Date: Thu, 18 May 2006 10:22:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> Hello List..
> 
> i have a develop board based on mpc8247. It has no eeprom to restore
> hareware configure word and i have to use default config word
> 0x00000000.
> my bdi config file:
> 
<snip>
> - Waiting for target stop failed
> - TARGET: Break at boot vector failed, freeze forced
> /*****/
> 
> 
> BDI can't bread the CPU and i don't know what can i do!
> Any one can help me?
> _______________________________________________

I have had the same issue.  You need lines similar to the following
in your bdi config file to stop the watchdog timer.  Then you will
need other lines to set various registers to match your hardware
bus widths, etc.

[INIT]
; init core register
WREG    MSR             0x00001042      ;MSR  : ME,RI, exceptions high
WM32    0x000101a8 0xf0000000 ;move internal space 
WM32 0xf0010004 0xFFFFFFC1 ;SYPCR: disable watchdog

Mark C.
