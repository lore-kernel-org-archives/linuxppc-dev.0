Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7dgz14mQzDq6q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 19:36:46 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0P8YaJr055270
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 03:36:45 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 286q673qgn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 03:36:44 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 25 Jan 2017 01:36:44 -0700
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Oliver O'Halloran" <oohall@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 mark.rutland@arm.com, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Rob Herring <robh@kernel.org>
Subject: [PATCH v6 5/5] Documentation:powerpc: Add device-tree bindings for
 power-mgt
Date: Wed, 25 Jan 2017 14:06:29 +0530
In-Reply-To: <1485333389-5752-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1485333389-5752-1-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <1485333389-5752-6-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Document the device-tree bindings defining the the properties under
the @power-mgt node in the device tree that describe the idle states
for Linux running on baremetal POWER servers.

These bindings are documented separately instead of using the the
common idle state bindings since the idle-states on POWER servers
are exposed as property arrays where as the common idle state bindings
expect idle-states to be described as nodes.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 .../devicetree/bindings/powerpc/opal/power-mgt.txt | 118 +++++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt

diff --git a/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt b/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt
new file mode 100644
index 0000000..9d619e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt
@@ -0,0 +1,118 @@
+IBM Power-Management Bindings
+=============================
+
+Linux running on baremetal POWER machines has access to the processor
+idle states. The description of these idle states is exposed via the
+node @power-mgt in the device-tree by the firmware.
+
+Definitions:
+----------------
+Typically each idle state has the following associated properties:
+
+- name: The name of the idle state as defined by the firmware.
+
+- flags: indicating some aspects of this idle states such as the
+         extent of state-loss, whether timebase is stopped on this
+         idle states and so on. The flag bits are as follows:
+
+- exit-latency: The latency involved in transitioning the state of the
+		CPU from idle to running.
+
+- target-residency: The minimum time that the CPU needs to reside in
+		    this idle state in order to accrue power-savings
+		    benefit.
+
+Properties
+----------------
+The following properties provide details about the idle states. These
+properties are exposed as arrays. Each entry in the property array
+provides the value of that property for the idle state associated with
+the array index of that entry.
+
+If idle-states are defined, then the properties
+"ibm,cpu-idle-state-names" and "ibm,cpu-idle-state-flags" are
+required. The other properties are required unless mentioned
+otherwise. The length of all the property arrays must be the same.
+
+- ibm,cpu-idle-state-names:
+	Array of strings containing the names of the idle states.
+
+- ibm,cpu-idle-state-flags:
+	Array of unsigned 32-bit values containing the values of the
+	flags associated with the the aforementioned idle-states. The
+	flag bits are as follows:
+		0x00000001 /* Decrementer would stop */
+		0x00000002 /* Needs timebase restore */
+		0x00001000 /* Restore GPRs like nap */
+		0x00002000 /* Restore hypervisor resource from PACA pointer */
+		0x00004000 /* Program PORE to restore PACA pointer */
+		0x00010000 /* This is a nap state (POWER7,POWER8) */
+		0x00020000 /* This is a fast-sleep state (POWER8)*/
+		0x00040000 /* This is a winkle state (POWER8) */
+		0x00080000 /* This is a fast-sleep state which requires a */
+			   /* software workaround for restoring the */
+			   /* timebase (POWER8) */
+		0x00800000 /* This state uses SPR PMICR instruction */
+			   /* (POWER8)*/
+		0x00100000 /* This is a fast stop state (POWER9) */
+		0x00200000 /* This is a deep-stop state (POWER9) */
+
+- ibm,cpu-idle-state-latencies-ns:
+	Array of unsigned 32-bit values containing the values of the
+	exit-latencies (in ns) for the idle states in
+	ibm,cpu-idle-state-names.
+
+- ibm,cpu-idle-state-residency-ns:
+	Array of unsigned 32-bit values containing the values of the
+	target-residency (in ns) for the idle states in
+	ibm,cpu-idle-state-names. On POWER8 this is an optional
+	property. If the property is absent, the target residency for
+	the "Nap", "FastSleep" are defined to 10000 and 300000000
+	respectively by the kernel. On POWER9 this property is required.
+
+- ibm,cpu-idle-state-psscr:
+	Array of unsigned 64-bit values containing the values for the
+	PSSCR for each of the idle states in ibm,cpu-idle-state-names.
+	This property is required on POWER9 and absent on POWER8.
+
+- ibm,cpu-idle-state-psscr-mask:
+	Array of unsigned 64-bit values containing the masks
+	indicating which psscr fields are set in the corresponding
+	entries of ibm,cpu-idle-state-psscr. This property is
+	required on POWER9 and absent on POWER8.
+
+	Whenever the firmware sets an entry in
+	ibm,cpu-idle-state-psscr-mask value to 0xf, it implies that
+	only the Requested Level (RL) field of the corresponding entry
+	in ibm,cpu-idle-state-psscr should be considered by the
+	kernel. For such idle states, the kernel would set the
+	remaining fields of the psscr to the following sane-default
+	values.
+
+		- ESL and EC bits are to 1. So wakeup from any stop
+		  state will be at vector 0x100.
+
+		- MTL and PSLL are set to the maximum allowed value as
+		  per the ISA, i.e. 15.
+
+		- The Transition Rate, TR is set to the Maximum value
+                  3.
+
+	For all the other values of the entry in
+	ibm,cpu-idle-state-psscr-mask, the kernel expects all the
+	psscr fields of the corresponding entry in
+	ibm,cpu-idle-state-psscr to be correctly set by the firmware.
+
+- ibm,cpu-idle-state-pmicr:
+	Array of unsigned 64-bit values containing the pmicr values
+	for the idle states in ibm,cpu-idle-state-names. This 64-bit
+	register value is to be set in pmicr for the corresponding
+	state if the flag indicates that pmicr SPR should be set. This
+	is an optional property on POWER8 and is absent on
+	POWER9.
+
+- ibm,cpu-idle-state-pmicr-mask:
+	Array of unsigned 64-bit values containing the mask indicating
+	which of the fields of the PMICR are set in the corresponding
+	entries in ibm,cpu-idle-state-pmicr. This is an optional
+	property on POWER8 and is absent on POWER9.
-- 
1.9.4
