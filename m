Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 772371A0D59
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 22:00:42 +1100 (AEDT)
Date: Mon, 11 Jan 2016 13:00:30 +0200
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
 Julian Calaby <julian.calaby@gmail.com>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH v4 2/3] checkpatch: check for __smp outside barrier.h
Message-ID: <1452509968-19778-3-git-send-email-mst@redhat.com>
References: <1452509968-19778-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452509968-19778-1-git-send-email-mst@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduction of __smp barriers cleans up a bunch of duplicate code, but
it gives people an additional handle onto a "new" set of barriers - just
because they're prefixed with __* unfortunately doesn't stop anyone from
using it (as happened with other arch stuff before.)

Add a checkpatch test so it will trigger a warning.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 94b4e33..25476c2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5143,6 +5143,16 @@ sub process {
 			}
 		}
 
+		my $underscore_smp_barriers = qr{__smp_(?:$barrier_stems)}x;
+
+		if ($realfile !~ m@^include/asm-generic/@ &&
+		    $realfile !~ m@/barrier\.h$@ &&
+		    $line =~ m/\b(?:$underscore_smp_barriers)\s*\(/ &&
+		    $line !~ m/^.\s*\#\s*define\s+(?:$underscore_smp_barriers)\s*\(/) {
+			WARN("MEMORY_BARRIER",
+			     "__smp memory barriers shouldn't be used outside barrier.h and asm-generic\n" . $herecurr);
+		}
+
 # check for waitqueue_active without a comment.
 		if ($line =~ /\bwaitqueue_active\s*\(/) {
 			if (!ctx_has_comment($first_line, $linenr)) {
-- 
MST
