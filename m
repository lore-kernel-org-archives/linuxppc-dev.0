Message-ID: <20020405202021.61407.qmail@web11105.mail.yahoo.com>
Date: Fri, 5 Apr 2002 12:20:21 -0800 (PST)
From: roger blofeld <blofeldus@yahoo.com>
Subject: Patch: Fix SMP hang on modem close
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ben,
 This patch removes two dangling LOCK() statements for
core99/pangea. The core99 one hung my dual g4.
-roger

--- linux/arch/ppc/kernel/pmac_feature.c.orig   Tue
Apr  2 08:17:31 2002
+++ linux/arch/ppc/kernel/pmac_feature.c        Fri
Apr  5 14:02:13 2002
@@ -788,7 +788,7 @@
                UNLOCK(flags); mdelay(250);
LOCK(flags);
                MACIO_OUT8(KL_GPIO_MODEM_RESET, gpio |
KEYLARGO_GPIO_OUTOUT_DATA);
                (void)MACIO_IN8(KL_GPIO_MODEM_RESET);
-               UNLOCK(flags); mdelay(250);
LOCK(flags);
+               UNLOCK(flags); mdelay(250);
        }
        return 0;
 }
@@ -1445,7 +1445,7 @@
                UNLOCK(flags); mdelay(250);
LOCK(flags);
                MACIO_OUT8(KL_GPIO_MODEM_RESET, gpio |
KEYLARGO_GPIO_OUTOUT_DATA);
                (void)MACIO_IN8(KL_GPIO_MODEM_RESET);
-               UNLOCK(flags); mdelay(250);
LOCK(flags);
+               UNLOCK(flags); mdelay(250);
        }
        return 0;
 }


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
