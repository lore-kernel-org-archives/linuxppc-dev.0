Date: Thu, 6 Sep 2001 07:03:58 -0700
From: Matt Porter <mporter@mvista.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Brian Waite <bwaite@cspi.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MVME5100 and bugboot fails
Message-ID: <20010906070358.A9316@cx258813-a.chnd1.az.home.com>
References: <85256ABF.00549667.00@pine.cspi.com> <200109061544.LAA11977@orchid.cspi.com> <20010906085639.F21172@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
In-Reply-To: <20010906085639.F21172@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Thu, Sep 06, 2001 at 08:56:39AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii

On Thu, Sep 06, 2001 at 08:56:39AM -0700, Tom Rini wrote:
>
> On Thu, Sep 06, 2001 at 11:36:39AM -0400, Brian Waite wrote:
>
> > I tried that and I was unable to relocate just the initrd. Right now, I just
> > tested to see:
> > if  ((zImage_start >= 0xf0000000) || (zImage_start <= 0x00800000))
> >
> > That seems to work for now, but I'll take a peek at the gemeni and see how
> > they do it.
>
> Er, after re-reading, it's wrong too.  I'll send you a patch
> privately, if you can test it.

This location checking logic is all a hack...I've already stared at this
a while to make it work for someone.  I recommend we _always_ relocate
both zImage and initrd (if present).

See the attached patch to misc-simple.c (this is versus 2.4.2ish, but
should apply cleanly) which gets the initrd relocated properly...it's
tested with bugboot.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bugboot_initrd.patch"

--- linux-2.4.2_hhl20/arch/ppc/boot/common/misc-simple.c.orig	Wed Sep  5 14:31:27 2001
+++ linux-2.4.2_hhl20/arch/ppc/boot/common/misc-simple.c	Wed Sep  5 14:51:49 2001
@@ -97,39 +97,27 @@
 		initrd_start = 0;
 	initrd_end = INITRD_SIZE + initrd_start;

-	/*
-	 * Find a place to stick the zimage and initrd and
-	 * relocate them if we have to. -- Cort
-	 */
+	/* relocate zimage */
 	avail_ram = (char *)PAGE_ALIGN((unsigned long)_end);
 	puts("zimage at:     "); puthex((unsigned long)zimage_start);
 	puts(" "); puthex((unsigned long)(zimage_size+zimage_start)); puts("\n");
-	if ( (unsigned long)zimage_start <= 0x00800000 )
-	{
-		memcpy( (void *)avail_ram, (void *)zimage_start, zimage_size );
-		zimage_start = (char *)avail_ram;
-		puts("relocated to:  "); puthex((unsigned long)zimage_start);
-		puts(" ");
-		puthex((unsigned long)zimage_size+(unsigned long)zimage_start);
-		puts("\n");
+	memcpy( (void *)avail_ram, (void *)zimage_start, zimage_size );
+	zimage_start = (char *)avail_ram;
+	puts("relocated to:  "); puthex((unsigned long)zimage_start);
+	puts(" ");
+	puthex((unsigned long)zimage_size+(unsigned long)zimage_start);
+	puts("\n");

-		/* relocate initrd */
-		if ( initrd_start )
-		{
-			puts("initrd at:     "); puthex(initrd_start);
-			puts(" "); puthex(initrd_end); puts("\n");
-			avail_ram = (char *)PAGE_ALIGN(
-				(unsigned long)zimage_size+(unsigned long)zimage_start);
-			memcpy ((void *)avail_ram, (void *)initrd_start, INITRD_SIZE );
-			initrd_start = (unsigned long)avail_ram;
-			initrd_end = initrd_start + INITRD_SIZE;
-			puts("relocated to:  "); puthex(initrd_start);
-			puts(" "); puthex(initrd_end); puts("\n");
-		}
-	} else if ( initrd_start ) {
-		puts("initrd at:     "); puthex(initrd_start);
-		puts(" "); puthex(initrd_end); puts("\n");
-	}
+	/* relocate initrd */
+	puts("initrd at:     "); puthex(initrd_start);
+	puts(" "); puthex(initrd_end); puts("\n");
+	avail_ram = (char *)PAGE_ALIGN(
+			(unsigned long)zimage_size+(unsigned long)zimage_start);
+	memcpy ((void *)avail_ram, (void *)initrd_start, INITRD_SIZE );
+	initrd_start = (unsigned long)avail_ram;
+	initrd_end = initrd_start + INITRD_SIZE;
+	puts("relocated to:  "); puthex(initrd_start);
+	puts(" "); puthex(initrd_end); puts("\n");

 	avail_ram = (char *)0x00400000;
 	end_avail = (char *)0x00800000;

--GvXjxJ+pjyke8COw--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
