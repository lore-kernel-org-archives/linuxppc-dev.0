Return-Path: <haren@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4FDF5679EA
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 04:19:24 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k33IJMuZ000828
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Apr 2006 14:19:22 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k33IG4vm240898
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Apr 2006 12:16:04 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k33IJLuF022229
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Apr 2006 12:19:21 -0600
Message-ID: <44316705.1040202@us.ibm.com>
Date: Mon, 03 Apr 2006 11:18:45 -0700
From: Haren Myneni <haren@us.ibm.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: _machine removal breaks kexec?
References: <20060403014044.GA4704@krispykreme>	<1144080994.4449.10.camel@localhost.localdomain>
	<1078253E-4B9E-4432-86E3-82B01A4B68D1@kernel.crashing.org>
In-Reply-To: <1078253E-4B9E-4432-86E3-82B01A4B68D1@kernel.crashing.org>
Content-Type: multipart/mixed; boundary="------------080401030201030408080302"
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080401030201030408080302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kumar Gala wrote:

>On Apr 3, 2006, at 11:16 AM, Benjamin Herrenschmidt wrote:
>
>  
>
>>On Mon, 2006-04-03 at 11:40 +1000, Anton Blanchard wrote:
>>    
>>
>>>Hi,
>>>
>>>It looks like the _machine removal broke kexec:
>>>
>>> # kexec -l vmlinux
>>> /proc/device-tree/chosen/linux,platform: No such file or directory
>>>
>>>The kexec tools seem to want the linux,platform property:
>>>
>>>        /* if LPAR, no need to read any more from /chosen */
>>>        if (platform != PLATFORM_PSERIES) {
>>>                closedir(cdir);
>>>                continue;
>>>        }
>>>      
>>>
>>Damn.... the platform numbers are gone, we need to fix that. (And  
>>nobody
>>complained when I posted the patch twice over the past couple of  
>>monthes
>>btw).
>>
>>I suppose kexec needs to look for /rtas/hypertas or such ..
>>    
>>
>
>uugh, can we make kexec not depend on something that embedded systems  
>would also have.
>  
>
Basically, kexec-tools looks the platform property to determine whether 
to read tce-base, tce-size and htab-* properties. The attached patch 
find out the platform info based on /proc/device-tree/chosen/htab-base 
property. Not tested yet.
Kumar,  kexec-tools completely depends on device-tree.  Not sure whether 
the embedded system exports the device-tree.

Thanks
Haren

>- k
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-dev
>  
>


--------------080401030201030408080302
Content-Type: text/x-patch;
 name="ppc64-kexec-tools-rm-platform-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc64-kexec-tools-rm-platform-fix.patch"

--- ./kexec-tools-1.101/kexec/arch/ppc64/kexec-ppc64.c.orig	2006-04-07 17:39:08.000000000 -0700
+++ ./kexec-tools-1.101/kexec/arch/ppc64/kexec-ppc64.c	2006-04-07 17:36:34.000000000 -0700
@@ -40,7 +40,7 @@
 
 static struct exclude_range exclude_range[MAX_MEMORY_RANGES];
 static unsigned long long rmo_top;
-static unsigned int platform;
+static unsigned int platform = PLATFORM_PSERIES_LPAR;
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 static struct memory_range base_memory_range[MAX_MEMORY_RANGES];
 unsigned long long memory_max = 0;
@@ -179,8 +179,13 @@ static int get_devtree_details(unsigned 
 	DIR *dir, *cdir;
 	FILE *file;
 	struct dirent *dentry;
+	struct stat sbuf;
+
 	int n, i = 0;
 
+	if (!stat("/proc/device-tree/chosen/linux,htab-base", &sbuf))
+		platform = PLATFORM_PSERIES;
+
 	if ((dir = opendir(device_tree)) == NULL) {
 		perror(device_tree);
 		return -1;
@@ -201,26 +206,6 @@ static int get_devtree_details(unsigned 
 		}
 
 		if (strncmp(dentry->d_name, "chosen", 6) == 0) {
-			/* get platform details from /chosen node */
-			strcat(fname, "/linux,platform");
-			if ((file = fopen(fname, "r")) == NULL) {
-				perror(fname);
-				closedir(cdir);
-				closedir(dir);
-				return -1;
-			}
-			if (fread(&platform, sizeof(int), 1, file) != 1) {
-				perror(fname);
-				fclose(file);
-				closedir(cdir);
-				closedir(dir);
-				return -1;
-			}
-			fclose(file);
-
-			memset(fname, 0, sizeof(fname));
-			strcpy(fname, device_tree);
-			strcat(fname, dentry->d_name);
 			strcat(fname, "/linux,kernel-end");
 			if ((file = fopen(fname, "r")) == NULL) {
 				perror(fname);

--------------080401030201030408080302--
