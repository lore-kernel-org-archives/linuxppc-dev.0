Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 569C41A1894
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 06:30:51 +1100 (AEDT)
Date: Sun, 10 Jan 2016 21:30:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 virtualization@lists.linux-foundation.org,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
 "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>,
 linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org,
 Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Andrey Konovalov <andreyknvl@google.com>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH v3 1/3] checkpatch.pl: add missing memory barriers
Message-ID: <1452454200-8844-2-git-send-email-mst@redhat.com>
References: <1452454200-8844-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452454200-8844-1-git-send-email-mst@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SMP-only barriers were missing in checkpatch.pl

Refactor code slightly to make adding more variants easier.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2b3c228..1c01b7d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5116,7 +5116,27 @@ sub process {
 			}
 		}
 # check for memory barriers without a comment.
-		if ($line =~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|smp_wmb|smp_read_barrier_depends)\(/) {
+
+		my $barriers = qr{
+			mb|
+			rmb|
+			wmb|
+			read_barrier_depends
+		}x;
+		my $smp_barrier_stems = qr{
+			mb__before_atomic|
+			mb__after_atomic|
+			store_release|
+			load_acquire|
+			store_mb|
+			(?:$barriers)
+		}x;
+		my $all_barriers = qr{
+			$barriers|
+			smp_(?:$smp_barrier_stems)
+		}x;
+
+		if ($line =~ /\b(?:$all_barriers)\s*\(/) {
 			if (!ctx_has_comment($first_line, $linenr)) {
 				WARN("MEMORY_BARRIER",
 				     "memory barrier without comment\n" . $herecurr);
-- 
MST
