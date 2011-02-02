Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 7A538B7109
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Feb 2011 01:17:25 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 26346-02 for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Feb 2011 14:17:20 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/6] ftrace syscalls: Allow arch specific syscallsymbol
	matching
Date: Wed, 2 Feb 2011 14:15:00 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AC3A@saturn3.aculab.com>
In-Reply-To: <1296655484.10797.47.camel@gandalf.stny.rr.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Steven Rostedt" <rostedt@goodmis.org>, "Ian Munsie" <imunsie@au1.ibm.com>
Cc: Andreas Dilger <adilger@dilger.ca>, David Gibson <dwg@au1.ibm.com>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Jiri Kosina <jkosina@suse.cz>, Namhyung Kim <namhyung@gmail.com>,
	linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
	Avantika Mathur <mathur@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Andreas Schwab <schwab@linux-m68k.org>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, Nathan Lynch <ntl@pobox.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Jason Baron <jbaron@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> +#define arch_syscall_match_sym_name(sym, name) !strcmp(sym + 3, name
+ 3)

Whenever you use a #define macro arg, you should enclose it in ().
About the only time you don't need to is when it is being
passed as an argument to another function
(ie when it's use is also ',' separated).

So the above ought to be:
#define arch_syscall_match_sym_name(sym, name) (!strcmp((sym) + 3,
(name) + 3))

Whether an inline function is better or worse is much more subtle!
For instance I've used:
   asm volatile ( "# line " STR(__LINE__) :: )
to stop gcc merging the tails of conditionals.
Useful when the conditional is at the end of a loop (etc),
it might increase code size slightly, but removes a branch.

If I put one of those in an 'inline' function separate copies
of the function end up sharing code.
With a #define __LINE__ differs so they don't.

(I had some code to get below 190 clocks, these changes
were significant!)

	David
