Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A022668A3A
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 23:20:29 +1100 (EST)
Date: Wed, 11 Jan 2006 13:20:20 +0100
From: Olaf Hering <olh@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20060111122020.GA14790@suse.de>
References: <200601091916.k09JGMJY004116@hera.kernel.org>
	<20060110221313.GA24246@suse.de> <200601110034.58911.arnd@arndb.de>
	<20060111102540.GA11688@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060111102540.GA11688@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: fix large nvram access
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Wed, Jan 11, Olaf Hering wrote:

> > I think this has uncovered a bug that has been in nvsetenv for a long time.

I made this change.

Index: pmac-utils-2.1/nvsetenv.c
===================================================================
--- pmac-utils-2.1.orig/nvsetenv.c
+++ pmac-utils-2.1/nvsetenv.c
@@ -110,12 +110,21 @@ int nvcsum( void )
 static void nvload( int nvfd )
 {
     int s;
+    ssize_t r, toread = 0;
+    char *buf = (char *)&nvbuf;
 
-    if (lseek(nvfd, NVSTART, 0) < 0
-	|| read(nvfd, &nvbuf, NVSIZE) != NVSIZE) {
-	perror("Error reading /dev/nvram");
+    if ((off_t)-1 == lseek(nvfd, NVSTART, 0)) {
+	perror("Error seeking /dev/nvram");
 	exit(EXIT_FAILURE);
     }
+    do {
+	r = read(nvfd, buf + toread, NVSIZE - toread);
+	if (r < 0) {
+		perror("Error reading /dev/nvram");
+		exit(EXIT_FAILURE);
+	}
+	toread += r;
+    } while (toread < NVSIZE && r);
     if (nvbuf.nv.magic != NVMAGIC)
 	(void) fprintf(stderr, "Warning: Bad magic number %x\n",
 			 nvbuf.nv.magic);
@@ -127,11 +136,21 @@ static void nvload( int nvfd )
 
 static void nvstore(int nvfd)
 {
-    if (lseek(nvfd, NVSTART, 0) < 0
-	|| write(nvfd, &nvbuf, NVSIZE) != NVSIZE) {
-	perror("Error writing /dev/nvram");
+    char *p = (char *)&nvbuf;
+    size_t count = 0;
+    off_t w;
+    if (lseek(nvfd, NVSTART, 0) < 0) {
+	perror("Error seeking /dev/nvram");
 	exit(EXIT_FAILURE);
     }
+    do {
+	w = write(nvfd, p + count, NVSIZE - count);
+	if (w < 0) {
+		perror("Error writing /dev/nvram");
+		exit(EXIT_FAILURE);
+	}
+	count += w;
+   } while (count < NVSIZE);
 }
 
 void nvunpack( void )
Index: pmac-utils-2.1/nwnvsetenv.c
===================================================================
--- pmac-utils-2.1.orig/nwnvsetenv.c
+++ pmac-utils-2.1/nwnvsetenv.c
@@ -88,15 +88,20 @@ int nvscan(int nvfd, chrp_header* chrph,
 static char* nvload( int nvfd , int nvsize)
 {
     char* nvbuf = malloc(nvsize);
+    ssize_t r, toread = 0;
 
     if (!nvbuf) {
 	perror("Error allocating buffer");
 	exit(EXIT_FAILURE);
     }
-    if (read(nvfd, nvbuf, nvsize) != nvsize) {
-	perror("Error reading /dev/nvram");
-	exit(EXIT_FAILURE);
-    }
+    do {
+	r = read(nvfd, nvbuf + toread, nvsize - toread);
+	if (r < 0) {
+		perror("Error reading /dev/nvram");
+		exit(EXIT_FAILURE);
+	}
+	toread += r;
+    } while (toread < nvsize && r);
     return nvbuf;
 }
 
@@ -182,6 +187,7 @@ print_var(char* nvbuf, int nvsize, char*
 	printf("%s\n",buf);
 }
 
+#if 0
 /* This fucntion is not used here, it is left
    her for the curious */
 
@@ -197,26 +203,28 @@ unsigned short chrp_checksum(chrp_header
 	sum = (sum & 0xFF) + (sum>>8);
     return sum;
 }                                                                                                 
+#endif
 
 static void
 nvstore(int nvfd, chrp_header* chrph, char* nvbuf, int nvstart, int nvsize)
 {
     // mmh, the checksum is calculated for the header only
     // since we did not modify the header we can just ignore it.
-    ssize_t written;
-    ssize_t seek =  nvstart + sizeof(chrp_header);
-    written = lseek(nvfd, seek, SEEK_SET);
-    if (written != seek)
-    {
+    size_t count = 0;
+    off_t w, seek =  nvstart + sizeof(chrp_header);
+    w = lseek(nvfd, seek, SEEK_SET);
+    if (w != seek) {
     	fprintf(stderr,"Error seeking /dev/nvram\n");
 	exit(EXIT_FAILURE);
     }
-    written = write(nvfd, nvbuf, nvsize);
-    if (written != nvsize)
-    {
-    	fprintf(stderr,"Error writing /dev/nvram %x %x\n", nvsize, seek);
-	exit(EXIT_FAILURE);
-    }
+    do {
+	w = write(nvfd, nvbuf + count, nvsize - count);
+	if (w < 0) {
+		perror("Error writing /dev/nvram");
+		exit(EXIT_FAILURE);
+	}
+	count += w;
+   } while (count < (size_t)nvsize);
 }
 
 /* print / set the New World NVRAM */

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
