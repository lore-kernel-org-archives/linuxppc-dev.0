Return-Path: <npiggin@gmail.com>
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	skiboot@lists.ozlabs.org
Subject: [RFC][PATCH] powerpc: add device tree binding for cpufeatures
Date: Thu,  2 Feb 2017 03:33:05 +1000
Message-Id: <20170201173305.7248-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cpufeatures binding describes architected CPU features along with
some compatibility, privilege, and enablement properties that allow
flexibility with discovering and enabling capabilities.

For example, FSCR or similar simple prescription based enablement can be
done by an OS that does not understand a new CPU feature. A new
userspace feature that does not require complex support can be enabled
for userspace and advertised in HWCAP aux vectors even when the
hypervisor and OS are not aware of it.

This is still open for review and suggestions. One open question I had
was whether to disable/cull features by removing their nodes, or by
having a status property for each one. The former is simpler to parse,
the latter could provide some information (e.g., why was the feature
disabled).

And signifiantly, this does not document the conventions for the
features, version numbers, base feature set, bit numbers, etc. That
would go somewhere like PAPR.

Thanks,
Nick
---
 .../devicetree/bindings/powerpc/cpufeatures.txt    | 195 +++++++++++++++++++++
 1 file changed, 195 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/cpufeatures.txt

diff --git a/Documentation/devicetree/bindings/powerpc/cpufeatures.txt b/Documentation/devicetree/bindings/powerpc/cpufeatures.txt
new file mode 100644
index 000000000000..c92e1c62b46b
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/cpufeatures.txt
@@ -0,0 +1,195 @@
+powerpc cpufeatures binding
+===========================
+
+The device tree allows the supported architected CPU features to be
+described as nodes containing compatibility and enablement information.
+
+The cpufeatures binding specifies features supported by all CPUs in a
+homogeneous system. Heterogeneous CPU features are not supported at
+present.
+
+The cpufeatures binding passes from firmware to hypervisor, which may
+filter out features based on privilege, compatibility, and other
+configuration settings. Then device tree with this filtered cpufeatures
+binding is passed to the operating systems, which in turn filter and
+expose features to user programs using AT_HWCAP ELF AUX vectors. This is
+done in such a way that an old OS that is unaware of a new hardware
+feature may be able to advertise it to user programs.
+
+There will be a standardized convention for the base level of
+architected CPU features available when the cpufeatures binding exists.
+(XXX TBD)
+
+cpufeatures node binding
+------------------------
+
+Node: cpufeatures
+
+Description: Container of CPU feature nodes.
+
+The node name must be "cpufeatures" and should be a child of the root
+node "/".
+
+The node is optional but should be provided by new firmware.
+
+Each child node of cpufeatures represents an architected CPU feature.
+
+
+feature node bindings
+---------------------
+
+Node: A string describing an architected CPU feature, e.g., "vsx".
+
+Description: An architected feature supported by the CPUs.
+
+The name of the node will follow a convention such that software will
+match known features by a string comparison with the node name. Presence
+of the node indicates the feature is available to use (XXX: could
+advertise all supported by hardware, with disabled/enabled status
+property).
+
+The name of the child node corresponds to the name of the feature.
+Software will detect known features by string matching.
+
+Properties:
+
+- isa
+  Usage: required
+  Value type: <u32>
+  Definition:
+
+  First level of the Power ISA that the feature appears in.
+  Software should filter out features when constraining the
+  environment to a particular ISA version.
+
+- usable_mask
+  Usage: required
+  Value type: <u32> bit mask
+  Definition:
+              bit 0 - PR (problem state / user mode)
+              bit 1 - OS (privileged state)
+              bit 2 - HV (hypervisor state)
+              All other bits reserved and should be zero.
+
+  This property describes the privilege levels and/or software components
+  that can use the feature.
+
+  If bit 0 is set, then the hwcap_bit_nr property will exist.
+
+- hv_support
+  Usage: optional
+  Value type: <u32>
+  Definition:
+              1 -  Custom
+              2 -  HFSCR
+              Other values reserved.
+
+  This property describes the HV privilege state support required to
+  enable the feature. If the property does not exist then no support is
+  required.
+
+  If the value of this property is 1, then the hypervisor must have
+  explicit support for this feature.
+
+  If the value of this property is 2, then the hfscr_bit_nr property
+  will exist.
+
+- os_support
+  Usage: optional
+  Value type: <u32>
+  Definition:
+              1 -  Custom
+              2 -  FSCR
+              Other values reserved.
+
+  This property describes the OS privilege state support required to
+  enable the feature. If the property does not exist then no support is
+  required.
+
+  If the value of this property is 1, then the operating system must
+  have explicit support for this feature.
+
+  If the value of this property is 2, then the fscr_bit_nr property will
+  exist.
+
+- hfscr_bit_nr
+  Usage: optional
+  Value type: <u32>
+  Definition:
+
+  This property exists when the hv_support property value is 2. This
+  property describes the bit number in the HFSCR register that the
+  hypervisor must set in order to enable this feature.
+
+- fscr_bit_nr
+  Usage: optional
+  Value type: <u32>
+  Definition:
+
+  This property exists when the os_support property value is 2. This
+  property describes the bit number in the FSCR register that the
+  operating system must set in order to enable this feature.
+
+- hwcap_bit_nr
+  Usage: optional
+  Value type: <u32>
+  Definition:
+
+  This property exists when the usable_mask property value has bit 0
+  (PR) set.  This property describes the bit number that must be set in
+  the AT_HWCAP ELF AUX vectors in order to advertise this feature to
+  userspace.
+
+- dependencies
+  Usage: optional
+  Value type: <prop-encoded-array>
+  Definition:
+
+  If this property exists then it is a list of phandles to cpu feature
+  nodes that must be enabled for this feature to be enabled.
+
+
+Example
+-------
+
+	cpufeatures {
+
+		darn {
+			isa = <3000>;
+			usable_mask = <1 | 2 | 4>;
+			hwcap_bit_nr = <xx>;
+		};
+
+		scv {
+			isa = <3000>;
+			usable_mask = <1 | 2>;
+			os_support = <1>;
+			hwcap_bit_nr = <xx>;
+		};
+
+		stop {
+			isa = <3000>;
+			usable_mask = <2 | 4>;
+			hv_support = <1>;
+			os_support = <1>;
+		};
+
+		vsx2 (hypothetical) {
+			isa = <3010>;
+			usable_mask = <1 | 2 | 4>;
+			hv_support = <1>;
+			os_support = <1>;
+			hwcap_bit_nr = <xx>;
+		};
+
+		vsx2_newinsns {
+			isa = <3020>;
+			usable_mask = <1 | 2 | 4>;
+			os_support = <2>;
+			fscr_bit_nr = <xx>;
+			hwcap_bit_nr = <xx>;
+			dependencies = <&vsx2>;
+		};
+
+	};
+
-- 
2.11.0
