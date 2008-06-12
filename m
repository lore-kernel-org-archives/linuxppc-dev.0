Return-Path: <arnd@arndb.de>
Message-Id: <20080612092511.438345634@arndb.de>
References: <20080612091433.851620325@arndb.de>
Date: Thu, 12 Jun 2008 11:14:35 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 2/3] powerpc/pseries: call pseries_kexec_setup only on pseries
Cc: Michael Neuling <mikey@neuling.org>, Jeremy Kerr <jk@ozlabs.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The pseries_kexec_setup function overwrites some ppc_md
pointers, so make sure it only gets called when running on
the right architecture.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/pseries/kexec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platforms/pseries/kexec.c
index e9dd5fe..53cbd53 100644
--- a/arch/powerpc/platforms/pseries/kexec.c
+++ b/arch/powerpc/platforms/pseries/kexec.c
@@ -70,4 +70,4 @@ static int __init pseries_kexec_setup(void)
 
 	return 0;
 }
-__initcall(pseries_kexec_setup);
+machine_device_initcall(pseries, pseries_kexec_setup);
-- 
1.5.4.3

-- 
