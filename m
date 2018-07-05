Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LxhG0HPNzF1fk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 22:17:49 +1000 (AEST)
Date: Thu, 5 Jul 2018 05:17:36 -0700
From: Matthew Wilcox <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 15/26] ppc: Convert vas ID allocation to new IDA API
Message-ID: <20180705121736.GB8404@bombadil.infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180621212835.5636-16-willy@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 21, 2018 at 02:28:24PM -0700, Matthew Wilcox wrote:
> Removes a custom spinlock and simplifies the code.

I took a closer look at this patch as part of fixing the typo *ahem*.

The original code is buggy at the limit:

-	if (winid > VAS_WINDOWS_PER_CHIP) {
-		pr_err("Too many (%d) open windows\n", winid);
-		vas_release_window_id(ida, winid);

That permits winid to be == VAS_WINDOWS_PER_CHIP, which is 64 << 10.
Since you then go on to store:

        int id = window->winid;
        vinst->windows[id] = window;

and windows is defined as:

        struct vas_window *windows[VAS_WINDOWS_PER_CHIP];

that's a buffer overflow.

Here's the current version of my patch which will be in linux-next tomorrow.

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index ff9f48812331..e59e0e60e5b5 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -515,35 +515,17 @@ int init_winctx_regs(struct vas_window *window, struct vas_winctx *winctx)
        return 0;
 }
 
-static DEFINE_SPINLOCK(vas_ida_lock);
-
 static void vas_release_window_id(struct ida *ida, int winid)
 {
-       spin_lock(&vas_ida_lock);
-       ida_remove(ida, winid);
-       spin_unlock(&vas_ida_lock);
+       ida_free(ida, winid);
 }
 
 static int vas_assign_window_id(struct ida *ida)
 {
-       int rc, winid;
-
-       do {
-               rc = ida_pre_get(ida, GFP_KERNEL);
-               if (!rc)
-                       return -EAGAIN;
-
-               spin_lock(&vas_ida_lock);
-               rc = ida_get_new(ida, &winid);
-               spin_unlock(&vas_ida_lock);
-       } while (rc == -EAGAIN);
-
-       if (rc)
-               return rc;
+       int winid = ida_alloc_max(ida, VAS_WINDOWS_PER_CHIP - 1, GFP_KERNEL);
 
-       if (winid > VAS_WINDOWS_PER_CHIP) {
-               pr_err("Too many (%d) open windows\n", winid);
-               vas_release_window_id(ida, winid);
+       if (winid == -ENOSPC) {
+               pr_err("Too many (%d) open windows\n", VAS_WINDOWS_PER_CHIP);
                return -EAGAIN;
        }
