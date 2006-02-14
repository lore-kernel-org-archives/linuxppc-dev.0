Return-Path: <rmcguire@uwbt.com>
Received: from mail19c.g19.rapidsite.net (mail19c.dulles19-verio.com
	[204.202.242.56]) by ozlabs.org (Postfix) with SMTP id 2CD20679F7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Feb 2006 15:02:27 +1100 (EST)
Received: from mx32.stngva01.us.mxservers.net (204.202.242.10)
	by mail19c.g19.rapidsite.net (RS ver 1.0.95vs) with SMTP id
	4-0532349744 for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Feb 2006 23:02:25 -0500 (EST)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: 82xx_io UART BRG's vs BUS CLK
Date: Mon, 13 Feb 2006 20:02:17 -0800
Message-ID: <000e01c6311b$72e535e0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.1.1139818094.16671.linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Anyone,

Recently I found that the value I was passing to Linux for the BUS CLK
frequency was incorrect. Previously I was passing in from U-boot (66 * 1000
* 1000) 66Mhz, it had been brought up this can cause incorrect SOF
transmission rates with the 82xx USB driver, so after measuring our 'exact'
clock, I made the adjustment to ( 66,666,666 Hz ) 66.66Mhz .

Hoping this would correct the issue, however now I cannot run the serial
console baud rate (on SMC2) any higher than 115200 without corruption,
however 57600 works on. This worked great before I changed the U-boot BUS
clock to the correct value.

I did some math on the BRG calculations and with 66Mhz the BRG divisor is
17.8 I am assuming 17 gets written, and with 66.666Mhz then its 18.02 so
thus 18 probably gets written. Should perhaps a constant minus 1 be added to
the code?

Using:
U-boot 1.1.2
DENX Linux 2.4.25

Is anyone aware of similar issues, or are there bug fixes past the 2.4.25
Kernel for this?

-Russ
