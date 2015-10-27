Return-Path: <sebastian.huber@embedded-brains.de>
Received: from mail.embedded-brains.de
 (host-82-135-62-35.customer.m-online.net [82.135.62.35])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1562C1A040E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 01:47:28 +1100 (AEDT)
To: linuxppc-dev@lists.ozlabs.org
References: <1439410497-19039-4-git-send-email-Roy.Pledge@freescale.com>
Subject: Re: [v2 03/11] soc/fsl: Introduce the DPAA BMan portal driver
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: Geoff Thorpe <Geoff.Thorpe@freescale.com>
Message-ID: <562F8C7C.5080203@embedded-brains.de>
Date: Tue, 27 Oct 2015 15:38:52 +0100
MIME-Version: 1.0
In-Reply-To: <1439410497-19039-4-git-send-email-Roy.Pledge@freescale.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

sorry for the message format, but I don't have the original e-mail.

[...]

diff --git a/drivers/soc/fsl/qbman/bman.h b/drivers/soc/fsl/qbman/bman.h
new file mode 100644
index 0000000..c987938
--- /dev/null
+++ b/drivers/soc/fsl/qbman/bman.h
@@ -0,0 +1,542 @@
+/* Copyright 2008 - 2015 Freescale Semiconductor, Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions ar=
e met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyrig=
ht
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission=
.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of th=
e
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND AN=
Y
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMP=
LIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE AR=
E
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR A=
NY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DA=
MAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SE=
RVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUS=
ED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR=
 TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "bman_priv.h"
+
+extern u16 bman_pool_max;
[...]
diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/=
bman_portal.c
new file mode 100644
index 0000000..62d8f64
--- /dev/null
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -0,0 +1,351 @@
+/* Copyright 2008 - 2015 Freescale Semiconductor, Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions ar=
e met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyrig=
ht
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission=
.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of th=
e
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND AN=
Y
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMP=
LIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE AR=
E
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR A=
NY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DA=
MAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SE=
RVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUS=
ED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR=
 TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "bman_priv.h"
+
+/*
+ * Global variables of the max portal/pool number this BMan version supp=
orted
+ */
+u16 bman_ip_rev;
+EXPORT_SYMBOL(bman_ip_rev);
+
+u16 bman_pool_max;
+EXPORT_SYMBOL(bman_pool_max);
[...]

Why are there two bman_pool_max variables, one global and one module spec=
ific (drivers/soc/fsl/qbman/bman.c) which are similarly initialized. One =
via the BMan register, the other via the FDT?

--=20
Sebastian Huber, embedded brains GmbH

Address : Dornierstr. 4, D-82178 Puchheim, Germany
Phone   : +49 89 189 47 41-16
Fax     : +49 89 189 47 41-09
E-Mail  : sebastian.huber@embedded-brains.de
PGP     : Public key available on request.

Diese Nachricht ist keine gesch=C3=A4ftliche Mitteilung im Sinne des EHUG=
.
