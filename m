Return-Path: <bwarren@qstreams.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id 14F8167A2E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Jul 2006 05:44:52 +1000 (EST)
Subject: Re: JFFS2 FS is read-only (not what I want)
From: Ben Warren <bwarren@qstreams.com>
To: Mathieu Deschamps <mathieu.deschamps@com2gether.net>
In-Reply-To: <200607031241.27979.mathieu.deschamps@com2gether.net>
References: <44A6E57A.3080302@qstreams.com>
	<200607031241.27979.mathieu.deschamps@com2gether.net>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 15:38:11 -0400
Message-Id: <1151955491.12449.32.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mathieu,
> 
> IMHO, it's not a generation-time issue
> 
This is starting to look to me like a generation-time issue.  I built
another JFFS2 partition out of a random directory on my workstation, and
it's behaving properly:

$mkfs.jffs2 -U -d util -b -e 0x20000 -o /tftpboot/prism/myutil.img

On the target, I booted from NFS and mounted both MTD images.  The
original one is in /dev/mtdblock4 and the new one is at /dev/mtdblock3:

bash-3.00# pwd
/tmp
bash-3.00# mkdir mnt1 mnt2
bash-3.00# ll
total 8
drwxr-xr-x  2 root root 4096 Jul  3  2006 mnt1
drwxr-xr-x  2 root root 4096 Jul  3  2006 mnt2
bash-3.00# mount -t jffs2 -o rw,nolock /dev/mtdblock3 mnt1
bash-3.00# mount -t jffs2 -o rw,nolock /dev/mtdblock4 mnt2
bash-3.00# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/nfs              72054096  13245480  55148432  20% /
/dev/mtdblock3            2048       592      1456  29% /tmp/mnt1
/dev/mtdblock4            2048      2048         0 100% /tmp/mnt2

As you can see, the new image is working fine.  Looks like I need to
debug the root FS! 

Thanks to all people who helped me out here!

cheers,
Ben
 
