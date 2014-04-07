Return-Path: <thierry.fauck@free.fr>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
 by ozlabs.org (Postfix) with ESMTP id 0BB5C140098
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Apr 2014 06:09:29 +1000 (EST)
Received: from [192.168.10.108] (unknown [82.228.88.119])
 by smtp6-g21.free.fr (Postfix) with ESMTP id 303E0822D8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Apr 2014 22:09:18 +0200 (CEST)
Message-ID: <534305EC.2000409@free.fr>
Date: Mon, 07 Apr 2014 22:09:16 +0200
From: Thierry FAUCK <thierry.fauck@free.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: tools/testing/selftests/ptrace/peeksiginfo.c bug
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Here is a fix to allow compilation of
tools/testing/selftests/ptrace/peeksiginfo.c on ppc64/ppc64el.
Canonical is waiting for the patch to be upstream.
Thanks

	Thierry



>From 48a9a9834377a74b603be12dcc76cda24105e33c Mon Sep 17 00:00:00 2001
From: Thierry Fauck <thierry@linux.vnet.ibm.com>
Date: Fri, 28 Feb 2014 16:17:50 +0100
Subject: [PATCH] power: PAGE_SIZE may not be defined

Some systems have a dynamic PAGE_SIZE value and do not add a definition
for PAGE_SIZE. This value will have to be retrieved using getpagesize()
or sysconf().

Signed-off-by: Thierry Fauck <thierry@linux.vnet.ibm.com>
---
 tools/testing/selftests/ptrace/peeksiginfo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ptrace/peeksiginfo.c
b/tools/testing/selftests/ptrace/peeksiginfo.c
index d46558b..f2ccbbd 100644
--- a/tools/testing/selftests/ptrace/peeksiginfo.c
+++ b/tools/testing/selftests/ptrace/peeksiginfo.c
@@ -35,7 +35,9 @@ static int sys_ptrace(int request, pid_t pid, void
*addr, void *data)
   fprintf(stderr, \
    "Error (%s:%d): " fmt, \
    __FILE__, __LINE__, ##__VA_ARGS__)
-
+#ifndef PAGE_SIZE
+#define PAGE_SIZE sysconf(_SC_PAGESIZE)
+#endif
 static int check_error_paths(pid_t child)
 {
  struct ptrace_peeksiginfo_args arg;
--
1.9.0
