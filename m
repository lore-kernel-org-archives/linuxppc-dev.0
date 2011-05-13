Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 0B944B6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 14 May 2011 01:30:38 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 25566-10 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 May 2011 16:30:31 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	callfiltering
Date: Fri, 13 May 2011 16:29:27 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD37@saturn3.aculab.com>
In-Reply-To: <1305299880.2076.31.camel@localhost.localdomain>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Eric Paris" <eparis@redhat.com>,
	"Ingo Molnar" <mingo@elte.hu>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
	"H. PeterAnvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>, linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	James Morris <jmorris@namei.org>, Ingo Molnar <mingo@redhat.com>,
	kees.cook@canonical.com, "Serge E. Hallyn" <serge@hallyn.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, agl@chromium.org,
	linux-arm-kernel@lists.infradead.org,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	Will Drewry <wad@chromium.org>, linuxppc-dev@lists.ozlabs.org,
	Oleg Nesterov <oleg@redhat.com>, Ralf Baechle <ralf@linux-mips.org>,
	Paul Mundt <lethal@linux-sh.org>, Tejun Heo <tj@kernel.org>,
	linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> ... If you can be completely stateless its easier, but there's
> a reason that stacking security modules is hard.  Serge has tried in
the
> past and both dhowells and casey schaufler are working on it right
now.
> Stacking is never as easy as it sounds   :)

For a bad example of trying to allow alternate security models
look at NetBSD's kauth code :-)

NetBSD also had issues where some 'system call trace' code
was being used to (try to) apply security - unfortunately
it worked by looking at the user-space buffers on system
call entry - and a multithreaded program can easily arrange
to update them after the initial check!
For trace/event type activities this wouldn't really matter,
for security policy it does.
(I've not looked directly at these event points in linux)

	David
