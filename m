Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from WA4EHSOBE005.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 58F5EDDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 07:16:31 +1100 (EST)
Message-ID: <49908F14.50703@am.sony.com>
Date: Mon, 9 Feb 2009 12:16:20 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] ftrace, powerpc64: fix math to calculate offset in TOC
References: <alpine.DEB.1.10.0902080118480.30802@gandalf.stny.rr.com>
In-Reply-To: <alpine.DEB.1.10.0902080118480.30802@gandalf.stny.rr.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Remis Lima Baima <remis.developer@googlemail.com>,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Steven Rostedt wrote:
> I found the bug that was causing large modules to fail in setting
> up dynamic ftrace. It wound up being a simple math error. To calculate
> the offset in the TOC, I had used an OR, but the bottom half was
> a signed extended short, and it should have been an addition.
> The fix is in my tree below, as well as posted here.
> ----
>  arch/powerpc/kernel/ftrace.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)

I tested this on PS3 with CONFIG_FTRACE_SELFTEST=y and
CONFIG_FTRACE_SELFTEST=y, and all modules now load and
the system seems to work properly.  I did not run any
tracer specific tests though.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
