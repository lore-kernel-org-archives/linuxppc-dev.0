Return-Path: <p_gortmaker@yahoo.com>
Received: from web60509.mail.yahoo.com (web60509.mail.yahoo.com
	[216.109.116.130]) by ozlabs.org (Postfix) with SMTP id DC44E67A2F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Apr 2005 02:28:20 +1000 (EST)
Message-ID: <20050401162135.4247.qmail@web60509.mail.yahoo.com>
Date: Fri, 1 Apr 2005 08:21:35 -0800 (PST)
From: Paul Gortmaker <p_gortmaker@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Mem location of TODC NVRAM on 8265 board (sbc82xx.h)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi folks, 

I was wondering if anyone can explain to me why the location of the TODC
for this platform (sbc82xx.[ch]) was changed from 0x80000000 to
0xd0000000.  It was originally 0x800... when it was merged in at 2.6.7 and
then it was changed to 0xd00... in 2.6.8 I believe.  The manual for this
board (Wind River) states that it is at the former 0x800...

I used the kernel's BR11 and OR11 values (in sbc82xx.c) and fed them to
U-Boot (since it doesn't seem to set these) and I could display the clock
with U-Boot (BR11 is f0010158, OR11 is f001015c)

Here is an example of using U-boot to load BR11/OR11 with the values in
the kernel and displaying the RTC clock values.

------------------
=> md f0010158 2
f0010158: 00000000 fb9fe7dd    ........
=> mm f0010158
f0010158: 00000000 ? 80000801
f001015c: fb9fe7dd ? ffff0836
f0010160: ffff0836 ? => <INTERRUPT>
=> md.b 80001ff0 10
80001ff0: 00 00 00 00 00 00 00 00 00 18 27 20 85 07 03 56    
=> md.b 80001ff0 10
80001ff0: 00 00 00 00 00 00 00 00 00 26 27 20 85 07 03 56    
=> md.b 80001ff0 10
80001ff0: 00 00 00 00 00 00 00 00 00 33 27 20 85 07 03 56    
=>
------------------

The seconds have gone from 18 to 26 and to 33.  But it seems that with
2.6.10, the values in /proc/driver/rtc are changing (even though it is a
bit kooky and displaying signed values), so I'm assuming that 0xd0000000
is somehow working.  I'm pretty new to PPC, so I don't know the
intricacies of  tweaking BR11/OR11 and how that changes things.

Paul.



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Personals - Better first dates. More second dates. 
http://personals.yahoo.com
