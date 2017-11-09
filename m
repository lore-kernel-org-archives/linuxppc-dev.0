Return-Path: <sergey.senozhatsky@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yY0Kv3gDpzDrKq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 10:50:59 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 17so5414508pfn.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Nov 2017 15:50:59 -0800 (PST)
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Subject: [PATCHv4 6/6] checkpatch: add pF/pf deprecation warning
Date: Fri, 10 Nov 2017 08:48:30 +0900
Message-Id: <20171109234830.5067-7-sergey.senozhatsky@gmail.com>
In-Reply-To: <20171109234830.5067-1-sergey.senozhatsky@gmail.com>
References: <20171109234830.5067-1-sergey.senozhatsky@gmail.com>
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

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Joe Perches <joe@perches.com>
Cc: Andy Whitcroft <apw@canonical.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 scripts/checkpatch.pl | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3453df9f90ab..d081a2b7166e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5752,18 +5752,25 @@ sub process {
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
+				my $ext_type = "Invalid";
+				my $use = "";
 				for (my $count = $linenr + 1; $count <= $lc; $count++) {
 					$stat_real = $stat_real . "\n" . raw_line($count, 0);
 				}
+				if ($bad_extension =~ /p[Ff]/) {
+					$ext_type = "Deprecated";
+					$use = " - use %pS instead";
+					$use =~ s/pS/ps/ if ($bad_extension =~ /pf/);
+				}
 				WARN("VSPRINTF_POINTER_EXTENSION",
-				     "Invalid vsprintf pointer extension '$bad_extension'\n" . "$here\n$stat_real\n");
+				     "$ext_type vsprintf pointer extension '$bad_extension'$use\n" . "$here\n$stat_real\n");
 			}
 		}
 
-- 
2.15.0
