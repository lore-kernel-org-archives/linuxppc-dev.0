Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C0229DDED6
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 04:55:46 +1000 (EST)
Message-ID: <466EEBF4.6010403@am.sony.com>
Date: Tue, 12 Jun 2007 11:54:44 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 27/30] Powerpc: Fix constantness of bootwrapper arg
References: <20070612181825.730300780@am.sony.com>>
In-Reply-To: <20070612181825.730300780@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fixes the constantness of the powerpc bootwrapper's console_ops.write
routine.  Allows writing of constant strings.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/boot/of.c     |    2 +-
 arch/powerpc/boot/ops.h    |    2 +-
 arch/powerpc/boot/serial.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/powerpc/boot/of.c
+++ b/arch/powerpc/boot/of.c
@@ -261,7 +261,7 @@ static int of_console_open(void)
 	return -1;
 }
 
-static void of_console_write(char *buf, int len)
+static void of_console_write(const char *buf, int len)
 {
 	call_prom("write", 3, 1, of_stdout_handle, buf, len);
 }
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -51,7 +51,7 @@ extern struct dt_ops dt_ops;
 /* Console operations */
 struct console_ops {
 	int	(*open)(void);
-	void	(*write)(char *buf, int len);
+	void	(*write)(const char *buf, int len);
 	void	(*edit_cmdline)(char *buf, int len);
 	void	(*close)(void);
 	void	*data;
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -27,7 +27,7 @@ static int serial_open(void)
 	return scdp->open();
 }
 
-static void serial_write(char *buf, int len)
+static void serial_write(const char *buf, int len)
 {
 	struct serial_console_data *scdp = console_ops.data;
 

-- 
