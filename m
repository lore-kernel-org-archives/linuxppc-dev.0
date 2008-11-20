Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id BD6BCDDE1C
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 08:57:50 +1100 (EST)
Message-Id: <20081120215541.489725873@goodmis.org>
Date: Thu, 20 Nov 2008 16:55:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] powerpc: make mcount a stub for dynamic ftrace
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

I have one more patch. I added it to the end of the ppc/ftrace branch.
The new way of handling the finding of mcounts means we do not need
to do anything in the mcount call itself. It should just be a stub
and when ftrace is enabled, it will change the caller sites to call
something other than mcount.

The following patches are in:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git

    branch: ppc/ftrace


Steven Rostedt (1):
      powerpc: ftrace, do nothing in mcount call for dyn ftrace

----
 arch/powerpc/kernel/entry_32.S |   35 +----------------------------------
 arch/powerpc/kernel/entry_64.S |   12 ------------
 2 files changed, 1 insertions(+), 46 deletions(-)
