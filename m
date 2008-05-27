Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9D029DE0D2
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 04:06:48 +1000 (EST)
Message-ID: <483C4DF6.8060006@freescale.com>
Date: Tue, 27 May 2008 13:07:50 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: JFFS2 FS not writeable
References: <661239.31265.qm@web83508.mail.sp1.yahoo.com>
In-Reply-To: <661239.31265.qm@web83508.mail.sp1.yahoo.com>
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

Ron Madrid wrote:
> I have tried the latest code and now, I'm able to
> write a limited amount.  After which when I reboot,
> more than 100 contiguous blocks have been marked bad,
> through the end of the device (according to the dts). 
> Is this something that has been seen before?

Yes, but not with the latest code.

 > My NAND device is a large page.

I've only had small page devices to test on, so it's quite likely that 
there's a large page bug in the driver somewhere.

If your erase block size is not 128K, try the latest set_addr patch in 
the mtd-2.6.22.1 branch of u-boot-nand-flash (I still need to send it 
out for Linux).

-Scott
