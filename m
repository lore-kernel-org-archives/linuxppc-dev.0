Return-Path: <sergey.senozhatsky@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xy4wH0rbhzDqYY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 02:30:07 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id u18so1919413pgo.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 09:30:07 -0700 (PDT)
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Subject: [RFC][PATCH v2 7/7] checkpatch: add pF/pf deprecation warning
Date: Thu, 21 Sep 2017 01:29:09 +0900
Message-Id: <20170920162910.32053-8-sergey.senozhatsky@gmail.com>
In-Reply-To: <20170920162910.32053-1-sergey.senozhatsky@gmail.com>
References: <20170920162910.32053-1-sergey.senozhatsky@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We deprecated '%pF/%pf' printk specifiers, since '%pS/%ps' is now smart
enough to handle function pointer dereference on platforms where such
dereference is required.

checkpatch warning example:

WARNING: Use '%pS/%ps' instead. This pointer extension was deprecated: '%pF'

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index dd2c262aebbf..5945e4843466 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5762,18 +5762,20 @@ sub process {
 		        for (my $count = $linenr; $count <= $lc; $count++) {
 				my $fmt = get_quoted_string($lines[$count - 1], raw_line($count, 0));
 				$fmt =~ s/%%//g;
-				if ($fmt =~ /(\%[\*\d\.]*p(?![\WFfSsBKRraEhMmIiUDdgVCbGNO]).)/) {
+				if ($fmt =~ /(\%[\*\d\.]*p(?![\WSsBKRraEhMmIiUDdgVCbGNO]).)/) {
 					$bad_extension = $1;
 					last;
 				}
 			}
 			if ($bad_extension ne "") {
 				my $stat_real = raw_line($linenr, 0);
+				my $error_msg = "Invalid vsprintf pointer extension ";
 				for (my $count = $linenr + 1; $count <= $lc; $count++) {
 					$stat_real = $stat_real . "\n" . raw_line($count, 0);
 				}
+				$error_msg = "Use '%pS/%ps' instead. This pointer extension was deprecated:" if ($bad_extension =~ /pF|pf/);
 				WARN("VSPRINTF_POINTER_EXTENSION",
-				     "Invalid vsprintf pointer extension '$bad_extension'\n" . "$here\n$stat_real\n");
+				     "$error_msg '$bad_extension'\n" . "$here\n$stat_real\n");
 			}
 		}
 
-- 
2.14.1
