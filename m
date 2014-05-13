Return-Path: <anton@samba.org>
Date: Tue, 13 May 2014 20:48:57 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc/pseries: hcall functions are exported to modules,
 need _GLOBAL_TOC()
Message-ID: <20140513204857.3d22562a@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hcall macros may call out to c code for tracing, so we need
to set up a valid r2. This fixes an oops found when testing
ibmvscsi as a module.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/platforms/pseries/hvCall.S b/arch/powerpc/platforms/pseries/hvCall.S
index 7891a86..99ecf0a 100644
--- a/arch/powerpc/platforms/pseries/hvCall.S
+++ b/arch/powerpc/platforms/pseries/hvCall.S
@@ -106,7 +106,7 @@ END_FTR_SECTION(0, 1);						\
 
 	.text
 
-_GLOBAL(plpar_hcall_norets)
+_GLOBAL_TOC(plpar_hcall_norets)
 	HMT_MEDIUM
 
 	mfcr	r0
@@ -122,7 +122,7 @@ _GLOBAL(plpar_hcall_norets)
 	mtcrf	0xff,r0
 	blr				/* return r3 = status */
 
-_GLOBAL(plpar_hcall)
+_GLOBAL_TOC(plpar_hcall)
 	HMT_MEDIUM
 
 	mfcr	r0
@@ -188,7 +188,7 @@ _GLOBAL(plpar_hcall_raw)
 
 	blr				/* return r3 = status */
 
-_GLOBAL(plpar_hcall9)
+_GLOBAL_TOC(plpar_hcall9)
 	HMT_MEDIUM
 
 	mfcr	r0
