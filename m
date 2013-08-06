Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 32/63] powerpc/pseries: Fix endian issues in
 H_GET_TERM_CHAR/H_PUT_TERM_CHAR
Date: Wed,  7 Aug 2013 02:01:49 +1000
Message-Id: <1375804940-22050-33-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/pseries/hvconsole.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hvconsole.c b/arch/powerpc/platforms/pseries/hvconsole.c
index aa0aa37..ef6d59a 100644
--- a/arch/powerpc/platforms/pseries/hvconsole.c
+++ b/arch/powerpc/platforms/pseries/hvconsole.c
@@ -45,8 +45,8 @@ int hvc_get_chars(uint32_t vtermno, char *buf, int count)
 	unsigned long *lbuf = (unsigned long *)buf;
 
 	ret = plpar_hcall(H_GET_TERM_CHAR, retbuf, vtermno);
-	lbuf[0] = retbuf[1];
-	lbuf[1] = retbuf[2];
+	lbuf[0] = be64_to_cpu(retbuf[1]);
+	lbuf[1] = be64_to_cpu(retbuf[2]);
 
 	if (ret == H_SUCCESS)
 		return retbuf[0];
@@ -75,8 +75,9 @@ int hvc_put_chars(uint32_t vtermno, const char *buf, int count)
 	if (count > MAX_VIO_PUT_CHARS)
 		count = MAX_VIO_PUT_CHARS;
 
-	ret = plpar_hcall_norets(H_PUT_TERM_CHAR, vtermno, count, lbuf[0],
-				 lbuf[1]);
+	ret = plpar_hcall_norets(H_PUT_TERM_CHAR, vtermno, count,
+				 cpu_to_be64(lbuf[0]),
+				 cpu_to_be64(lbuf[1]));
 	if (ret == H_SUCCESS)
 		return count;
 	if (ret == H_BUSY)
-- 
1.8.1.2
