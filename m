Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17D76B6EE6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 May 2011 02:53:46 +1000 (EST)
Date: Mon, 16 May 2011 18:52:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
Message-ID: <20110516165249.GB10929@elte.hu>
References: <1305289146.2466.8.camel@twins> <20110513122646.GA3924@elte.hu>
	<1305290370.2466.14.camel@twins> <1305290612.2466.17.camel@twins>
	<20110513125452.GD3924@elte.hu> <1305292132.2466.26.camel@twins>
	<20110513131800.GA7883@elte.hu> <1305294935.2466.64.camel@twins>
	<20110513145737.GC32688@elte.hu>
	<1305563026.5456.19.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305563026.5456.19.camel@gandalf.stny.rr.com>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>, linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	James Morris <jmorris@namei.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	kees.cook@canonical.com, "Serge E. Hallyn" <serge@hallyn.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Roland McGrath <roland@redhat.com>,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	Will Drewry <wad@chromium.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>,
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> I'm a bit nervous about the 'active' role of (trace_)events, because of the 
> way multiple callbacks can be registered. How would:
> 
> 	err = event_x();
> 	if (err == -EACCESS) {
> 
> be handled? [...]

The default behavior would be something obvious: to trigger all callbacks and 
use the first non-zero return value.

> [...] Would we need a way to prioritize which call back gets the return 
> value? One way I guess would be to add a check_event option, where you pass 
> in an ENUM of the event you want:
> 
> 	event_x();
> 	err = check_event_x(MYEVENT);
> 
> If something registered itself as "MYEVENT" to event_x, then you get the 
> return code of MYEVENT. If the MYEVENT was not registered, a -ENODEV or 
> something could be returned. I'm sure we could even optimize it such a way if 
> no active events have been registered to event_x, that check_event_x() will 
> return -ENODEV without any branches.

I would keep it simple and extensible - that way we can complicate it when the 
need arises! :)

Thanks,

	Ingo
