Return-Path: <swarren@wwwdotorg.org>
From: Stephen Warren <swarren@wwwdotorg.org>
To: David Gibson <david@gibson.dropbear.id.au>,
	jdl@jdl.com
Subject: [PATCH V2] dtc: ensure #line directives don't consume data from the
 next line
Date: Fri, 31 May 2013 12:33:04 -0600
Message-Id: <1370025184-23808-1-git-send-email-swarren@wwwdotorg.org>
Cc: mmarek@suse.cz, Stephen Warren <swarren@nvidia.com>,
 linux-kbuild@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, rob.herring@calxeda.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stephen Warren <swarren@nvidia.com>

Previously, the #line parsing regex ended with ({WS}+[0-9]+)?. The {WS}
could match line-break characters. If the #line directive did not contain
the optional flags field at the end, this could cause any integer data on
the next line to be consumed as part of the #line directive parsing. This
could cause syntax errors (i.e. #line parsing consuming the leading 0
from a hex literal 0x1234, leaving x1234 to be parsed as cell data,
which is a syntax error), or invalid compilation results (i.e. simply
consuming literal 1234 as part of the #line processing, thus removing it
from the cell data).

Fix this by replacing {WS} with [ \t] so that it can't match line-breaks.

Convert all instances of {WS}, even though the other instances should be
irrelevant for any well-formed #line directive. This is done for
consistency and ultimate safety.

Reported-by: Ian Campbell <Ian.Campbell@citrix.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Convert all instances of {WS} in the regex.

This is a patch for dtc upstream, in response to thread "DTB build
failure due to preproccessing". If/when it's accepted into dtc, I'll
follow up with a kernel patch that makes the same fix.
---
 dtc-lexer.l               |    2 +-
 tests/line_directives.dts |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/dtc-lexer.l b/dtc-lexer.l
index 254d5af..3b41bfc 100644
--- a/dtc-lexer.l
+++ b/dtc-lexer.l
@@ -71,7 +71,7 @@ static int pop_input_file(void);
 			push_input_file(name);
 		}
 
-<*>^"#"(line)?{WS}+[0-9]+{WS}+{STRING}({WS}+[0-9]+)? {
+<*>^"#"(line)?[ \t]+[0-9]+[ \t]+{STRING}([ \t]+[0-9]+)? {
 			char *line, *tmp, *fn;
 			/* skip text before line # */
 			line = yytext;
diff --git a/tests/line_directives.dts b/tests/line_directives.dts
index e9d0800..046ef37 100644
--- a/tests/line_directives.dts
+++ b/tests/line_directives.dts
@@ -8,4 +8,14 @@
 # 6 "bar.dts"
 
 / {
+/*
+ * Make sure optional flags don't consume integer data on next line. The issue
+ * was that the {WS} in the trailing ({WS}+[0-9]+)? could cross the * line-
+ * break, and consume the leading "0" of the hex constant, leaving "x12345678"
+ * to be parsed as a number, which is invalid syntax.
+ */
+	prop1 = <
+# 10 "qux.dts"
+		0x12345678
+	>;
 };
-- 
1.7.10.4
