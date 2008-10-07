Return-Path: <fisherssml@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 3D287DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Oct 2008 16:15:19 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id m2so129191uge.14
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 06 Oct 2008 22:15:17 -0700 (PDT)
Message-ID: <25fd1f750810062215q7f33664eo99908ab7dd26f502@mail.gmail.com>
Date: Tue, 7 Oct 2008 13:15:17 +0800
From: Fisherss <fisherssml@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: CPIO image date problem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all

I have a weird problem on MPC8548E with Linux Kernel 2.6.24:

I use a CPIO image as my embedded system's root file system, but after
booting, all files and directories' "date" attribute are set to "Jan
1, 1970".

Now what I have got is:
====================
U-boot and the cpio image are cleared. The roofs(cpio image) is loaded
by Linux Kernel, not U-boot, and the image itself has successfully
passed test, so we suppose the problem is in Linux Kernel.

The Kernel loading sequence is : time_init() -> cpio image loading ->
RTC driver loading

That means, at the cpio image loading time, we don't have the RTC
driver. In fact, Kernel uses the time_base register instead of RTC(at
least at this time). All standard cpio images contain the "date" file
attribute, but seems like Kernel just ignores it and uses its own
"clock source"(and this clock source should be binded to time_base
register).

I have located the cpio image unpacking code in Kernel, but can not
find anything about date attribute. This part of code is
platform-independent.

Anyone any idea ??

Thanks

-- 
Fisherss
fisherss@gmail.com
