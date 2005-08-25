Return-Path: <johnsoncheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.27])
	by ozlabs.org (Postfix) with SMTP id 787316813B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Aug 2005 20:08:55 +1000 (EST)
From: "JohnsonCheng" <johnsoncheng@qnap.com.tw>
To: <wd@denx.de>
Date: Thu, 25 Aug 2005 18:00:56 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050825072853.99657352674@atlas.denx.de>
Message-Id: <20050825100855.787316813B@ozlabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: How to build an image for whole flash 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Yes. I add a MTD partition which include whole flash as following:
mtd0: 0xFF000000-0xFF1FFFFF      Kernel
mtd1: 0xFF200000-0xFF9FFFFF      RootFS
mtd2: 0xFFA00000-0xFFAFFFFF      Config
mtd3: 0xFFF00000-0xFFFFFFFF      U-Boot
mtd4: 0xFF000000-0xFFFFFFFF      Flash

then "dd if=/dev/mtd4 of=flash.img".
Bu t I think it's not a good idea.

Thanks,
Johnson Cheng

-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de] 
Sent: Thursday, August 25, 2005 3:29 PM
To: JohnsonCheng
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How to build an image for whole flash 

In message <20050825032128.D90A368110@ozlabs.org> you wrote:
>
> My flash is 16M that is mapping on 0xFF000000-0xFFFFFFFF.
> mtd0: 0xFF000000-0xFF1FFFFF      Kernel
> mtd1: 0xFF200000-0xFF9FFFFF      RootFS
> mtd2: 0xFFA00000-0xFFAFFFFF       Config
> mtd3: 0xFFF00000-0xFFFFFFFF      U-Boot
> 
> Now I can build an image for mtd device, for example, dd if=/dev/mtd0
> of=kernel.img.

If you want to copy the image to flash, you got the parameters wrong,
i. e. you must use

	dd if=kernel.img of=/dev/mtd0

(after erasing /dev/mtd0, of course); and using some bs=  option  may
speed up the prcedure a bit, too.

> But I don't know how to build a image for whole flash ? 

What do you mean "for the whole flash"? If you cant to combine the  4
images  into  one big blob you can do so by (1) padding the images to
the full size of each partition; this can be done  using  appropriate
"bs=",   "count="   and   "conv=sync"   parameters  to  dd;  and  (2)
concatenating the images using "cat".

But this is a prtty inefficient way, and you will also have to change
your MTD partitioning to provide a big  partition  which  covers  the
whole flash.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Some people march to the beat of a different drummer. And some people
tango!
