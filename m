Return-Path: <gosiuua@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.237])
	by ozlabs.org (Postfix) with ESMTP id 22AA967A5B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 May 2006 00:03:24 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 36so412180wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 May 2006 07:03:23 -0700 (PDT)
Message-ID: <ee10e9f40605180656q58f989bcg562b48d765afdba5@mail.gmail.com>
Date: Thu, 18 May 2006 21:56:25 +0800
From: Gosiuua <gosiuua@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: About BDI2000 and mpc8247
In-Reply-To: <ee10e9f40605180640g12a2671bo530c3ccbba8b3829@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <ee10e9f40605180640g12a2671bo530c3ccbba8b3829@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello List..

 i have a develop board based on mpc8247. It has no eeprom to restore
hareware configure word and i have to use default config word
0x00000000.
 my bdi config file:

[TARGET]
CPUTYPE     8270                ;the CPU type (603EV,750,8240,8260)
JTAGCLOCK   1                   ;use 16 MHz JTAG clock
BOOTADDR    0xfff00100          ;boot address used for start-up break
WORKSPACE   0x00000000          ;workspace in target RAM for fast
download and data cache flushing
BDIMODE     AGENT               ;the BDI working mode (LOADONLY |
AGENT | GATEWAY)

BAUDRATE    115200                ;baudrate for gateway mode or
virtual IO
BREAKMODE   SOFT                ;<AGENT> SOFT or HARD, HARD uses PPC
hardware breakpoint
VECTOR      CATCH               ;<AGENT> catch unhandled exceptions


DCACHE      NOFLUSH            ;<AGENT> data cache flushing (FLUSH |
NOFLUSH)
MEMBASE     0                   ;<AGENT> base of target memory
MEMSIZE     0x00004000          ;<AGENT> size of target memory, 64M


POOLBASE    0x00000000          ;<AGENT> base of host controlled target mem=
ory
POOLSIZE    0x00004000          ;<AGENT> size of host controlled
target memory

 When i connect BDI2000(bdiwind_cop, firmware 1.13, logic 1.02 ) to
the board, the following messages

are printed, then it have no response!
/************************************************************/
- TARGET: processing power-up delay
- TARGET: processing user reset request
- BDI asserts HRESET
- Reset JTAG controller passed
- Bypass check: 0x55 =3D> 0xAA
- Bypass check: 0x55 =3D> 0xAA
- JTAG exists check passed
- Target PVR is 0x80822014
- Target SVR is 0x00000000
- COP status is 0x01
- Check running state passed
- BDI scans COP freeze command
- BDI removes HRESET
- COP status is 0x05
- Check stopped state passed
- Check LSRL length passed
- BDI sets breakpoint at 0xFFF00100
- BDI resumes program execution
- COP status is 0x01
- Waiting for target stop failed
- TARGET: Break at boot vector failed, freeze forced
- TARGET: Target PVR is 0x80822014
- TARGET: resetting target passed
- TARGET: processing target startup ....
/***/


 When i set CPUTYPE to 8260, the following messages are printed continously=
:

/**************************************************************************=
****/
- TARGET: processing power-up delay
- TARGET: processing user reset request
- BDI asserts HRESET
- Reset JTAG controller passed
- Bypass check: 0x55 =3D> 0xAA
- Bypass check: 0x55 =3D> 0xAA
- JTAG exists check passed
- Target PVR is 0x80822014
- COP status is 0x01
- Check running state passed
- BDI scans COP freeze command
- BDI removes HRESET
- COP status is 0x05
- Check stopped state passed
- Check LSRL length passed
- BDI sets breakpoint at 0xFFF00100
- BDI resumes program execution
- COP status is 0x01
- Waiting for target stop failed
- TARGET: Break at boot vector failed, freeze forced
- TARGET: Target PVR is 0x80822014
- TARGET: resetting target passed
- TARGET: processing target startup ....
- TARGET: processing target startup passed
*** TARGET: reset detected, restarting target
- BDI asserts HRESET
- Reset JTAG controller passed
- Bypass check: 0x55 =3D> 0xAA
- Bypass check: 0x55 =3D> 0xAA
- JTAG exists check passed
- Target PVR is 0x80822014
- COP status is 0x01
- Check running state passed
- BDI scans COP freeze command
- BDI removes HRESET
- COP status is 0x05
- Check stopped state passed
- Check LSRL length passed
- BDI sets breakpoint at 0xFFF00100
- BDI resumes program execution
- COP status is 0x01
- Waiting for target stop failed
- TARGET: Break at boot vector failed, freeze forced
/*****/


 BDI can't bread the CPU and i don't know what can i do!
 Any one can help me?
