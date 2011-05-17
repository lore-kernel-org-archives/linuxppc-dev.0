Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 22360B6EEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 May 2011 23:11:34 +1000 (EST)
Date: Tue, 17 May 2011 15:10:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
Message-ID: <20110517131058.GE21441@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu>
	<alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
	<20110516150837.GA513@elte.hu>
	<alpine.LRH.2.00.1105171214330.31710@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.00.1105171214330.31710@tundra.namei.org>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Eric Paris <eparis@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	sparclinux@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
	linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, kees.cook@canonical.com,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	Will Drewry <wad@chromium.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Paul Mundt <lethal@linux-sh.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>, agl@chromium.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* James Morris <jmorris@namei.org> wrote:

> On Mon, 16 May 2011, Ingo Molnar wrote:
> 
> > > Not really.
> > > 
> > > Firstly, what is the security goal of these restrictions? [...]
> > 
> > To do what i described above? Namely:
> > 
> >  " Sandboxed code should only be allowed to open files in /home/sandbox/, /lib/
> >    and /usr/lib/ "
> 
> These are access rules, they don't really describe a high-level security 
> goal. [...]

Restrictng sandboxed code to only open files within a given VFS namespace 
boundary sure sounds like a high-level security goal to me.

If implemented and set up correctly then it restricts sandboxed code to only be 
able to open files reachable via that VFS sub-namespace.

That is a rather meaningful high-level concept. What higher level concept do 
you want to argue?

> [...]  How do you know it's ok to open everything in these directories?

How do you know it's ok to open /etc/hosts? The sysadmin has configured the 
system that way.

How do you know that it's ok for sandboxed code to open files in 
/home/sandbox/? The sandbox developer has configured the system that way.

I'm not sure i get your point.

Thanks,

	Ingo
