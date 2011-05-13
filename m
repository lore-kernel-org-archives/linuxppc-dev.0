Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 27A641007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 May 2011 22:11:33 +1000 (EST)
Date: Fri, 13 May 2011 14:10:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
Message-ID: <20110513121034.GG21022@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Eric Paris <eparis@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	sparclinux@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
	linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	linux-arm-kernel@lists.infradead.org, kees.cook@canonical.com,
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


* James Morris <jmorris@namei.org> wrote:

> On Thu, 12 May 2011, Ingo Molnar wrote:
> > Funnily enough, back then you wrote this:
> > 
> >   " I'm concerned that we're seeing yet another security scheme being designed on 
> >     the fly, without a well-formed threat model, and without taking into account 
> >     lessons learned from the seemingly endless parade of similar, failed schemes. "
> > 
> > so when and how did your opinion of this scheme turn from it being an 
> > "endless parade of failed schemes" to it being a "well-defined and readily 
> > understandable feature"? :-)
> 
> When it was defined in a way which limited its purpose to reducing the attack 
> surface of the sycall interface.

Let me outline a simple example of a new filter expression based security 
feature that could be implemented outside the narrow system call boundary you 
find acceptable, and please tell what is bad about it.

Say i'm a user-space sandbox developer who wants to enforce that sandboxed code 
should only be allowed to open files in /home/sandbox/, /lib/ and /usr/lib/.

It is a simple and sensible security feature, agreed? It allows most code to 
run well and link to countless libraries - but no access to other files is 
allowed.

I would also like my sandbox app to be able to install this policy without 
having to be root. I do not want the sandbox app to have permission to create 
labels on /lib and /usr/lib and what not.

Firstly, using the filter code i deny the various link creation syscalls so 
that sandboxed code cannot escape for example by creating a symlink to outside 
the permitted VFS namespace. (Note: we opt-in to syscalls, that way new 
syscalls added by new kernels are denied by defalt. The current symlink 
creation syscalls are not opted in to.)

But the next step, actually checking filenames, poses a big hurdle: i cannot 
implement the filename checking at the sys_open() syscall level in a secure 
way: because the pathname is passed to sys_open() by pointer, and if i check it 
at the generic sys_open() syscall level, another thread in the sandbox might 
modify the underlying filename *after* i've checked it.

But if i had a VFS event at the fs/namei.c::getname() level, i would have 
access to a central point where the VFS string becomes stable to the kernel and 
can be checked (and denied if necessary).

A sidenote, and not surprisingly, the audit subsystem already has an event 
callback there:

        audit_getname(result);

Unfortunately this audit callback cannot be used for my purposes, because the 
event is single-purpose for auditd and because it allows no feedback (no 
deny/accept discretion for the security policy).

But if had this simple event there:

	err = event_vfs_getname(result);

I could implement this new filename based sandboxing policy, using a filter 
like this installed on the vfs::getname event and inherited by all sandboxed 
tasks (which cannot uninstall the filter, obviously):

  "
	if (strstr(name, ".."))
		return -EACCESS;

	if (!strncmp(name, "/home/sandbox/", 14) &&
	    !strncmp(name, "/lib/", 5) &&
	    !strncmp(name, "/usr/lib/", 9))
		return -EACCESS;

  "

  #
  # Note1: Obviously the filter engine would be extended to allow such simple string
  #        match functions. )
  #
  # Note2: ".." is disallowed so that sandboxed code cannot escape the restrictions
  #         using "/..".
  #

This kind of flexible and dynamic sandboxing would allow a wide range of file 
ops within the sandbox, while still isolating it from files not included in the 
specified VFS namespace.

( Note that there are tons of other examples as well, for useful security features
  that are best done using events outside the syscall boundary. )

The security event filters code tied to seccomp and syscalls at the moment is 
useful, but limited in its future potential.

So i argue that it should go slightly further and should become:

 - unprivileged:  application-definable, allowing the embedding of security 
                  policy in *apps* as well, not just the system

 - flexible:      can be added/removed runtime unprivileged, and cheaply so

 - transparent:   does not impact executing code that meets the policy

 - nestable:      it is inherited by child tasks and is fundamentally stackable,
                  multiple policies will have the combined effect and they
                  are transparent to each other. So if a child task within a
                  sandbox adds *more* checks then those add to the already
                  existing set of checks. We only narrow permissions, never
                  extend them.

 - generic:       allowing observation and (safe) control of security relevant
                  parameters not just at the system call boundary but at other
                  relevant places of kernel execution as well: which 
                  points/callbacks could also be used for other types of event 
                  extraction such as perf. It could even be shared with audit ...

I argue that this is the LSM and audit subsystems designed right: in the long 
run it could allow everything that LSM does at the moment - and so much more 
...

And you argue that allowing this would be bad, if it was extended like that 
then you'd consider it a failed scheme? Why?

Thanks,

	Ingo
