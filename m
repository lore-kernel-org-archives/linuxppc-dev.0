Return-Path: <jwboyer@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id 166BBDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 22:55:50 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so1934984qwe.15
	for <linuxppc-dev@ozlabs.org>; Fri, 01 May 2009 05:55:48 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Fri, 1 May 2009 08:47:40 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: fix mktree build error on Mac OS X host
Message-ID: <20090501120018.GA2317@yoda.jdub.homelinux.org>
References: <1241151404-5274-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1241151404-5274-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 30, 2009 at 11:16:44PM -0500, Timur Tabi wrote:
>The mktree utility defines some variables as "uint", although this is not a
>standard C type, and so cross-compiling on Mac OS X fails.  Change this to
>"unsigned int".
>
>Signed-off-by: Timur Tabi <timur@freescale.com>

I believe this is only used by the 4xx boards anyway.

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

>---
> arch/powerpc/boot/mktree.c |   10 +++++-----
> 1 files changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/arch/powerpc/boot/mktree.c b/arch/powerpc/boot/mktree.c
>index 45d06a8..c2baae0 100644
>--- a/arch/powerpc/boot/mktree.c
>+++ b/arch/powerpc/boot/mktree.c
>@@ -42,7 +42,7 @@ int main(int argc, char *argv[])
> {
> 	int	in_fd, out_fd;
> 	int	nblks, i;
>-	uint	cksum, *cp;
>+	unsigned int	cksum, *cp;
> 	struct	stat	st;
> 	boot_block_t	bt;
> 
>@@ -90,7 +90,7 @@ int main(int argc, char *argv[])
> 
> 	cksum = 0;
> 	cp = (void *)&bt;
>-	for (i=0; i<sizeof(bt)/sizeof(uint); i++)
>+	for (i = 0; i < sizeof(bt) / sizeof(unsigned int); i++)
> 		cksum += *cp++;
> 
> 	/* Assume zImage is an ELF file, and skip the 64K header.
>@@ -101,7 +101,7 @@ int main(int argc, char *argv[])
> 		exit(4);
> 	}
> 
>-	if ((*(uint *)tmpbuf) != htonl(0x7f454c46)) {
>+	if ((*(unsigned int *)tmpbuf) != htonl(0x7f454c46)) {
> 		fprintf(stderr, "%s is not an ELF image\n", argv[1]);
> 		exit(4);
> 	}
>@@ -125,8 +125,8 @@ int main(int argc, char *argv[])
> 			perror("zImage read");
> 			exit(5);
> 		}
>-		cp = (uint *)tmpbuf;
>-		for (i=0; i<sizeof(tmpbuf)/sizeof(uint); i++)
>+		cp = (unsigned int *)tmpbuf;
>+		for (i = 0; i < sizeof(tmpbuf) / sizeof(unsigned int); i++)
> 			cksum += *cp++;
> 		if (write(out_fd, tmpbuf, sizeof(tmpbuf)) != sizeof(tmpbuf)) {
> 			perror("boot-image write");
>-- 
>1.6.2.4
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-dev
