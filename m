Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 1E451DE2B2
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 07:09:42 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>
To: "'Timur Tabi'" <timur@freescale.com>,
	<linuxppc-dev@ozlabs.org>
References: <48066857.4030109@freescale.com>
In-Reply-To: <48066857.4030109@freescale.com>
Subject: RE: lseek() on entries in /proc/device-tree returns EINVAL
Date: Wed, 16 Apr 2008 23:09:27 +0200
Message-ID: <062501c8a006$27b17b90$771472b0$@Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozlabs.org [mailto:linuxppc-dev-
> bounces+joakim.tjernlund=transmode.se@ozlabs.org] On Behalf Of Timur Tabi
> Sent: den 16 april 2008 22:58
> To: linuxppc-dev@ozlabs.org
> Subject: lseek() on entries in /proc/device-tree returns EINVAL
> 
> I'm writing a utility that parses the device tree in /proc/device-tree, and in
> order to read a property into memory, I have to first find out how large it is.
>  So I have the following code:
> 
> 	off_t off;
> 	int f;
> 
> 	f = open(filename, O_RDONLY);
> 	if (f == -1) {
> 		perror(__func__);
> 		return NULL;
> 	}
> 
> 	off = lseek(f, 0, SEEK_END);
> 	if (off == -1) {
> 		perror(__func__);
> 		goto fail;
> 	}
> 
> The lseek() call returns -1, and errno is set to EINVAL.  According to the man
> page, this means:
> 
>        EINVAL The  whence  argument  is  not a proper value, or the resulting
>               file offset would be negative for a regular file, block special
>               file, or directory.
> 
> Is there a limitation for the implementation of /proc/device-tree that prevents
> lseek() from working?  If so, how do I determine the size of a property?

Yeah, just reported a similar problem at LKML. busybox start-stop-daemon broke
between 2.6.23 and current tree. The change was intentional but the borkage
was not. Al Viro has been informed, lets see what comes of it.

 Jocke
