Subject: Re: bash: Segmentation fault on 8280
From: "Guy M. Streeter" <streeter@redhat.com>
To: Srinivasa Hebbar <sshebbar@yahoo.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <000f01c3ad19$16bc9070$3d40000a@wisdom>
References: <000f01c3ad19$16bc9070$3d40000a@wisdom>
Content-Type: multipart/mixed; boundary="=-EazrijlpldVTXedA3wiK"
Message-Id: <1069084615.1046.2.camel@jarjar.hsv.redhat.com>
Mime-Version: 1.0
Date: 17 Nov 2003 09:56:56 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-EazrijlpldVTXedA3wiK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-11-17 at 08:42, Srinivasa Hebbar wrote:
> Dear All,
>
> We have 2 identical custom board with MPC-8260 and MPC-8280 CPUs.
> The bash (Came with denx CD) works fine on MPC-8260 board.
> But the same bash program encounters a "Segmentation Fault"
> on 8280 based custom board.
>
> We are using ppc_82xx-gcc compiler to build the linux.
> The linux version is denx-2.4.20

Your kernel might not have 8280 support. See if something like the
attached patch has been applied.

--Guy

>
> Any help is highly appreciated.
>
> Regards,
> S. Hebbar.
>

--=-EazrijlpldVTXedA3wiK
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

--=-EazrijlpldVTXedA3wiK--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
