Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id D7AABB7B78
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 21:34:32 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-kernel@vger.kernel.org
Date: Fri,  9 Oct 2009 12:32:59 +0200
Message-Id: <1255084379-12954-1-git-send-email-w.sang@pengutronix.de>
Subject: [RFC] scripts/get_maintainer: add emails based on keywords in the
	patch
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@ozlabs.org,
	Joe Perches <joe@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make get_maintainer.pl scan the modifying lines of a patch for a list of
keywords and add an associated email if found. The first user is the
devicetree-discuss mailing list which should always be cc'ed if a device tree
property is inserted/removed (keyword 'of_get_property'). This patch is the
result from commit 1965d30356c1c65660ba3330927671cfe81acdd5 entering mainline
which seems to have been missed by all parties interested in the device tree
(and at least had the documentation missing). As adding properties can happen
anywhere and so there is no fitting fileglob, this keyword based approach is
proposed.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Joe Perches <joe@perches.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 scripts/get_maintainer.pl |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index cdb44b6..e1150ea 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -44,6 +44,11 @@ my $help = 0;
 
 my $exit = 0;
 
+my %keywords_to_mail = (
+	'of_get_property' => 'L: devicetree-discuss@lists.ozlabs.org',
+);
+my $keywords_to_mail_match = join('|', keys %keywords_to_mail);
+
 my @penguin_chief = ();
 push(@penguin_chief,"Linus Torvalds:torvalds\@linux-foundation.org");
 #Andrew wants in on most everything - 2009/01/14
@@ -188,6 +193,12 @@ if ($email_remove_duplicates) {
 
 my @files = ();
 my @range = ();
+my @email_to = ();
+my @list_to = ();
+my @scm = ();
+my @web = ();
+my @subsystem = ();
+my @status = ();
 
 foreach my $file (@ARGV) {
     ##if $file is a directory and it lacks a trailing slash, add one
@@ -213,7 +224,11 @@ foreach my $file (@ARGV) {
 		if ($email_git_blame) {
 		    push(@range, "$lastfile:$1:$2");
 		}
-	    }
+	    # Check the lines which a patch modifies for keywords; add mail if found.
+	    } elsif (m/^[+-].*($keywords_to_mail_match)/o) {
+		(my $keyword_mail = $keywords_to_mail{$1}) =~ s/^([LM]): //;
+		push( @{ ($1 eq 'L') ? \@list_to : \@email_to }, $keyword_mail );
+	   }
 	}
 	close(PATCH);
 	if ($file_cnt == @files) {
@@ -224,13 +239,6 @@ foreach my $file (@ARGV) {
     }
 }
 
-my @email_to = ();
-my @list_to = ();
-my @scm = ();
-my @web = ();
-my @subsystem = ();
-my @status = ();
-
 # Find responsible parties
 
 foreach my $file (@files) {
-- 
1.6.3.3
