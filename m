Return-Path: <groug@kaod.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSFFD51bxzDvhP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 05:14:23 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uASI3qPv022881
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 13:14:21 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 270mkp92t7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 13:14:20 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <groug@kaod.org>;
 Mon, 28 Nov 2016 11:14:20 -0700
Subject: [PATCH] mail: improve bash completion
From: Greg Kurz <groug@kaod.org>
To: stgit-users@gna.org
Cc: Catalin Marinas <catalin.marinas@gmail.com>
Date: Mon, 28 Nov 2016 19:14:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148035685494.6934.10229668031570371685.stgit@bahia>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds completion of the --to, --cc and --bcc options based on the
content of the [mail "alias"] section of GIT configuration files.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 stgit/argparse.py      |    1 +
 stgit/commands/mail.py |    6 +++---
 stgit/completion.py    |    2 ++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/stgit/argparse.py b/stgit/argparse.py
index 43c6cf9bbbb3..86f4a1095d10 100644
--- a/stgit/argparse.py
+++ b/stgit/argparse.py
@@ -286,6 +286,7 @@ known_files = Compgen(['$(_known_files)'])
 repo = Compgen(actions = ['directory'])
 dir = Compgen(actions = ['directory'])
 files = Compgen(actions = ['file'])
+mail_aliases = Compgen(['$(_mail_aliases)'])
 def strings(*ss): return Compgen(ss)
 class patch_range(CompgenBase):
     def __init__(self, *endpoints):
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index ff9f2e11ca36..2dc3dba6680d 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -102,11 +102,11 @@ args = [argparse.patch_range(argparse.applied_patches,
 options = [
     opt('-a', '--all', action = 'store_true',
         short = 'E-mail all the applied patches'),
-    opt('--to', action = 'append',
+    opt('--to', action = 'append', args = [argparse.mail_aliases],
         short = 'Add TO to the To: list'),
-    opt('--cc', action = 'append',
+    opt('--cc', action = 'append', args = [argparse.mail_aliases],
         short = 'Add CC to the Cc: list'),
-    opt('--bcc', action = 'append',
+    opt('--bcc', action = 'append', args = [argparse.mail_aliases],
         short = 'Add BCC to the Bcc: list'),
     opt('--auto', action = 'store_true',
         short = 'Automatically cc the patch signers'),
diff --git a/stgit/completion.py b/stgit/completion.py
index 38f06705b76a..010fc4fbee0c 100644
--- a/stgit/completion.py
+++ b/stgit/completion.py
@@ -58,6 +58,8 @@ def util():
              'esac'),
          fun('_stg_branches',
              'local g=$(_gitdir)', 'test "$g" && (cd $g/patches/ && echo *)'),
+         fun('_mail_aliases',
+             'git config --name-only --get-regexp "^mail\.alias\." | cut -d. -f 3'),
          ref_list_fun('_all_branches', 'refs/heads'),
          ref_list_fun('_tags', 'refs/tags'),
          ref_list_fun('_remotes', 'refs/remotes')]
