Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C71BC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 10:49:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877482084C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 10:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877482084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dkZM2FbWzDqMG
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 20:49:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=fweimer@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dkXg0BnjzDqJ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 20:48:15 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EA9703086228;
 Tue,  9 Apr 2019 10:48:12 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-95.ams2.redhat.com
 [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8527464284;
 Tue,  9 Apr 2019 10:47:46 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: libc-alpha@sourceware.org
Subject: [PATCH] Linux: Define struct termios2 in <termios.h> under
 _GNU_SOURCE [BZ #10339]
Date: Tue, 09 Apr 2019 12:47:30 +0200
Message-ID: <875zrnlakd.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 09 Apr 2019 10:48:13 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 adhemerval.zanella@linaro.org, hpa@zytor.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

struct termios2 is required for setting arbitrary baud rates on serial
ports.  <sys/ioctl.h> and <linux/termios.h> have conflicting
definitions in the existing termios definitions, which means that it
is currently very difficult to use TCGETS2/TCSETS2 and struct termios2
with glibc.  Providing a definition within glibc resolves this problem.

This does not completely address bug 10339, but it at least exposes
the current kernel functionality in this area.

Support for struct termios2 is architecture-specific in the kernel.
Support on alpha was only added in Linux 4.20.  POWER support is
currently missing.  The expectation is that the kernel will eventually
use the generic UAPI definition for struct termios2.

2019-04-09  Florian Weimer  <fweimer@redhat.com>

	[BZ #10339]
	Linux: Define struct termios2 in <termios.h> under _GNU_SOURCE.
	* sysdeps/unix/sysv/linux/Makefile [$(subdir) == termios] (tests):
	Add tst-termios2.
	* sysdeps/unix/sysv/linux/tst-termios2.c: New file.
	* sysdeps/unix/sysv/linux/bits/termios2-struct.h: Likewise.
	* sysdeps/unix/sysv/linux/bits/termios.h [__USE_GNU]: Include it.
	* sysdeps/unix/sysv/linux/alpha/bits/termios2-struct.h: New file.
	* sysdeps/unix/sysv/linux/sparc/bits/termios2-struct.h: Likewise.

diff --git a/NEWS b/NEWS
index b58e2469d4..5e6ecb9c7d 100644
--- a/NEWS
+++ b/NEWS
@@ -18,6 +18,9 @@ Major new features:
 
 * On Linux, the gettid function has been added.
 
+* On Linux, <termios.h> now provides a definition of struct termios2 with
+  the _GNU_SOURCE feature test macro.
+
 * Minguo (Republic of China) calendar support has been added as an
   alternative calendar for the following locales: zh_TW, cmn_TW, hak_TW,
   nan_TW, lzh_TW.
diff --git a/sysdeps/unix/sysv/linux/Makefile b/sysdeps/unix/sysv/linux/Makefile
index 52ac6ad484..4cb5e4f0d2 100644
--- a/sysdeps/unix/sysv/linux/Makefile
+++ b/sysdeps/unix/sysv/linux/Makefile
@@ -156,6 +156,7 @@ endif
 
 ifeq ($(subdir),termios)
 sysdep_headers += termio.h
+tests += tst-termios2
 endif
 
 ifeq ($(subdir),posix)
diff --git a/sysdeps/unix/sysv/linux/alpha/bits/termios2-struct.h b/sysdeps/unix/sysv/linux/alpha/bits/termios2-struct.h
new file mode 100644
index 0000000000..5f09445e23
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/alpha/bits/termios2-struct.h
@@ -0,0 +1,33 @@
+/* struct termios2 definition.  Linux/alpha version.
+   Copyright (C) 2019 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <http://www.gnu.org/licenses/>.  */
+
+#ifndef _TERMIOS_H
+# error "Never include <bits/termios2-struct.h> directly; use <termios.h> instead."
+#endif
+
+struct termios2
+{
+  tcflag_t c_iflag;
+  tcflag_t c_oflag;
+  tcflag_t c_cflag;
+  tcflag_t c_lflag;
+  cc_t c_cc[NCCS];
+  cc_t c_line;
+  speed_t c_ispeed;
+  speed_t c_ospeed;
+};
diff --git a/sysdeps/unix/sysv/linux/bits/termios.h b/sysdeps/unix/sysv/linux/bits/termios.h
index 997231cd03..45ac7affdf 100644
--- a/sysdeps/unix/sysv/linux/bits/termios.h
+++ b/sysdeps/unix/sysv/linux/bits/termios.h
@@ -25,6 +25,10 @@ typedef unsigned int	speed_t;
 typedef unsigned int	tcflag_t;
 
 #include <bits/termios-struct.h>
+#ifdef __USE_GNU
+# include <bits/termios2-struct.h>
+#endif
+
 #include <bits/termios-c_cc.h>
 #include <bits/termios-c_iflag.h>
 #include <bits/termios-c_oflag.h>
diff --git a/sysdeps/unix/sysv/linux/bits/termios2-struct.h b/sysdeps/unix/sysv/linux/bits/termios2-struct.h
new file mode 100644
index 0000000000..5a48e45ef3
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/bits/termios2-struct.h
@@ -0,0 +1,33 @@
+/* struct termios2 definition.  Linux/generic version.
+   Copyright (C) 2019 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <http://www.gnu.org/licenses/>.  */
+
+#ifndef _TERMIOS_H
+# error "Never include <bits/termios2-struct.h> directly; use <termios.h> instead."
+#endif
+
+struct termios2
+{
+  tcflag_t c_iflag;
+  tcflag_t c_oflag;
+  tcflag_t c_cflag;
+  tcflag_t c_lflag;
+  cc_t c_line;
+  cc_t c_cc[NCCS];
+  speed_t c_ispeed;
+  speed_t c_ospeed;
+};
diff --git a/sysdeps/unix/sysv/linux/sparc/bits/termios2-struct.h b/sysdeps/unix/sysv/linux/sparc/bits/termios2-struct.h
new file mode 100644
index 0000000000..7c889e575c
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/sparc/bits/termios2-struct.h
@@ -0,0 +1,33 @@
+/* struct termios2 definition.  Linux/sparc version.
+   Copyright (C) 2019 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <http://www.gnu.org/licenses/>.  */
+
+#ifndef _TERMIOS_H
+# error "Never include <bits/termios2-struct.h> directly; use <termios.h> instead."
+#endif
+
+struct termios2
+{
+  tcflag_t c_iflag;
+  tcflag_t c_oflag;
+  tcflag_t c_cflag;
+  tcflag_t c_lflag;
+  cc_t c_line;
+  cc_t c_cc[NCCS + 2];
+  speed_t c_ispeed;
+  speed_t c_ospeed;
+};
diff --git a/sysdeps/unix/sysv/linux/tst-termios2.c b/sysdeps/unix/sysv/linux/tst-termios2.c
new file mode 100644
index 0000000000..82326a1288
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/tst-termios2.c
@@ -0,0 +1,48 @@
+/* Minimal test of struct termios2 definition.
+   Copyright (C) 2019 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <http://www.gnu.org/licenses/>.  */
+
+#include <termios.h>
+#include <sys/ioctl.h>
+
+/* This function is never executed, but must be compiled successfully.
+   Accessing serial ports in the test suite is problematic because
+   they likely correspond with low-level system functionality.  */
+void
+not_executed (int fd)
+{
+  /* Avoid a compilation failure if TCGETS2, TCSETS2 are not
+     defined.  */
+#if defined (TCGETS2) && defined (TCSETS2)
+  struct termios2 ti;
+  ioctl (fd, TCGETS2, &ti);
+  ioctl (fd, TCSETS2, &ti);
+#endif
+}
+
+static int
+do_test (void)
+{
+  /* Fail at run time if TCGETS2 or TCSETS2 is not defined.  */
+#if defined (TCGETS2) && defined (TCSETS2)
+  return 0;
+#else
+  return 1;
+#endif
+}
+
+#include <support/test-driver.c>
