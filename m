Return-Path: <thierry@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E01AC140086
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 May 2014 02:03:04 +1000 (EST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <thierry@linux.vnet.ibm.com>;
 Thu, 15 May 2014 17:03:00 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 787092190056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 17:02:49 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4FG2wEf66650290
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 16:02:58 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4FG2vCk011147
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 12:02:57 -0400
Message-ID: <5374E532.10002@linux.vnet.ibm.com>
Date: Thu, 15 May 2014 18:02:58 +0200
From: "Thierry Fauck ( thierry @ linux.vnet.ibm.com )"
 <thierry@linux.vnet.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org-, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] selftests: PAGE_SIZE may not be defined
Content-Type: multipart/alternative;
 boundary="------------090100070006020401010008"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090100070006020401010008
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Ben,

The following patch seems relevant for Ubuntu and Debian distro testing.
I know it's minor but I need to know if you do you care about it or sif
I should remove it from the bugs info.

Thanks

Best regards
Thierry

#---------------------------------------------------------------------------------------------------

>From 48a9a9834377a74b603be12dcc76cda24105e33c Mon Sep 17 00:00:00 2001

From: Thierry Fauck <thierry@linux.vnet.ibm.com>
Date: Fri, 28 Feb 2014 16:17:50 +0100
Subject: [PATCH] selftests: PAGE_SIZE may not be defined

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

-- 
Thierry Fauck (thierry@linux.vnet.ibm.com)


--------------090100070006020401010008
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi Ben,<br>
    <br>
    The following patch seems relevant for Ubuntu and Debian distro
    testing.<br>
    I know it's minor but I need to know if you do you care about it or
    sif I should remove it from the bugs info.<br>
    <br>
    Thanks<br>
    <br>
    Best regards<br>
    Thierry <br>
    <br>
#---------------------------------------------------------------------------------------------------<br>
    <br>
    From 48a9a9834377a74b603be12dcc76cda24105e33c Mon Sep 17 00:00:00
    2001<br>
    <p>
      From: Thierry Fauck &lt;thierry@<wbr>linux.vnet.<wbr>ibm.com&gt;<br>
      Date: Fri, 28 Feb 2014 16:17:50 +0100<br>
      Subject: [PATCH] selftests: PAGE_SIZE may not be defined</p>
    <p id="yui_3_10_3_1_1400169293937_1507">Some systems have a dynamic
      PAGE_SIZE value and do not add a definition<br>
      for PAGE_SIZE. This value will have to be retrieved using
      getpagesize()<br>
      or sysconf().</p>
    <p>Signed-off-by: Thierry Fauck &lt;thierry@<wbr>linux.vnet.<wbr>ibm.com&gt;<br>
      ---<br>
      &nbsp;tools/<wbr>testing/<wbr>selftests/<wbr>ptrace/<wbr>peeksiginfo.<wbr>c
      | 4 +++-<br>
      &nbsp;1 file changed, 3 insertions(+), 1 deletion(-)</p>
    <p>diff --git a/tools/<wbr>testing/<wbr>selftests/<wbr>ptrace/<wbr>peeksiginfo.<wbr>c
      b/tools/<wbr>testing/<wbr>selftests/<wbr>ptrace/<wbr>peeksiginfo.<wbr>c<br>
      index d46558b..f2ccbbd 100644<br>
      --- a/tools/<wbr>testing/<wbr>selftests/<wbr>ptrace/<wbr>peeksiginfo.<wbr>c<br>
      +++ b/tools/<wbr>testing/<wbr>selftests/<wbr>ptrace/<wbr>peeksiginfo.<wbr>c<br>
      @@ -35,7 +35,9 @@ static int sys_ptrace(int request, pid_t pid,
      void *addr, void *data)<br>
      &nbsp;&nbsp;&nbsp;fprintf(stderr, \<br>
      &nbsp;&nbsp;&nbsp;&nbsp;"Error (%s:%d): " fmt, \<br>
      &nbsp;&nbsp;&nbsp;&nbsp;__FILE__, __LINE__, ##__VA_ARGS__)<br>
      -<br>
      +#ifndef PAGE_SIZE<br>
      +#define PAGE_SIZE sysconf(<wbr>_SC_PAGESIZE)<br>
      +#endif<br>
      &nbsp;static int check_error_<wbr>paths(pid_<wbr>t child)<br>
      &nbsp;{<br>
      &nbsp;&nbsp;struct ptrace_<wbr>peeksiginfo_<wbr>args arg;<br>
      --<br>
      1.9.0</p>
    <pre class="moz-signature" cols="72">-- 
Thierry Fauck (<a class="moz-txt-link-abbreviated" href="mailto:thierry@linux.vnet.ibm.com">thierry@linux.vnet.ibm.com</a>)</pre>
  </body>
</html>

--------------090100070006020401010008--
