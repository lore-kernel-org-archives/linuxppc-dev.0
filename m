Return-Path: <mohan@in.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2D4A5679E9
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 17:06:21 +1000 (EST)
Received: from e5.ny.us.ibm.com (e5.pok.ibm.com [9.56.232.145])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3O6AP1h018229
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 02:10:26 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3O6AIHV009444
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 02:10:18 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3O6AIYk240948
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 02:10:18 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3O6AHWM024116
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 02:10:18 -0400
Date: Mon, 24 Apr 2006 11:40:15 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: fastboot@osdl.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] Reserve crashkernel memory region
Message-ID: <20060424061015.GA31320@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oJ71EGRlYNjSvfq7"
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Now kexec'ed kernel in a PPC64 machine does not reserve memory for crashkernel region. So kexec'ed kernel can not load kdump kernel reliably.

Attached kexec-tools patch reserves memory for kdump kernel by adding an entry in the reserve memory table. So while kexec'ed kernel is booting, it reserves memory for crashkernel region.

Regards,
Mohan.

--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reserve-crashkernel.patch"


In PPC64, kexec'ed kernel does not reserve memory for crashkernel. So 
kexec'ed kernel can not load kdump kernel reliably.

reserve-crashkernel-mem patch adds a reserve entry for crashkernel to the
reserve memory list, so that kexec'ed kernel reserves memory for kdump kernel.
This is done when user passes --append="crashkernel=X@Y" parameter to
kexec command. If user does not pass crashkernel option, memory is not
reserved for kdump kernel.

Signed-off-by: Mohan <mohan@in.ibm.com>
---

 kexec-tools-1.101-kdump9/kexec/arch/ppc64/fs2dt.c       |  135 ++++++++++++----
 kexec-tools-1.101-kdump9/kexec/arch/ppc64/kexec-ppc64.h |    2 
 2 files changed, 107 insertions(+), 30 deletions(-)

diff -puN kexec-tools-1.101-kdump9/kexec/arch/ppc64/fs2dt.c~reserve-crashkernel kexec-tools-1.101-kdump9/kexec/arch/ppc64/fs2dt.c
--- patch/kexec-tools-1.101-kdump9/kexec/arch/ppc64/fs2dt.c~reserve-crashkernel	2006-04-19 18:49:06.000000000 +0530
+++ patch-mohan/kexec-tools-1.101-kdump9/kexec/arch/ppc64/fs2dt.c	2006-04-19 18:55:48.000000000 +0530
@@ -64,8 +64,7 @@ char propnames[NAMESPACE];
 dvt dtstruct[TREEWORDS], *dt;
 unsigned long long mem_rsrv[2*MEMRESERVE];
 
-static int initrd_found = 0;
-static int crash_param = 0;
+static unsigned long crashk_base = 0, crashk_size = 0;
 char local_cmdline[COMMAND_LINE_SIZE] = { "" };
 dvt *dt_len; /* changed len of modified cmdline in flat device-tree */
 extern mem_rgns_t usablemem_rgns;
@@ -191,6 +190,50 @@ void add_usable_mem_property(int fd, int
 	dt += (rlen + 3)/4;
 }
 
+unsigned long mem_parse(const char *ptr, const char **retptr)
+{
+	unsigned long ret = strtoul(ptr, (char **)retptr,10);
+
+	switch (**retptr) {
+		case 'G':
+		case 'g':
+			ret <<= 30;
+			(*retptr)++;
+			break;
+		case 'M':
+		case 'm':
+			ret <<= 20;
+			(*retptr)++;
+			break;
+		case 'K':
+		case 'k':
+			ret <<= 10;
+			(*retptr)++;
+			break;
+	}
+
+	return ret;
+}
+
+void parse_crash_param(char *param)
+{
+	char *cbase, *csize;
+	param += 12;
+	crashk_size = mem_parse(param, (const char **)&csize);
+
+	if (ALIGN(crashk_size, 0x1000000) != crashk_size)
+		printf("Warning: crashkernel size is not aligned to 16MB\n");
+
+	if (*csize == '@') {
+		csize++;
+		crashk_base = mem_parse(csize, (const char **)&cbase);
+		if (crashk_base != 0x2000000)
+			printf("Warning: PPC64 kdump kernel always runs at "
+				       "32 MB\n");
+	}
+	crashk_base = 0x2000000;
+}
+
 /* put all properties (files) in the property structure */
 void putprops(char *fn, struct dirent **nlist, int numlist)
 {
@@ -207,12 +250,6 @@ void putprops(char *fn, struct dirent **
 		if (lstat(pathname, statbuf))
 			err(pathname, ERR_STAT);
 
-		if (!crash_param && !strcmp(fn,"linux,crashkernel-base"))
-			continue;
-
-		if (!crash_param && !strcmp(fn,"linux,crashkernel-size"))
-			continue;
-
 		/*
 		 * This property will be created for each node during kexec
 		 * boot. So, ignore it.
@@ -230,6 +267,13 @@ void putprops(char *fn, struct dirent **
 			!strcmp(dp->d_name, "linux,initrd-end"))
 				continue;
 
+		/* This property will be created/modified later in putnode()
+		 * So ignore it.
+		 */
+		if (!strcmp(dp->d_name, "linux,crashkernel-base") ||
+			!strcmp(dp->d_name, "linux,crashkernel-size"))
+				continue;
+
 		if (S_ISREG(statbuf[0].st_mode)) {
 			int fd, len = statbuf[0].st_size;
 
@@ -260,7 +304,7 @@ void putprops(char *fn, struct dirent **
 					param = strstr(local_cmdline,
 							"crashkernel=");
 					if (param)
-						crash_param = 1;
+						parse_crash_param(param);
 					param = strstr(local_cmdline, "root=");
 				}
 				if (!param) {
@@ -347,35 +391,66 @@ void putnode(void)
 
 	putprops(dn, namelist, numlist);
 
-	/* Add initrd entries to the second kernel if first kernel does not
-	 * have and second kernel needs.
-	 */
-	if (initrd_base && !initrd_found && !strcmp(basename,"/chosen/")) {
+	if (!strcmp(basename,"/chosen/")) {
 		int len = 8;
 		unsigned long long initrd_end;
-		*dt++ = 3;
-		*dt++ = len;
-		*dt++ = propnum("linux,initrd-start");
 
-		if ((len >= 8) && ((unsigned long)dt & 0x4))
-			dt++;
+		/* Add initrd entries to the second kernel if first
+		 *  kernel does not have and second kernel needs.
+		 */
+		if (initrd_base) {
+			*dt++ = 3;
+			*dt++ = len;
+			*dt++ = propnum("linux,initrd-start");
+
+			if ((len >= 8) && ((unsigned long)dt & 0x4))
+				dt++;
+
+			memcpy(dt,&initrd_base,len);
+			dt += (len + 3)/4;
+
+			len = 8;
+			*dt++ = 3;
+			*dt++ = len;
+			*dt++ = propnum("linux,initrd-end");
+
+			initrd_end = initrd_base + initrd_size;
+			if ((len >= 8) && ((unsigned long)dt & 0x4))
+				dt++;
+
+			memcpy(dt,&initrd_end,len);
+			dt += (len + 3)/4;
+
+			reserve(initrd_base, initrd_size);
+		}
+
+		/* Add crashkernel details to the second kernel if first
+		 * kernel does not have and reserve memory for that
+		 */
+		if (crashk_base) {
+			*dt++ = 3;
+			*dt++ = len;
+			*dt++ = propnum("linux,crashkernel-base");
 
-		memcpy(dt,&initrd_base,len);
-		dt += (len + 3)/4;
+			if ((len >= 8) && ((unsigned long)dt & 0x4))
+				dt++;
 
-		len = 8;
-		*dt++ = 3;
-		*dt++ = len;
-		*dt++ = propnum("linux,initrd-end");
+			memcpy(dt,&crashk_base,len);
+			dt += (len + 3)/4;
 
-		initrd_end = initrd_base + initrd_size;
-		if ((len >= 8) && ((unsigned long)dt & 0x4))
-			dt++;
+			len = 8;
+			*dt++ = 3;
+			*dt++ = len;
+			*dt++ = propnum("linux,crashkernel-size");
+
+			if ((len >= 8) && ((unsigned long)dt & 0x4))
+				dt++;
 
-		memcpy(dt,&initrd_end,len);
-		dt += (len + 3)/4;
+			memcpy(dt,&crashk_size,len);
+			dt += (len + 3)/4;
 
-		reserve(initrd_base, initrd_size);
+			reserve(crashk_base, crashk_size);
+		}
 	}
 
 	for (i=0; i < numlist; i++) {
diff -puN kexec-tools-1.101-kdump9/kexec/arch/ppc64/kexec-ppc64.h~reserve-crashkernel kexec-tools-1.101-kdump9/kexec/arch/ppc64/kexec-ppc64.h
--- patch/kexec-tools-1.101-kdump9/kexec/arch/ppc64/kexec-ppc64.h~reserve-crashkernel	2006-04-19 18:49:54.000000000 +0530
+++ patch-mohan/kexec-tools-1.101-kdump9/kexec/arch/ppc64/kexec-ppc64.h	2006-04-19 18:50:29.000000000 +0530
@@ -7,6 +7,8 @@
 #define CORE_TYPE_ELF32 1
 #define CORE_TYPE_ELF64 2
 
+#define ALIGN(val,align) (((val) + ((align) - 1)) & ~((align) - 1))
+
 int setup_memory_ranges(unsigned long kexec_flags);
 
 int elf_ppc64_probe(const char *buf, off_t len);
_

--oJ71EGRlYNjSvfq7--
