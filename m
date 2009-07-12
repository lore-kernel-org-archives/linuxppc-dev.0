Return-Path: <julia@diku.dk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F004AB7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jul 2009 06:43:27 +1000 (EST)
Received: from mgw1.diku.dk (mgw1.diku.dk [130.225.96.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw1.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 82A34DDDE7
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2009 06:43:27 +1000 (EST)
Date: Sun, 12 Jul 2009 22:03:42 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 1/5] drivers/char/hvc_console.c: Drop unnecessary NULL test
Message-ID: <Pine.LNX.4.64.0907122203060.22658@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

The result of container_of should not be NULL.  In particular, in this case
the argument to the enclosing function has passed though INIT_WORK, which
dereferences it, implying that its container cannot be NULL.

A simplified version of the semantic patch that makes this change is as
follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@
identifier fn,work,x,fld;
type T;
expression E1,E2;
statement S;
@@

static fn(struct work_struct *work) {
  ... when != work = E1
  x = container_of(work,T,fld)
  ... when != x = E2
- if (x == NULL) S
  ...
}
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/char/hvc_console.c          |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index 94e7e3c..e367630 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -516,8 +516,6 @@ static void hvc_set_winsz(struct work_struct *work)
 	struct winsize ws;
 
 	hp = container_of(work, struct hvc_struct, tty_resize);
-	if (!hp)
-		return;
 
 	spin_lock_irqsave(&hp->lock, hvc_flags);
 	if (!hp->tty) {
