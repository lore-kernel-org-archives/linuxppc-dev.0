Return-Path: <dhlii@dlasys.net>
Received: from 24.152.213.223.res-cmts.eph.ptd.net
	(24.152.213.223.res-cmts.eph.ptd.net [24.152.213.223])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A3B07DDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Jan 2007 18:56:08 +1100 (EST)
Message-ID: <45ADD61A.7020005@dlasys.net>
Date: Wed, 17 Jan 2007 02:54:02 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Dan Wilson <dwilson@dslextreme.com>
Subject: Re: ram-disk root file system
References: <200701162102050578.1213ACC0@smtp.dslextreme.com>
In-Reply-To: <200701162102050578.1213ACC0@smtp.dslextreme.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan Wilson wrote:
> We are attempting to use an initrd ram-disk as the permanent root file system for a MPC8541-based system.
>
> We are using ELDK 4 to cross-compile, and are running linux 2.6.15 kernel, with u-boot 1.1.6 as our bootloader.
>
> I built an initrd file system, compressed it, then ran mkimage against it, and it seems to be successfully loaded by u-boot, and linux sees the initrd file and claims to have mounted it.  However, it then reports that it is unable to find any files on the mounted root file system, as shown in the log below.  I added some additional diagnostics to show what the error codes were, and what was happening, but do not understand what I might have done wrong.  If I boot linux from an NFS system or from compact flash, I am able to mount the image and see all the files, so I believe the initrd file system was created correctly.
    I had similar problems with a permanent initramfs filesystem. It is
possible your problem has nothing to do with your filesystem.

    First, I presume the debugging you added was in init/main.c.
          Before you attempt to exec init, you can add code to open
anyfile that you want on the ramdisk. opening a file requires less
things to be right than exec'ing and that may isolate your problem
further. I beleive you can enable system call tracing and find out more
about where things are going off the rails.
          You can also write a trivial hello world - one that does not
use any libraries and very little code, and see if you can exec that.

    When you boot Linux NFS - are you using the same linux kernel ?
         
   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
