Return-Path: <johnsoncheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.27])
	by ozlabs.org (Postfix) with SMTP id E2F9567FED
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Aug 2005 20:45:52 +1000 (EST)
From: "JohnsonCheng" <johnsoncheng@qnap.com.tw>
To: "'Wolfgang Denk'" <wd@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050822081708.74890352B0C@atlas.denx.de>
Message-Id: <20050822104552.E2F9567FED@ozlabs.org>
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
Date: Mon, 22 Aug 2005 10:46:03 -0000

I have browsed the website, http://www.denx.de/twiki/bin/view/DULG/Manual.
For this example:
0x00000000-0x00060000 : "U-Boot"
0x00060000-0x00080000 : "Environment 1"
0x00080000-0x000A0000 : "Environment 2"
0x000A0000-0x000C0000 : "ASIC Images"
0x000C0000-0x001C0000 : "Linux Kernel"
0x001C0000-0x005C0000 : "Ramdisk Image"
0x005C0000-0x01000000 : "User Data"

How can I put the Environment variables or configurations in
0x00060000-0x00080000, or put User Data in 0x005C0000-0x1000000?
Use U-boot command? Or....

Best Regards,
Johnson Cheng


-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Wolfgang Denk
Sent: Monday, August 22, 2005 4:17 PM
To: JohnsonCheng
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux Kernel MTD question 

In message <20050822030032.4917442C7E@denx.de> you wrote:
>
> Actually, the range of my flash is from 0xFF000000 to 0xFFFFFFFF. My
> starting address of Kernel is 0xFF000000, and the starting address of
> ramdisk image is FF200000, so the partitions is as following:
> 0xFF000000 - 0xFF1FFFFF		Kernel
> 0xFF200000 - 0xFF9FFFFF		RamDisk Image ( also my Root File
System )
> 
> And I found my RootFS image is so big that waste many time while write it
to
> flash.

Then avoid writing it that often. Use  a  more  efficient  setup  for
developoment and test, like root file system mounted over NFS.

> I hope I can use MTD to distribute it into two parts, Simple RootFS and
> libraries, but I don't know how to implement it?

You can use MTD to provide an additional file system which  can  then
be mounted by one of your startup scripts. MTD configuration and file
system building is documented in the DULG, please see
http://www.denx.de/twiki/bin/view/DULG/Manual

It is not possible to  give  good  advice  how  to  split  data  into
separate  file  systems,  or  how  exactly  you  can mount it without
precise knowledge of your system and it's requirements. For  example,
do you use a SysV init with several run levels, or a simple setup for
example based on busybox? In the end this is something which you have
to design yourself.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Let the programmers be many and the managers few -- then all will  be
productive.               -- Geoffrey James, "The Tao of Programming"
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
