Return-Path: <anton@samba.org>
Date: Mon, 9 Dec 2013 16:03:10 +1100
From: Anton Blanchard <anton@samba.org>
To: timur@freescale.com, gregkh@linuxfoundation.org,
 benh@kernel.crashing.org, paulus@samba.org, dvaleev@suse.com
Subject: [PATCH] drivers/tty: ehv_bytechan fails to build as a module
Message-ID: <20131209160310.7f81a1bc@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


ehv_bytechan is marked tristate but fails to build as a module:

drivers/tty/ehv_bytechan.c:363:1: error: type defaults to =E2=80=98int=E2=
=80=99 in declaration of =E2=80=98console_initcall=E2=80=99 [-Werror=3Dimpl=
icit-int]

It doesn't make much sense for a console driver to be built as
a module, so change it to a bool.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/drivers/tty/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -366,7 +366,7 @@ config TRACE_SINK
 	  "Trace data router for MIPI P1149.7 cJTAG standard".
=20
 config PPC_EPAPR_HV_BYTECHAN
-	tristate "ePAPR hypervisor byte channel driver"
+	bool "ePAPR hypervisor byte channel driver"
 	depends on PPC
 	select EPAPR_PARAVIRT
 	help
