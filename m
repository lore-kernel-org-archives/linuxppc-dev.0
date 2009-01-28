Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Arjan van de Ven <arjan@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH] bootgraph: fix for use with dot symbols
Date: Wed, 28 Jan 2009 14:30:50 +1100
Message-ID: <19599.1233113450@neuling.org>
Sender: mikey@neuling.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc has dot symbols, so the dmesg output looks like:
 
<4>[    0.327310] calling  .migration_init+0x0/0x9c @ 1
<4>[    0.327595] initcall .migration_init+0x0/0x9c returned 1 after 0 usecs

The below fixes bootgraph.pl so it handles this correctly.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 scripts/bootgraph.pl |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6-ozlabs/scripts/bootgraph.pl
===================================================================
--- linux-2.6-ozlabs.orig/scripts/bootgraph.pl
+++ linux-2.6-ozlabs/scripts/bootgraph.pl
@@ -51,7 +51,7 @@ my %pidctr;
 
 while (<>) {
 	my $line = $_;
-	if ($line =~ /([0-9\.]+)\] calling  ([a-zA-Z0-9\_]+)\+/) {
+	if ($line =~ /([0-9\.]+)\] calling  ([a-zA-Z0-9\_\.]+)\+/) {
 		my $func = $2;
 		if ($done == 0) {
 			$start{$func} = $1;
@@ -87,7 +87,7 @@ while (<>) {
 		$count = $count + 1;
 	}
 
-	if ($line =~ /([0-9\.]+)\] initcall ([a-zA-Z0-9\_]+)\+.*returned/) {
+	if ($line =~ /([0-9\.]+)\] initcall ([a-zA-Z0-9\_\.]+)\+.*returned/) {
 		if ($done == 0) {
 			$end{$2} = $1;
 			$maxtime = $1;
