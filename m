Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id EAA5DDDE11
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 09:04:25 +1100 (EST)
Message-Id: <20081126215821.263324391@goodmis.org>
Date: Wed, 26 Nov 2008 16:58:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>, Michael Ellerman <michael@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 0/5] powerpc: ftrace updates to previous patch series
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

This patch series addresses the issues you brought up as well as
adds some more enhancements and fixes. This series is added on
top of the previous patch series.

The new patches are: (and are posted now)
5987225... powerpc/ppc32: static ftrace fixes for PPC32
382d6db... powerpc: ftrace, use create_branch
d7d0ab8... powerpc: ftrace, added missing icache flush
10ec622... powerpc: ftrace, fix cast aliasing and add code verification
d208ca5... powerpc: ftrace, do nothing in mcount call for dyn ftrace

The patches you already commented on:
5c4f5d7... powerpc/ppc32: ftrace, dynamic ftrace to handle modules
a73af3e... powerpc/ppc64: ftrace, handle module trampolines for dyn ftrace
009104f... powerpc: ftrace, use probe_kernel API to modify code
a352036... powerpc: ftrace, convert to new dynamic ftrace arch API
6d07bb4... powerpc: ftrace, do not latency trace idle

Note, I also fixed the spelling of your name in the change log of commit
a352036... powerpc: ftrace, convert to new dynamic ftrace arch API

I'm only posting the new patches. I've tested this on both my
PPC64 and my PPC32 boxes.  You can test this as well by checking out
my tip/ppc branch which is based off of an older version of tip
and has the ppc dynamic ftrace code enabled. That branch is not to pull
from, but is there for you to try out this code if you like.

The previous patch series, which have not changed except for the 
spelling fix of Paul's last name, can be found here:

  http://lkml.org/lkml/2008/11/20/356


The following patches are in:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git

    branch: ppc/ftrace


Steven Rostedt (5):
      powerpc: ftrace, do nothing in mcount call for dyn ftrace
      powerpc: ftrace, fix cast aliasing and add code verification
      powerpc: ftrace, added missing icache flush
      powerpc: ftrace, use create_branch
      powerpc/ppc32: static ftrace fixes for PPC32

----
 arch/powerpc/kernel/Makefile   |    1 +
 arch/powerpc/kernel/entry_32.S |   40 ++-------
 arch/powerpc/kernel/entry_64.S |   12 ---
 arch/powerpc/kernel/ftrace.c   |  182 +++++++++++++++++++---------------------
 arch/powerpc/lib/Makefile      |    3 +
 5 files changed, 98 insertions(+), 140 deletions(-)
