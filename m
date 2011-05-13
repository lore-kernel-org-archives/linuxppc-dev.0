Return-Path: <eparis@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id D3DACB6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 14 May 2011 01:18:55 +1000 (EST)
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
From: Eric Paris <eparis@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Date: Fri, 13 May 2011 11:17:52 -0400
In-Reply-To: <20110513131800.GA7883@elte.hu>
References: <alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu> <1305289146.2466.8.camel@twins>
	<20110513122646.GA3924@elte.hu> <1305290370.2466.14.camel@twins>
	<1305290612.2466.17.camel@twins> <20110513125452.GD3924@elte.hu>
	<1305292132.2466.26.camel@twins> <20110513131800.GA7883@elte.hu>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1305299880.2076.31.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>,
	Paul Mackerras <paulus@samba.org>, "H. Peter
	Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>, linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	James Morris <jmorris@namei.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, kees.cook@canonical.com,
	"Serge E. Hallyn" <serge@hallyn.com>,
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

[dropping microblaze and roland]

On Fri, 2011-05-13 at 15:18 +0200, Ingo Molnar wrote:
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, 2011-05-13 at 14:54 +0200, Ingo Molnar wrote:
> > > I think the sanest semantics is to run all active callbacks as well.
> > > 
> > > For example if this is used for three stacked security policies - as if 3 LSM 
> > > modules were stacked at once. We'd call all three, and we'd determine that at 
> > > least one failed - and we'd return a failure. 
> > 
> > But that only works for boolean functions where you can return the
> > multi-bit-or of the result. What if you need to return the specific
> > error code.
> 
> Do you mean that one filter returns -EINVAL while the other -EACCES?
> 
> Seems like a non-problem to me, we'd return the first nonzero value.

Sounds so easy!  Why haven't LSMs stacked already?  Because what happens
if one of these hooks did something stateful?  Lets say on open, hook #1
returns EPERM.  hook #2 allocates memory.  The open is going to fail and
hooks #2 is never going to get the close() which should have freed the
allocation.  If you can be completely stateless its easier, but there's
a reason that stacking security modules is hard.  Serge has tried in the
past and both dhowells and casey schaufler are working on it right now.
Stacking is never as easy as it sounds   :)

-Eric
