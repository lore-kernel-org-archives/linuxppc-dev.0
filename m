Return-Path: <joel@jms.id.au>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 91818141471
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:25:56 +1000 (EST)
Received: by mail-pa0-f44.google.com with SMTP id bj1so1627703pad.17
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 00:25:53 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: benh@kernel.crashing.org
Subject: [PATCH 1/5] powerpc/powernv: Fix sysparam sysfs error handling
Date: Thu, 24 Apr 2014 16:55:33 +0930
Message-Id: <1398324337-896-2-git-send-email-joel@jms.id.au>
In-Reply-To: <1398324337-896-1-git-send-email-joel@jms.id.au>
References: <1398324337-896-1-git-send-email-joel@jms.id.au>
Cc: neelegup@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a sysparam query in OPAL returned a negative value (error code),
sysfs would spew out a decent chunk of memory; almost 64K more than
expected. This was traced to a sign/unsigned mix up in the OPAL sysparam
sysfs code at sys_param_show.

The return value of sys_param_show is a ssize_t, calculated using

  return ret ? ret : attr->param_size;

Alan Modra explains:

  "attr->param_size" is an unsigned int, "ret" an int, so the overall
  expression has type unsigned int.  Result is that ret is cast to
  unsigned int before being cast to ssize_t.

Instead of using the ternary operator, set ret to the param_size if an
error is not detected. The same bug exists in the sysfs write callback;
this patch fixes it in the same way.

A note on debugging this next time: on my system gcc will warn about
this if compiled with -Wsign-compare, which is not enabled by -Wall,
only -Wextra.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/platforms/powernv/opal-sysparam.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-sysparam.c b/arch/powerpc/platforms/powernv/opal-sysparam.c
index 0bd249a..cdaf145 100644
--- a/arch/powerpc/platforms/powernv/opal-sysparam.c
+++ b/arch/powerpc/platforms/powernv/opal-sysparam.c
@@ -121,9 +121,10 @@ static ssize_t sys_param_show(struct kobject *kobj,
 
 	memcpy(buf, param_data_buf, attr->param_size);
 
+	ret = attr->param_size;
 out:
 	mutex_unlock(&opal_sysparam_mutex);
-	return ret ? ret : attr->param_size;
+	return ret;
 }
 
 static ssize_t sys_param_store(struct kobject *kobj,
@@ -138,7 +139,9 @@ static ssize_t sys_param_store(struct kobject *kobj,
 	ret = opal_set_sys_param(attr->param_id, attr->param_size,
 			param_data_buf);
 	mutex_unlock(&opal_sysparam_mutex);
-	return ret ? ret : count;
+	if (!ret)
+		ret = count;
+	return ret;
 }
 
 void __init opal_sys_param_init(void)
-- 
1.9.1
