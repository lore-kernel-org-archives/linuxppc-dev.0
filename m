Return-Path: <chandru@in.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 101A9DDFDF
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 19:51:58 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m7E9or5i031569
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 19:50:53 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7E9ofCA688224
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 19:50:41 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7E9ofrr012294
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 19:50:41 +1000
From: Chandru <chandru@in.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2][V3] kexec-tools: create a new linux,
	drconf-usable-memory property
Date: Thu, 14 Aug 2008 15:20:39 +0530
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808141520.39497.chandru@in.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a new linux,drconf-usable-memory property to the device tree. This property stores the usable memory regions for kexec/kdump kernel. The other changes to kexec-tools which do not affect the kernel are not attached here.  These are the changes to kexec-tools. Patch 1/2 are the changes in kernel. 

Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>
---

 kexec/arch/ppc64/fs2dt.c |   72 +++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

--- kexec-tools-testing-orig/kexec/arch/ppc64/fs2dt.c	2008-08-14 14:41:52.000000000 +0530
+++ kexec-tools-testing/kexec/arch/ppc64/fs2dt.c	2008-08-14 14:46:15.000000000 +0530
@@ -122,6 +122,74 @@ static unsigned propnum(const char *name
 	return offset;
 }
 
+static void add_dyn_reconf_usable_mem_property(int fd)
+{
+	char fname[MAXPATH], *bname;
+	uint64_t buf[32];
+	uint64_t ranges[2*MAX_MEMORY_RANGES];
+	uint64_t base, end, loc_base, loc_end;
+	int range, rlen = 0, i;
+	int rngs_cnt, tmp_indx;
+
+	strcpy(fname, pathname);
+	bname = strrchr(fname, '/');
+	bname[0] = '\0';
+	bname = strrchr(fname, '/');
+	if (strncmp(bname, "/ibm,dynamic-reconfiguration-memory", 36))
+		return;
+
+	if (lseek(fd, 4, SEEK_SET) < 0)
+		die("unrecoverable error: error seeking in \"%s\": %s\n",
+			pathname, strerror(errno));
+
+	rlen = 0;
+	for (i = 0; i < num_of_lmbs; i++) {
+		if (read(fd, buf, 24) < 0)
+			die("unrecoverable error: error reading \"%s\": %s\n",
+				pathname, strerror(errno));
+
+		base = (uint64_t) buf[0];
+		end = base + lmb_size;
+		if (~0ULL - base < end)
+			die("unrecoverable error: mem property overflow\n");
+
+		tmp_indx = rlen++;
+
+		rngs_cnt = 0;
+		for (range = 0; range < usablemem_rgns.size; range++) {
+			loc_base = usablemem_rgns.ranges[range].start;
+			loc_end = usablemem_rgns.ranges[range].end;
+			if (loc_base >= base && loc_end <= end) {
+				ranges[rlen++] = loc_base;
+				ranges[rlen++] = loc_end - loc_base;
+				rngs_cnt++;
+			} else if (base < loc_end && end > loc_base) {
+				if (loc_base < base)
+					loc_base = base;
+				if (loc_end > end)
+					loc_end = end;
+				ranges[rlen++] = loc_base;
+				ranges[rlen++] = loc_end - loc_base;
+				rngs_cnt++;
+			}
+		}
+		/* Store the count of (base, size) duple */
+		ranges[tmp_indx] = rngs_cnt;
+	}
+		
+	rlen = rlen * sizeof(uint64_t);
+	/*
+	 * Add linux,drconf-usable-memory property.
+	 */
+	*dt++ = 3;
+	*dt++ = rlen;
+	*dt++ = propnum("linux,drconf-usable-memory");
+	if ((rlen >= 8) && ((unsigned long)dt & 0x4))
+		dt++;
+	memcpy(dt, &ranges, rlen);
+	dt += (rlen + 3)/4;
+}
+
 static void add_usable_mem_property(int fd, int len)
 {
 	char fname[MAXPATH], *bname;
@@ -267,6 +335,10 @@ static void putprops(char *fn, struct di
 		dt += (len + 3)/4;
 		if (!strcmp(dp->d_name, "reg") && usablemem_rgns.size)
 			add_usable_mem_property(fd, len);
+		if (!strcmp(dp->d_name, "ibm,dynamic-memory") &&
+					usablemem_rgns.size)
+			add_dyn_reconf_usable_mem_property(fd);
+
 		close(fd);
 	}
 
