Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013D6C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 16:51:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446452084C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 16:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446452084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dtbX4rQ8zDqKZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 02:51:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zytor.com
 (client-ip=198.137.202.136; helo=terminus.zytor.com;
 envelope-from=hpa@zytor.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dtYh49jVzDqJk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 02:49:43 +1000 (AEST)
Received: from [IPv6:2607:fb90:6e34:dae1:acf5:df97:1f3d:b079]
 ([IPv6:2607:fb90:6e34:dae1:acf5:df97:1f3d:b079])
 (authenticated bits=0)
 by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x39FwABP391549
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 9 Apr 2019 08:58:11 -0700
Date: Tue, 09 Apr 2019 09:07:11 -0600
User-Agent: K-9 Mail for Android
In-Reply-To: <875zrnlakd.fsf@oldenburg2.str.redhat.com>
References: <875zrnlakd.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Linux: Define struct termios2 in <termios.h> under
 _GNU_SOURCE [BZ #10339]
To: Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org
From: hpa@zytor.com
Message-ID: <CA8DB086-0ABB-4E37-93F3-89A64B8012DF@zytor.com>
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
 adhemerval.zanella@linaro.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On April 9, 2019 4:47:30 AM MDT, Florian Weimer <fweimer@redhat=2Ecom> wrot=
e:
>struct termios2 is required for setting arbitrary baud rates on serial
>ports=2E  <sys/ioctl=2Eh> and <linux/termios=2Eh> have conflicting
>definitions in the existing termios definitions, which means that it
>is currently very difficult to use TCGETS2/TCSETS2 and struct termios2
>with glibc=2E  Providing a definition within glibc resolves this problem=
=2E
>
>This does not completely address bug 10339, but it at least exposes
>the current kernel functionality in this area=2E
>
>Support for struct termios2 is architecture-specific in the kernel=2E
>Support on alpha was only added in Linux 4=2E20=2E  POWER support is
>currently missing=2E  The expectation is that the kernel will eventually
>use the generic UAPI definition for struct termios2=2E
>
>2019-04-09  Florian Weimer  <fweimer@redhat=2Ecom>
>
>	[BZ #10339]
>	Linux: Define struct termios2 in <termios=2Eh> under _GNU_SOURCE=2E
>	* sysdeps/unix/sysv/linux/Makefile [$(subdir) =3D=3D termios] (tests):
>	Add tst-termios2=2E
>	* sysdeps/unix/sysv/linux/tst-termios2=2Ec: New file=2E
>	* sysdeps/unix/sysv/linux/bits/termios2-struct=2Eh: Likewise=2E
>	* sysdeps/unix/sysv/linux/bits/termios=2Eh [__USE_GNU]: Include it=2E
>	* sysdeps/unix/sysv/linux/alpha/bits/termios2-struct=2Eh: New file=2E
>	* sysdeps/unix/sysv/linux/sparc/bits/termios2-struct=2Eh: Likewise=2E
>
>diff --git a/NEWS b/NEWS
>index b58e2469d4=2E=2E5e6ecb9c7d 100644
>--- a/NEWS
>+++ b/NEWS
>@@ -18,6 +18,9 @@ Major new features:
>=20
> * On Linux, the gettid function has been added=2E
>=20
>+* On Linux, <termios=2Eh> now provides a definition of struct termios2
>with
>+  the _GNU_SOURCE feature test macro=2E
>+
> * Minguo (Republic of China) calendar support has been added as an
> alternative calendar for the following locales: zh_TW, cmn_TW, hak_TW,
>   nan_TW, lzh_TW=2E
>diff --git a/sysdeps/unix/sysv/linux/Makefile
>b/sysdeps/unix/sysv/linux/Makefile
>index 52ac6ad484=2E=2E4cb5e4f0d2 100644
>--- a/sysdeps/unix/sysv/linux/Makefile
>+++ b/sysdeps/unix/sysv/linux/Makefile
>@@ -156,6 +156,7 @@ endif
>=20
> ifeq ($(subdir),termios)
> sysdep_headers +=3D termio=2Eh
>+tests +=3D tst-termios2
> endif
>=20
> ifeq ($(subdir),posix)
>diff --git a/sysdeps/unix/sysv/linux/alpha/bits/termios2-struct=2Eh
>b/sysdeps/unix/sysv/linux/alpha/bits/termios2-struct=2Eh
>new file mode 100644
>index 0000000000=2E=2E5f09445e23
>--- /dev/null
>+++ b/sysdeps/unix/sysv/linux/alpha/bits/termios2-struct=2Eh
>@@ -0,0 +1,33 @@
>+/* struct termios2 definition=2E  Linux/alpha version=2E
>+   Copyright (C) 2019 Free Software Foundation, Inc=2E
>+   This file is part of the GNU C Library=2E
>+
>+   The GNU C Library is free software; you can redistribute it and/or
>+   modify it under the terms of the GNU Lesser General Public
>+   License as published by the Free Software Foundation; either
>+   version 2=2E1 of the License, or (at your option) any later version=
=2E
>+
>+   The GNU C Library is distributed in the hope that it will be
>useful,
>+   but WITHOUT ANY WARRANTY; without even the implied warranty of
>+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the GNU
>+   Lesser General Public License for more details=2E
>+
>+   You should have received a copy of the GNU Lesser General Public
>+   License along with the GNU C Library=2E  If not, see
>+   <http://www=2Egnu=2Eorg/licenses/>=2E  */
>+
>+#ifndef _TERMIOS_H
>+# error "Never include <bits/termios2-struct=2Eh> directly; use
><termios=2Eh> instead=2E"
>+#endif
>+
>+struct termios2
>+{
>+  tcflag_t c_iflag;
>+  tcflag_t c_oflag;
>+  tcflag_t c_cflag;
>+  tcflag_t c_lflag;
>+  cc_t c_cc[NCCS];
>+  cc_t c_line;
>+  speed_t c_ispeed;
>+  speed_t c_ospeed;
>+};
>diff --git a/sysdeps/unix/sysv/linux/bits/termios=2Eh
>b/sysdeps/unix/sysv/linux/bits/termios=2Eh
>index 997231cd03=2E=2E45ac7affdf 100644
>--- a/sysdeps/unix/sysv/linux/bits/termios=2Eh
>+++ b/sysdeps/unix/sysv/linux/bits/termios=2Eh
>@@ -25,6 +25,10 @@ typedef unsigned int	speed_t;
> typedef unsigned int	tcflag_t;
>=20
> #include <bits/termios-struct=2Eh>
>+#ifdef __USE_GNU
>+# include <bits/termios2-struct=2Eh>
>+#endif
>+
> #include <bits/termios-c_cc=2Eh>
> #include <bits/termios-c_iflag=2Eh>
> #include <bits/termios-c_oflag=2Eh>
>diff --git a/sysdeps/unix/sysv/linux/bits/termios2-struct=2Eh
>b/sysdeps/unix/sysv/linux/bits/termios2-struct=2Eh
>new file mode 100644
>index 0000000000=2E=2E5a48e45ef3
>--- /dev/null
>+++ b/sysdeps/unix/sysv/linux/bits/termios2-struct=2Eh
>@@ -0,0 +1,33 @@
>+/* struct termios2 definition=2E  Linux/generic version=2E
>+   Copyright (C) 2019 Free Software Foundation, Inc=2E
>+   This file is part of the GNU C Library=2E
>+
>+   The GNU C Library is free software; you can redistribute it and/or
>+   modify it under the terms of the GNU Lesser General Public
>+   License as published by the Free Software Foundation; either
>+   version 2=2E1 of the License, or (at your option) any later version=
=2E
>+
>+   The GNU C Library is distributed in the hope that it will be
>useful,
>+   but WITHOUT ANY WARRANTY; without even the implied warranty of
>+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the GNU
>+   Lesser General Public License for more details=2E
>+
>+   You should have received a copy of the GNU Lesser General Public
>+   License along with the GNU C Library=2E  If not, see
>+   <http://www=2Egnu=2Eorg/licenses/>=2E  */
>+
>+#ifndef _TERMIOS_H
>+# error "Never include <bits/termios2-struct=2Eh> directly; use
><termios=2Eh> instead=2E"
>+#endif
>+
>+struct termios2
>+{
>+  tcflag_t c_iflag;
>+  tcflag_t c_oflag;
>+  tcflag_t c_cflag;
>+  tcflag_t c_lflag;
>+  cc_t c_line;
>+  cc_t c_cc[NCCS];
>+  speed_t c_ispeed;
>+  speed_t c_ospeed;
>+};
>diff --git a/sysdeps/unix/sysv/linux/sparc/bits/termios2-struct=2Eh
>b/sysdeps/unix/sysv/linux/sparc/bits/termios2-struct=2Eh
>new file mode 100644
>index 0000000000=2E=2E7c889e575c
>--- /dev/null
>+++ b/sysdeps/unix/sysv/linux/sparc/bits/termios2-struct=2Eh
>@@ -0,0 +1,33 @@
>+/* struct termios2 definition=2E  Linux/sparc version=2E
>+   Copyright (C) 2019 Free Software Foundation, Inc=2E
>+   This file is part of the GNU C Library=2E
>+
>+   The GNU C Library is free software; you can redistribute it and/or
>+   modify it under the terms of the GNU Lesser General Public
>+   License as published by the Free Software Foundation; either
>+   version 2=2E1 of the License, or (at your option) any later version=
=2E
>+
>+   The GNU C Library is distributed in the hope that it will be
>useful,
>+   but WITHOUT ANY WARRANTY; without even the implied warranty of
>+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the GNU
>+   Lesser General Public License for more details=2E
>+
>+   You should have received a copy of the GNU Lesser General Public
>+   License along with the GNU C Library=2E  If not, see
>+   <http://www=2Egnu=2Eorg/licenses/>=2E  */
>+
>+#ifndef _TERMIOS_H
>+# error "Never include <bits/termios2-struct=2Eh> directly; use
><termios=2Eh> instead=2E"
>+#endif
>+
>+struct termios2
>+{
>+  tcflag_t c_iflag;
>+  tcflag_t c_oflag;
>+  tcflag_t c_cflag;
>+  tcflag_t c_lflag;
>+  cc_t c_line;
>+  cc_t c_cc[NCCS + 2];
>+  speed_t c_ispeed;
>+  speed_t c_ospeed;
>+};
>diff --git a/sysdeps/unix/sysv/linux/tst-termios2=2Ec
>b/sysdeps/unix/sysv/linux/tst-termios2=2Ec
>new file mode 100644
>index 0000000000=2E=2E82326a1288
>--- /dev/null
>+++ b/sysdeps/unix/sysv/linux/tst-termios2=2Ec
>@@ -0,0 +1,48 @@
>+/* Minimal test of struct termios2 definition=2E
>+   Copyright (C) 2019 Free Software Foundation, Inc=2E
>+   This file is part of the GNU C Library=2E
>+
>+   The GNU C Library is free software; you can redistribute it and/or
>+   modify it under the terms of the GNU Lesser General Public
>+   License as published by the Free Software Foundation; either
>+   version 2=2E1 of the License, or (at your option) any later version=
=2E
>+
>+   The GNU C Library is distributed in the hope that it will be
>useful,
>+   but WITHOUT ANY WARRANTY; without even the implied warranty of
>+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the GNU
>+   Lesser General Public License for more details=2E
>+
>+   You should have received a copy of the GNU Lesser General Public
>+   License along with the GNU C Library=2E  If not, see
>+   <http://www=2Egnu=2Eorg/licenses/>=2E  */
>+
>+#include <termios=2Eh>
>+#include <sys/ioctl=2Eh>
>+
>+/* This function is never executed, but must be compiled successfully=2E
>+   Accessing serial ports in the test suite is problematic because
>+   they likely correspond with low-level system functionality=2E  */
>+void
>+not_executed (int fd)
>+{
>+  /* Avoid a compilation failure if TCGETS2, TCSETS2 are not
>+     defined=2E  */
>+#if defined (TCGETS2) && defined (TCSETS2)
>+  struct termios2 ti;
>+  ioctl (fd, TCGETS2, &ti);
>+  ioctl (fd, TCSETS2, &ti);
>+#endif
>+}
>+
>+static int
>+do_test (void)
>+{
>+  /* Fail at run time if TCGETS2 or TCSETS2 is not defined=2E  */
>+#if defined (TCGETS2) && defined (TCSETS2)
>+  return 0;
>+#else
>+  return 1;
>+#endif
>+}
>+
>+#include <support/test-driver=2Ec>

Anything blocking the POC code I provided?

Note: for PowerPC, define termios2 =3D kernel termios, and the ioctls as a=
liases=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
