Return-Path: <kees.cook@canonical.com>
Received: from smtp.outflux.net (smtp.outflux.net [198.145.64.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.outflux.net",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EFF1BB6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 19:37:23 +1000 (EST)
Date: Thu, 12 May 2011 02:24:24 -0700
From: Kees Cook <kees.cook@canonical.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
Message-ID: <20110512092424.GO28888@outflux.net>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110512074850.GA9937@elte.hu>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Eric Paris <eparis@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	sparclinux@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
	linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org, jmorris@namei.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, microblaze-uclinux@itee.uq.edu.au,
	Steven Rostedt <rostedt@goodmis.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Roland McGrath <roland@redhat.com>,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	Will Drewry <wad@chromium.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Paul Mundt <lethal@linux-sh.org>, Tejun Heo <tj@kernel.org>,
	linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
	agl@chromium.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Thu, May 12, 2011 at 09:48:50AM +0200, Ingo Molnar wrote:
> 1) We already have a specific ABI for this: you can set filters for events via 
>    an event fd.
> 
>    Why not extend that mechanism instead and improve *both* your sandboxing
>    bits and the events code? This new seccomp code has a lot more
>    to do with trace event filters than the minimal old seccomp code ...

Would this require privileges to get the event fd to start with? If so,
I would prefer to avoid that, since using prctl() as shown in the patch
set won't require any privs.

-Kees

-- 
Kees Cook
Ubuntu Security Team
