Return-Path: <fgao@ikuai8.com>
Received: from smtpbg327.qq.com (smtpbg327.qq.com [14.17.43.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSpwL6BjmzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 18:32:02 +1100 (AEDT)
From: fgao@ikuai8.com
To: tomas.winkler@intel.com, rob@landley.net, linux-doc@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 gfree.wind@gmail.com
Cc: Gao Feng <fgao@ikuai8.com>
Subject: [PATCH kernel 1/1] powerpc/Documentation/misc-devices/: Fix one
 compile error
Date: Wed, 22 Feb 2017 15:22:24 +0800
Message-Id: <1487748144-13685-1-git-send-email-fgao@ikuai8.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gao Feng <fgao@ikuai8.com>

When make allyesconfig, there is one compile error on my platform
"gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4".
The following is the output.

Documentation/misc-devices/mei/mei-amt-version.c: In function ‘main’:
Documentation/misc-devices/mei/mei-amt-version.c:103:5: warning: ‘acmd.fd’
is used uninitialized in this function [-Wuninitialized]
  if (cl->fd != -1)
     ^
Documentation/misc-devices/mei/mei-amt-version.c:443:21: note: ‘acmd.fd’
was declared here
  struct amt_host_if acmd;
                     ^
This commit fixes this compile error.

Signed-off-by: Gao Feng <fgao@ikuai8.com>
---
 Documentation/misc-devices/mei/mei-amt-version.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/misc-devices/mei/mei-amt-version.c b/Documentation/misc-devices/mei/mei-amt-version.c
index 49e4f77..ca035cb 100644
--- a/Documentation/misc-devices/mei/mei-amt-version.c
+++ b/Documentation/misc-devices/mei/mei-amt-version.c
@@ -297,6 +297,7 @@ static bool amt_host_if_init(struct amt_host_if *acmd,
 		      unsigned long send_timeout, bool verbose)
 {
 	acmd->send_timeout = (send_timeout) ? send_timeout : 20000;
+	acmd->mei_cl.fd = -1;
 	acmd->initialized = mei_init(&acmd->mei_cl, &MEI_IAMTHIF, 0, verbose);
 	return acmd->initialized;
 }
-- 
1.9.1
