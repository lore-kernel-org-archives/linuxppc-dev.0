Return-Path: <joel@jms.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BED11A00D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 16:05:46 +1000 (EST)
Received: from mail-pb0-x22d.google.com (mail-pb0-x22d.google.com
 [IPv6:2607:f8b0:400e:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9AF701400A8
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2014 16:05:44 +1000 (EST)
Received: by mail-pb0-f45.google.com with SMTP id um1so5917900pbc.32
 for <linuxppc-dev@ozlabs.org>; Mon, 09 Jun 2014 23:05:42 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/powernv: Fix reading of OPAL msglog
Date: Tue, 10 Jun 2014 16:03:59 +1000
Message-Id: <1402380239-14583-1-git-send-email-joel@jms.id.au>
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

memory_return_from_buffer returns a signed value, so ret should be
ssize_t.

Fixes the following issue reported by David Binderman:

  [linux-3.15/arch/powerpc/platforms/powernv/opal-msglog.c:65]: (style)
  Checking if unsigned variable 'ret' is less than zero.
  [linux-3.15/arch/powerpc/platforms/powernv/opal-msglog.c:82]: (style)
  Checking if unsigned variable 'ret' is less than zero.

  Local variable "ret" is of type size_t. This is always unsigned,
  so it is pointless to check if it is less than zero.

  https://bugzilla.kernel.org/show_bug.cgi?id=77551

Fixing this exposes a real bug for the case where the entire count
bytes is successfully read from the POS_WRAP case. The second
memory_read_from_buffer will return EINVAL, causing the entire read to
return EINVAL to userspace, despite the data being copied correctly. The
fix is to test for the case where the data has been read and return
early.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/platforms/powernv/opal-msglog.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
index 1bb25b9..44ed78a 100644
--- a/arch/powerpc/platforms/powernv/opal-msglog.c
+++ b/arch/powerpc/platforms/powernv/opal-msglog.c
@@ -37,7 +37,8 @@ static ssize_t opal_msglog_read(struct file *file, struct kobject *kobj,
 {
 	struct memcons *mc = bin_attr->private;
 	const char *conbuf;
-	size_t ret, first_read = 0;
+	ssize_t ret;
+	size_t first_read = 0;
 	uint32_t out_pos, avail;
 
 	if (!mc)
@@ -69,6 +70,9 @@ static ssize_t opal_msglog_read(struct file *file, struct kobject *kobj,
 		to += first_read;
 		count -= first_read;
 		pos -= avail;
+
+		if (count <= 0)
+			goto out;
 	}
 
 	/* Sanity check. The firmware should not do this to us. */
-- 
2.0.0
