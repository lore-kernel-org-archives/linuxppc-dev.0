Return-Path: <anton@samba.org>
Date: Thu, 24 Apr 2014 07:25:34 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc/powernv: Fix little endian issues in OPAL flash code
Message-ID: <20140424072534.54351b71@kryten>
Mime-Version: 1.0
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

With this patch I was able to update firmware on an LE kernel.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/powernv/opal-flash.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
index 10ae1b6..becd7be 100644
--- a/arch/powerpc/platforms/powernv/opal-flash.c
+++ b/arch/powerpc/platforms/powernv/opal-flash.c
@@ -128,11 +128,15 @@ static DEFINE_MUTEX(image_data_mutex);
  */
 static inline void opal_flash_validate(void)
 {
-	struct validate_flash_t *args_buf = &validate_flash_data;
+	long ret;
+	void *buf = validate_flash_data.buf;
+	__be32 size, result;
+
+	ret = opal_validate_flash(__pa(buf), &size, &result);
 
-	args_buf->status = opal_validate_flash(__pa(args_buf->buf),
-					       &(args_buf->buf_size),
-					       &(args_buf->result));
+	validate_flash_data.status = ret;
+	validate_flash_data.buf_size = be32_to_cpu(size);
+	validate_flash_data.result = be32_to_cpu(result);
 }
 
 /*
-- 
1.8.3.2
