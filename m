Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id 4970167A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 20:32:56 +1000 (EST)
To: Marco Schramel <Schramel.Linux@go.bartec.de>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 21 Apr 2005 11:17:25 +0200."
	<200504211117.25584.Schramel.Linux@go.bartec.de>
Date: Thu, 21 Apr 2005 12:32:29 +0200
Sender: wd@denx.de
Message-Id: <20050421103234.ED367C1510@atlas.denx.de>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: mtd mount problem 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200504211117.25584.Schramel.Linux@go.bartec.de> you wrote:
> 
> /dev # date > /dev/mtd1
> MTD_open
> MTD_ioctl
> MTD_write
> MTD do_write_buffer(): software timeout
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
ERROR ERROR ERROR ERROR ERROR ERROR ERROR

> MTD_close
> /dev #
> 
> It all seems to be fine, but...

I disagree. There was a  pretty  clear  error  message  above.  Don't
ignore this, it will bite you later.

> dev # mount -t jffs2 /dev/mtdblock1 /mnt/Flash1
> mount: Mounting /dev/mtdblock1 on /mnt/Flash1 failed: No such device

Assuming that this is a mount builtin to the  busybox,  this  message
means  that  there  is  no such file as "/dev/mtdblock1" in your root
file system - exactly as the error message says.

> I checked out the Majors of my ramdisk, they are ok.

What has a ramdisk to do with this?

What does "cat /proc/mtd" show? What are  the  kernel  boot  messages
look like?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"It was the Law of the Sea, they said. Civilization ends at  the  wa-
terline.  Beyond  that,  we  all enter the food chain, and not always
right at the top."                               - Hunter S. Thompson
