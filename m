Return-Path: <johnsoncheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.27])
	by ozlabs.org (Postfix) with SMTP id 2904C68046
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 13:11:36 +1000 (EST)
From: "JohnsonCheng" <johnsoncheng@qnap.com.tw>
To: <wd@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050822130702.27D5F353D18@atlas.denx.de>
Message-Id: <20050823031136.2904C68046@ozlabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Linux Kernel MTD question 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>
Date: Tue, 23 Aug 2005 03:12:03 -0000

Yes. You are right. It's design by myself.
But I meet a problem. If I have three configuration files, A.conf, B.conf
and C.conf, then I hope save them in one of partitions of MTD,
0x005C0000-0x10000000.
Two questions:
1. How to build these configuration files into an image for U-boot with
mkimage?
2. In kernel, how to get these data? I use "mount /dev/mtd4 /mnt", but it
failed by block device required.

Thanks,
Johnson Cheng

-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de] 
Sent: Monday, August 22, 2005 9:07 PM
To: JohnsonCheng
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux Kernel MTD question 

In message <20050822104924.214ED429CB@denx.de> you wrote:
> 
> How can I put the Environment variables or configurations in
> 0x00060000-0x00080000, or put User Data in 0x005C0000-0x1000000?
> Use U-boot command? Or....

It is up to you to define a memory map for your flash  device(s)  and
create  appropriate partitions for this map in Linux (and probably in
U-Boot, too, using the new "mtdparts" command).

Then you can use standard commands in U-Boot (erase, cp) and in Linux
(erase_all, cp) to store any data you likein your flash.

It is *your* design. *You* must create it.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The IQ of the group is the lowest IQ of a member of the group divided
by the number of people in the group.
