Return-Path: <pawel.studencki@siemens.com>
Received: from thelpusa.erlm.siemens.de (thelpusa.erlm.siemens.de
	[217.194.34.71]) by ozlabs.org (Postfix) with ESMTP id 03360684E6
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Oct 2005 01:04:19 +1000 (EST)
Received: from metropolis.erlm.siemens.de (metropolis.erlm.siemens.de
	[146.254.160.192])
	by thelpusa.erlm.siemens.de (Postfix) with ESMTP id B8C46CBE75
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Oct 2005 16:55:03 +0200 (CEST)
Received: from nbgh100a.nbg6.siemens.de (nbgh100a.nbg6.siemens.de
	[157.163.55.24])
	by metropolis.erlm.siemens.de (Postfix) with ESMTP id 8D6AF167519
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Oct 2005 16:55:03 +0200 (CEST)
Message-ID: <253377027D27DA11B7010002A5AE5CFE0B72B6@nbgh103a.nbg6.siemens.de>
From: Studencki Pawel <pawel.studencki@siemens.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Fri, 7 Oct 2005 16:55:02 +0200 
MIME-Version: 1.0
Content-Type: text/plain
Subject: TQM8260 and linux-2.6.14-rc3
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hello,

Trying to boot linux-2.6.14-rc3 on TQM8260 I found,
that following line is missing in file arch/ppc/syslib/m8260_setup.c:

-----------------------------------------------------------------------
--- m8260_setup.c.org   2005-10-07 16:42:41.420238000 +0200
+++ m8260_setup.c       2005-10-07 16:41:58.811408400 +0200
@@ -249,6 +249,8 @@
                strcpy(cmd_line, (char *)(r6+KERNELBASE));
        }
 
+        identify_ppc_sys_by_id(mfspr(SPRN_SVR));
+
        ppc_md.setup_arch               = m8260_setup_arch;
        ppc_md.show_cpuinfo             = m8260_show_cpuinfo;
        ppc_md.init_IRQ                 = m8260_init_IRQ;
---------------------------------------------------------------------


if not set, we get problem here:

static int __init ppc_sys_init(void) 
{
        unsigned int i, dev_id, ret = 0;

        BUG_ON(cur_ppc_sys_spec == NULL);   <--------------------------


Moreover the default configuration found in
arch/ppc/configs/TQM8260_defconfig
doesn't work or I do something wrong.
for example configuration of serial port:

#
# Serial drivers
# 
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
# 
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=32

inspite of this I use following(SMC1):

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_CPM=y
CONFIG_SERIAL_CPM_CONSOLE=y
# CONFIG_SERIAL_CPM_SCC1 is not set
# CONFIG_SERIAL_CPM_SCC2 is not set
# CONFIG_SERIAL_CPM_SCC3 is not set
# CONFIG_SERIAL_CPM_SCC4 is not set
CONFIG_SERIAL_CPM_SMC1=y
# CONFIG_SERIAL_CPM_SMC2 is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256


best regards
Pawel
