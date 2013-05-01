Return-Path: <eric.dumazet@gmail.com>
Received: from mail-da0-x232.google.com (mail-da0-x232.google.com
 [IPv6:2607:f8b0:400e:c00::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DFB9E2C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 May 2013 11:12:50 +1000 (EST)
Received: by mail-da0-f50.google.com with SMTP id a4so481472dad.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 18:12:47 -0700 (PDT)
Message-ID: <1367370761.11020.22.camel@edumazet-glaptop>
Subject: [PATCH net-next] af_unix: fix a fatal race with bit fields
From: Eric Dumazet <eric.dumazet@gmail.com>
To: David Miller <davem@davemloft.net>
Date: Tue, 30 Apr 2013 18:12:41 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: netdev <netdev@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Ambrose Feinstein <ambrose@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Eric Dumazet <edumazet@google.com>

Using bit fields is dangerous on ppc64, as the compiler uses 64bit
instructions to manipulate them. If the 64bit word includes any
atomic_t or spinlock_t, we can lose critical concurrent changes.

This is happening in af_unix, where unix_sk(sk)->gc_candidate/
gc_maybe_cycle/lock share the same 64bit word.

This leads to fatal deadlock, as one/several cpus spin forever
on a spinlock that will never be available again.

Reported-by: Ambrose Feinstein <ambrose@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---

Could ppc64 experts confirm using byte is safe, or should we really add
a 32bit hole after the spinlock ? If so, I wonder how many other places
need a change...

 include/net/af_unix.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index a8836e8..4520a23f 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -57,8 +57,8 @@ struct unix_sock {
 	struct list_head	link;
 	atomic_long_t		inflight;
 	spinlock_t		lock;
-	unsigned int		gc_candidate : 1;
-	unsigned int		gc_maybe_cycle : 1;
+	unsigned char		gc_candidate;
+	unsigned char		gc_maybe_cycle;
 	unsigned char		recursion_level;
 	struct socket_wq	peer_wq;
 };
