Return-Path: <ctz001@email.mot.com>
Received: from motgate3.mot.com (motgate3.mot.com [144.189.100.103])
	by ozlabs.org (Postfix) with ESMTP id C7DEE67CFC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Jul 2005 07:12:33 +1000 (EST)
Date: Thu, 21 Jul 2005 16:12:18 -0500 (Central Daylight Time)
From: T Ziomek <ctz001@email.mot.com>
To: David Grab <d.grab@hima.com>
In-Reply-To: <000501c58dc6$22246a20$f201a8c0@SN7606>
Message-ID: <Pine.WNT.4.61.0507211609080.2672@holyoke.labs.mot.com>
References: <000501c58dc6$22246a20$f201a8c0@SN7606>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: AW: AW: AW: initrd rootfs ramdisk
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 21 Jul 2005, David Grab wrote:
>
>>> i solved my problem with u-boot and linux. Now i have my rootfs ramdisk
>>> mounted and functioning. But one output is weird.
>
>> Can I ask what what you had to change to get your initrd RAM disk working?
>> I'm having a very similar problem.
>
> Sure! :)

Sigh...found it, after weeks of on-and-off work...  Our board has 64 MB of
RAM but I'm passing "mem=32M" to the kernel because we want our app to man-
age the high 32 MB.

U-Boot defaults to copying an initrd into the highest available RAM.  That
put it in an area outside of Linux's knowledge, D'OH.  All I had to do was
set U-Boot's 'initrd_high' env var and things work.

Thanks for the info anyway; I've saved it.
Tom

-- 
   /"\  ASCII Ribbon Campaign   |   Email to user 'CTZ001'
   \ /                          |             at 'email.mot.com'
    X        Against HTML       |
   / \     in e-mail & news     |
