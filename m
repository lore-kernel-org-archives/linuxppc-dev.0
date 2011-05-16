Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F895B6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 16 May 2011 22:01:40 +1000 (EST)
Date: Mon, 16 May 2011 14:00:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
Message-ID: <20110516120043.GA7128@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<201105132135.34741.arnd@arndb.de>
	<BANLkTinukLesDoXzXKdtdRwgHtJkthXK0A@mail.gmail.com>
	<201105150842.07816.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201105150842.07816.arnd@arndb.de>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>, linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	jmorris@namei.org, Ingo Molnar <mingo@redhat.com>,
	Roland McGrath <roland@redhat.com>, kees.cook@canonical.com,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, microblaze-uclinux@itee.uq.edu.au,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	Will Drewry <wad@chromium.org>, agl@chromium.org,
	linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>,
	Paul Mundt <lethal@linux-sh.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Arnd Bergmann <arnd@arndb.de> wrote:

> On Saturday 14 May 2011, Will Drewry wrote:
> > Depending on integration, it could even be limited to ioctl commands
> > that are appropriate to a known fd if the fd is opened prior to
> > entering seccomp mode 2. Alternatively, __NR__ioctl could be allowed
> > with a filter of "1" then narrowed through a later addition of
> > something like "(fd == %u && (cmd == %u || cmd == %u))" or something
> > along those lines.
> > 
> > Does that make sense?
> 
> Thanks for the explanation. This sounds like it's already doing all
> we need.

One thing we could do more clearly here is to help keep the filter expressions 
symbolic - i.e. help resolve the various ioctl variants as well, not just the 
raw syscall parameter numbers.

But yes, access to the raw syscall parameters and the ability to filter them 
already gives us the ability to exclude/include specific ioctls in a rather 
flexible way.

Thanks,

	Ingo
