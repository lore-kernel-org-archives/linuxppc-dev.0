Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 48E7067BE6
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 18:37:02 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k9I9vbKA025721
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 03:57:37 -0600 (MDT)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k9I8avUZ019442
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 03:36:59 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH] Fix the UCC rx tx clock of QE
Date: Wed, 18 Oct 2006 16:36:56 +0800
Message-ID: <995B09A8299C2C44B59866F6391D26351C2E54@zch01exm21.fsl.freescale.net>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

CLK16 of CMXUCR3 and CMXUCR4 registers are missed in
ucc_set_qe_mux_rxtx().
This patch adds the CLK16 to the function. MPC8323EMDS board ethernet
interface
with RMII is use the CLK16 as the rx and tx clock.

Signed-off-by: Dave Liu <daveliu@freescale.com>

---
diff --git a/arch/powerpc/sysdev/qe_lib/ucc.c
b/arch/powerpc/sysdev/qe_lib/ucc.c
index 916c9e5..ac12a44 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc.c
@@ -207,6 +207,7 @@ int ucc_set_qe_mux_rxtx(int ucc_num, enu
                case QE_CLK18:  source =3D 8; break;
                case QE_CLK7:   source =3D 9; break;
                case QE_CLK8:   source =3D 10; break;
+               case QE_CLK16:  source =3D 11; break;
                default:        source =3D -1; break;
                }
                break;
@@ -222,6 +223,7 @@ int ucc_set_qe_mux_rxtx(int ucc_num, enu
                case QE_CLK22:  source =3D 8; break;
                case QE_CLK7:   source =3D 9; break;
                case QE_CLK8:   source =3D 10; break;
+               case QE_CLK16:  source =3D 11; break;
                default:        source =3D -1; break;
                }
                break;
