Subject: add 8280 processor support
From: "Guy M. Streeter" <streeter@redhat.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Content-Type: multipart/mixed; boundary="=-ZgelMw9lYTQw82jYaYBI"
Message-Id: <1069168993.1045.7.camel@jarjar.hsv.redhat.com>
Mime-Version: 1.0
Date: 18 Nov 2003 09:23:13 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-ZgelMw9lYTQw82jYaYBI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

As far as I can tell, all that's necessary to add support for the 8280
processor is to include it in the cpu_specs table.
I'm running on an 8280 board with the attached patch, which I would like
to see included in the kernel source.

--Guy


--=-ZgelMw9lYTQw82jYaYBI
Content-Disposition: attachment; filename=8280.patch
Content-Type: text/plain; name=8280.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- v2.4.22_linuxppc_2_4_devel/arch/ppc/kernel/cputable.c	2003-07-25 14:39:48.000000000 +0000
+++ sbcPowerQUICCII/arch/ppc/kernel/cputable.c	2003-10-14 18:51:45.000000000 +0000
@@ -299,6 +299,14 @@ struct cpu_spec	cpu_specs[] = {
 	32, 32,
 	__setup_cpu_603
     },
+    {	/* 8280 is a G2_LE (603e core, plus some) */
+	0x7fff0000, 0x00820000, "8280",
+	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
+	CPU_FTR_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
+	COMMON_PPC,
+	32, 32,
+	__setup_cpu_603
+    },
     {	/* default match, we assume split I/D cache & TB (non-601)... */
     	0x00000000, 0x00000000, "(generic PPC)",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,

--=-ZgelMw9lYTQw82jYaYBI--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
