Message-ID: <3ED63263.1060004@mvista.com>
Date: Thu, 29 May 2003 09:16:35 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Cc: Tom Rini <trini@mvista.com>
Subject: linuxppc_2_4_devel patch for ppc_htab.c (/proc/sys/kernel/l3cr)
Content-Type: multipart/mixed;
 boundary="------------070001090708040202070705"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------070001090708040202070705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Reposting a patch that adds /proc/sys/kernel/l3cr but with the write
functionality #ifdef'd out by default.  Please consider applying.

Mark
--

--------------070001090708040202070705
Content-Type: text/plain;
 name="l3cr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="l3cr.patch"

===== arch/ppc/kernel/ppc_htab.c 1.32 vs edited =====
--- 1.32/arch/ppc/kernel/ppc_htab.c	Thu May 29 08:57:12 2003
+++ edited/arch/ppc/kernel/ppc_htab.c	Thu May 29 09:09:04 2003
@@ -581,3 +581,146 @@
 	filp->f_pos += *lenp;
 	return 0;
 }
+
+int proc_dol3crvec(ctl_table *table, int write, struct file *filp,
+		  void *buffer, size_t *lenp)
+{
+	int vleft, first=1, len, left, val;
+	char buf[TMPBUFLEN], *p;
+	static const char *clockstrings[8] = {
+		"+6 clock", "reserved(1)", "+2 clock", "+2.5 clock",
+		"+3 clock", "+3.5 clock", "+4 clock", "+5 clock"
+	};
+	static const char *clocksampstrings[4] = {
+		"2 clock", "3 clock", "4 clock", "5 clock"
+	};
+	static const char *pclocksampstrings[8] = {
+		"0 P-clock", "1 P-clock", "2 P-clock", "3 P-clock",
+		"4 P-clock", "5 P-clock", "reserved(6)", "reserved(7)"
+	};
+	static const char *typestrings[4] = {
+		"MSUG2 DDR SRAM",
+		"Pipelined synchronous late-write SRAM",
+		"Reserved", "PB2 SRAM"
+	};
+
+	if (!(cur_cpu_spec[0]->cpu_features & CPU_FTR_L3CR))
+		return -EFAULT;
+#ifndef	ENABLE_L3CR_WRITE
+	if (write)
+		return -EFAULT;
+#endif
+
+	if ( /*!table->maxlen ||*/ (filp->f_pos && !write)) {
+		*lenp = 0;
+		return 0;
+	}
+
+	vleft = table->maxlen / sizeof(int);
+	left = *lenp;
+
+	for (; left /*&& vleft--*/; first=0) {
+#ifdef	ENABLE_L3CR_WRITE
+		if (write) {
+			while (left) {
+				char c;
+				if(get_user(c,(char *) buffer))
+					return -EFAULT;
+				if (!isspace(c))
+					break;
+				left--;
+				((char *) buffer)++;
+			}
+			if (!left)
+				break;
+			len = left;
+			if (len > TMPBUFLEN-1)
+				len = TMPBUFLEN-1;
+			if(copy_from_user(buf, buffer, len))
+				return -EFAULT;
+			buf[len] = 0;
+			p = buf;
+			if (*p < '0' || *p > '9')
+				break;
+			val = simple_strtoul(p, &p, 0);
+			len = p-buf;
+			if ((len < left) && *p && !isspace(*p))
+				break;
+			buffer += len;
+			left -= len;
+			_set_L3CR(val);
+		} else {
+#endif
+			p = buf;
+			if (!first)
+				*p++ = '\t';
+			val = _get_L3CR();
+			p += sprintf(p, "0x%08x: ", val);
+			p += sprintf(p, " L3 %s", (val >> 31) & 1 ? "enabled" :
+				     	"disabled");
+			p += sprintf(p, ", %sdata parity", (val>>30)&1 ? "" :
+					"no ");
+			p += sprintf(p, ", %saddr parity", (val>>29)&1 ? "" :
+					"no ");
+			p += sprintf(p, ", %s", (val>>28)&1 ? "2MB" : "1MB");
+			p += sprintf(p, ", clocks %s", (val>>27)&1 ? "enabled" :
+					"disabled");
+			p += sprintf(p, ", %s", clockstrings[(val >> 23) & 7]);
+			p += sprintf(p, ", %sinstn only", (val>>22)&1 ? "" :
+					"no ");
+			p += sprintf(p, ", %ssample point override",
+					(val>>18)&1 ? "" : "no ");
+			p += sprintf(p, ", %s sample point",
+					clocksampstrings[(val>>16)&3]);
+			p += sprintf(p, ", %s sample point",
+					pclocksampstrings[(val>>13)&7]);
+			p += sprintf(p, ", %s replacement", (val>>12)&1 ?
+					"secondary" : "default");
+			p += sprintf(p, ", %s", typestrings[(val >> 8) & 3]);
+			p += sprintf(p, ", %sclock cntl", (val>>7)&1 ? "" :
+					"no ");
+			p += sprintf(p, ", %sdata only", (val>>6)&1 ? "" :
+					"no ");
+			p += sprintf(p, ", private mem %s", (val>>2)&1 ?
+					"enabled" : "disabled");
+			p += sprintf(p, ", %sprivate mem", val&1 ? "2MB " :
+					"1MB ");
+			p += sprintf(p,"\n");
+
+			len = strlen(buf);
+			if (len > left)
+				len = left;
+			if(copy_to_user(buffer, buf, len))
+				return -EFAULT;
+			left -= len;
+			buffer += len;
+			break;
+#ifdef	ENABLE_L3CR_WRITE
+		}
+#endif
+	}
+
+	if (!write && !first && left) {
+		if(put_user('\n', (char *) buffer))
+			return -EFAULT;
+		left--, buffer++;
+	}
+#ifdef	ENABLE_L3CR_WRITE
+	if (write) {
+		p = (char *) buffer;
+		while (left) {
+			char c;
+			if(get_user(c, p++))
+				return -EFAULT;
+			if (!isspace(c))
+				break;
+			left--;
+		}
+	}
+	if (write && first)
+		return -EINVAL;
+#endif
+	*lenp -= left;
+	filp->f_pos += *lenp;
+	return 0;
+}
===== include/linux/sysctl.h 1.19 vs edited =====
--- 1.19/include/linux/sysctl.h	Thu May  8 18:18:47 2003
+++ edited/include/linux/sysctl.h	Thu May 29 08:58:47 2003
@@ -125,6 +125,9 @@
 	KERN_TAINTED=53,	/* int: various kernel tainted flags */
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
  	KERN_CORE_PATTERN=56,	/* string: pattern for core-files */
+
+	KERN_PPC_L3CR=57,       /* l3cr register on PPC */
+
 };


===== kernel/sysctl.c 1.28 vs edited =====
--- 1.28/kernel/sysctl.c	Tue Jan  7 04:00:12 2003
+++ edited/kernel/sysctl.c	Thu May 29 08:58:47 2003
@@ -91,6 +91,8 @@
 extern int powersave_nap;
 int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
 		   void *buffer, size_t *lenp);
+int proc_dol3crvec(ctl_table *table, int write, struct file *filp,
+		   void *buffer, size_t *lenp);
 #endif

 #ifdef CONFIG_BSD_PROCESS_ACCT
@@ -193,6 +195,8 @@
 	 0644, NULL, &proc_dointvec},
 	{KERN_PPC_L2CR, "l2cr", NULL, 0,
 	 0644, NULL, &proc_dol2crvec},
+	{KERN_PPC_L3CR, "l3cr", NULL, 0,
+	 0644, NULL, &proc_dol3crvec},
 #endif
 	{KERN_CTLALTDEL, "ctrl-alt-del", &C_A_D, sizeof(int),
 	 0644, NULL, &proc_dointvec},

--------------070001090708040202070705--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
