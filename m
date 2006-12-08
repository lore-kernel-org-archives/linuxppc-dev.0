Return-Path: <xchen@sunrisetelecom.com.cn>
Received: from smtp01.east.net (smtp01.east.net [211.100.61.140])
	by ozlabs.org (Postfix) with ESMTP id C881267B77
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Dec 2006 13:43:30 +1100 (EST)
From: =?gb2312?B?s8LPow==?= <xchen@sunrisetelecom.com.cn>
To: "'enorm'" <enorm@126.com>, <linuxppc-embedded@ozlabs.org>,
	<linuxppc-embedded-request@ozlabs.org>
Subject: Re: When I use ichache_enable or dcache_enable in uboot,it crash
Date: Fri, 8 Dec 2006 10:43:28 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
In-Reply-To: <004001c71a6b$e5c87150$8809a8c0@class>
Message-Id: <20061208024333.C881267B77@ozlabs.org>
Cc: 'Elvis Ma' <npma@sunrisetelecom.com.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Myabe my presentation is not clear.  The uboot has NEVER disable icache.
The icache is enable at all times.   Disable icaceh is added by me. In =
other
words, someone else use uboot won't disable icache. So it is the point =
that
the icache effect my code run in ram. I wish can find the reason. The =
ORx
BRx init has error or UPM table is wrong or any other reason?  BTW, if I
give up cache, uboot is OK, no other bugs are found.


-----=D3=CA=BC=FE=D4=AD=BC=FE-----
=B7=A2=BC=FE=C8=CB: enorm [mailto:enorm@126.com]=20
=B7=A2=CB=CD=CA=B1=BC=E4: 2006=C4=EA12=D4=C28=C8=D5 9:55
=CA=D5=BC=FE=C8=CB: =B3=C2=CF=A3; linuxppc-embedded@ozlabs.org;
linuxppc-embedded-request@ozlabs.org
=B3=AD=CB=CD: 'Elvis Ma'
=D6=F7=CC=E2: (Rising Spam Alert)Re: When I use ichache_enable or =
dcache_enable in
uboot,it crash

At the end of the "board_init_f()" function all data and code will be
relocated to SDRAM. So, If you enable icache & dcache it will cause
inconsistence between cache and Memory, so your program will crash




----- Original Message -----
From: "=B3=C2=CF=A3" <xchen@sunrisetelecom.com.cn>
To: "'enorm'" <enorm@126.com>; <linuxppc-embedded@ozlabs.org>;
<linuxppc-embedded-request@ozlabs.org>
Cc: "'Elvis Ma'" <npma@sunrisetelecom.com.cn>
Sent: Friday, December 08, 2006 9:33 AM
Subject: Re: When I use ichache_enable or dcache_enable in uboot,it =
crash


Hi enorm

Thank you for your reply. In fact, the uboot has never disable icache. =
The
icache is enable at all times.And the code run in flash normally when =
the
icache is enable.  I have to add disable_icache() in the
board_init_f() so that the code can run in ram normally.  BTW, I just =
use
the function supported by uboot to enable icache&dcache, I'm sure the =
steps
of cache init have no problem. I just can't understand why the icache =
can
effect the code run in ram.

Thanks &Br,
Andy
