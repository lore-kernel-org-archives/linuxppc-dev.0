Return-Path: <jhovold@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7Zp42H13zDt53
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 02:26:36 +1100 (AEDT)
Received: by mail-lf0-x242.google.com with SMTP id p100so4603349lfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Nov 2016 08:26:36 -0700 (PDT)
Sender: Johan Hovold <jhovold@gmail.com>
From: Johan Hovold <johan@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/4] powerpc/vio: clarify vio_find_node reference counting
Date: Tue,  1 Nov 2016 16:26:02 +0100
Message-Id: <1478013963-28871-3-git-send-email-johan@kernel.org>
In-Reply-To: <1478013963-28871-1-git-send-email-johan@kernel.org>
References: <1478013963-28871-1-git-send-email-johan@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add comment clarifying that vio_find_node() takes a reference to the
embedded struct device which needs to be dropped after use.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/powerpc/kernel/vio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index b3813ddb2fb4..2c8fb3ec989e 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1648,6 +1648,9 @@ static struct vio_dev *vio_find_name(const char *name)
 /**
  * vio_find_node - find an already-registered vio_dev
  * @vnode: device_node of the virtual device we're looking for
+ *
+ * Takes a reference to the embedded struct device which needs to be dropped
+ * after use.
  */
 struct vio_dev *vio_find_node(struct device_node *vnode)
 {
-- 
2.7.3
