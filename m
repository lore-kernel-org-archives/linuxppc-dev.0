Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (ksp.mff.cuni.cz [195.113.26.206])
	by ozlabs.org (Postfix) with ESMTP id 80BFBB6FA6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 May 2011 16:33:52 +1000 (EST)
Date: Thu, 26 May 2011 06:27:52 +0000
From: Pavel Machek <pavel@ucw.cz>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
Message-ID: <20110526062752.GA14622@localhost.ucw.cz>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu>
	<alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.00.1105161006340.21749@tundra.namei.org>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>, linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	agl@chromium.org, Ingo Molnar <mingo@redhat.com>,
	Ingo Molnar <mingo@elte.hu>, "Serge E. Hallyn" <serge@hallyn.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Steven Rostedt <rostedt@goodmis.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, kees.cook@canonical.com,
	linux-arm-kernel@lists.infradead.org,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	Will Drewry <wad@chromium.org>, linuxppc-dev@lists.ozlabs.org,
	Oleg Nesterov <oleg@redhat.com>, Eric Paris <eparis@redhat.com>,
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

  On Mon 2011-05-16 10:36:05, James Morris wrote:
> On Fri, 13 May 2011, Ingo Molnar wrote:
> How do you reason about the behavior of the system as a whole?
> 
> 
> > I argue that this is the LSM and audit subsystems designed right: in the long 
> > run it could allow everything that LSM does at the moment - and so much more 
> > ...
> 
> Now you're proposing a redesign of the security subsystem.  That's a 
> significant undertaking.
> 
> In the meantime, we have a simple, well-defined enhancement to seccomp 
> which will be very useful to current users in reducing their kernel attack 
> surface.

Well, you can do the same with subterfugue, even without kernel
changes. But that's ptrace -- slow. (And it already shows that syscall
based filters are extremely tricky to configure).

If yu want speed, seccomp+server for non-permitted operations seems like reasonable way.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
