Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 06/63] powerpc/pseries: Simplify H_GET_TERM_CHAR
Date: Wed,  7 Aug 2013 02:01:23 +1000
Message-Id: <1375804940-22050-7-git-send-email-anton@samba.org>
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

plpar_get_term_char is only used once and just adds a layer
of complexity to H_GET_TERM_CHAR. plpar_put_term_char isn't
used at all so we can remove it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/pseries/hvconsole.c      | 12 +++++++++---
 arch/powerpc/platforms/pseries/plpar_wrappers.h | 24 ------------------------
 2 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hvconsole.c b/arch/powerpc/platforms/pseries/hvconsole.c
index b344f94..aa0aa37 100644
--- a/arch/powerpc/platforms/pseries/hvconsole.c
+++ b/arch/powerpc/platforms/pseries/hvconsole.c
@@ -40,10 +40,16 @@
  */
 int hvc_get_chars(uint32_t vtermno, char *buf, int count)
 {
-	unsigned long got;
+	long ret;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	unsigned long *lbuf = (unsigned long *)buf;
+
+	ret = plpar_hcall(H_GET_TERM_CHAR, retbuf, vtermno);
+	lbuf[0] = retbuf[1];
+	lbuf[1] = retbuf[2];
 
-	if (plpar_get_term_char(vtermno, &got, buf) == H_SUCCESS)
-		return got;
+	if (ret == H_SUCCESS)
+		return retbuf[0];
 
 	return 0;
 }
diff --git a/arch/powerpc/platforms/pseries/plpar_wrappers.h b/arch/powerpc/platforms/pseries/plpar_wrappers.h
index f35787b..417d0bf 100644
--- a/arch/powerpc/platforms/pseries/plpar_wrappers.h
+++ b/arch/powerpc/platforms/pseries/plpar_wrappers.h
@@ -256,30 +256,6 @@ static inline long plpar_tce_stuff(unsigned long liobn, unsigned long ioba,
 	return plpar_hcall_norets(H_STUFF_TCE, liobn, ioba, tceval, count);
 }
 
-static inline long plpar_get_term_char(unsigned long termno,
-		unsigned long *len_ret, char *buf_ret)
-{
-	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
-	unsigned long *lbuf = (unsigned long *)buf_ret;	/* TODO: alignment? */
-
-	rc = plpar_hcall(H_GET_TERM_CHAR, retbuf, termno);
-
-	*len_ret = retbuf[0];
-	lbuf[0] = retbuf[1];
-	lbuf[1] = retbuf[2];
-
-	return rc;
-}
-
-static inline long plpar_put_term_char(unsigned long termno, unsigned long len,
-		const char *buffer)
-{
-	unsigned long *lbuf = (unsigned long *)buffer;	/* TODO: alignment? */
-	return plpar_hcall_norets(H_PUT_TERM_CHAR, termno, len, lbuf[0],
-			lbuf[1]);
-}
-
 /* Set various resource mode parameters */
 static inline long plpar_set_mode(unsigned long mflags, unsigned long resource,
 		unsigned long value1, unsigned long value2)
-- 
1.8.1.2
