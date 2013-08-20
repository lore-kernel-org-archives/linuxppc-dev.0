Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id D21162C0106
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 19:30:14 +1000 (EST)
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 05/19] ARM: DT/kernel: define ARM specific
 arch_match_cpu_phys_id
Date: Tue, 20 Aug 2013 10:30:07 +0100
Message-Id: <1376991021-12160-6-git-send-email-Sudeep.KarkadaNagesha@arm.com>
In-Reply-To: <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Jonas Bonn <jonas@southpole.se>, Michal Simek <monstr@monstr.eu>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Russell King <linux@arm.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <rob.herring@calxeda.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

OF/DT core library now provides architecture specific hook to match the
logical cpu index with the corresponding physical identifier. Most of the
cpu DT node parsing and initialisation is contained in devtree.c. So it's
better to define ARM specific arch_match_cpu_phys_id there.

This mainly helps to avoid replication of the code doing CPU node parsing
and physical(MPIDR) to logical mapping.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/arm/kernel/devtree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 5859c8b..2ee8a17 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -169,6 +169,11 @@ void __init arm_dt_init_cpu_maps(void)
 =09}
 }
=20
+bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
+{
+=09return (phys_id & MPIDR_HWID_BITMASK) =3D=3D cpu_logical_map(cpu);
+}
+
 /**
  * setup_machine_fdt - Machine setup when an dtb was passed to the kernel
  * @dt_phys: physical address of dt blob
--=20
1.8.1.2
