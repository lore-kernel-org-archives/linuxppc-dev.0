Return-Path: <wad@chromium.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AA22DB6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 15 May 2011 06:58:06 +1000 (EST)
Received: by fxm5 with SMTP id 5so2652276fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 14 May 2011 13:58:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201105132135.34741.arnd@arndb.de>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<201105132135.34741.arnd@arndb.de>
Date: Sat, 14 May 2011 15:58:00 -0500
Message-ID: <BANLkTinukLesDoXzXKdtdRwgHtJkthXK0A@mail.gmail.com>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
From: Will Drewry <wad@chromium.org>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
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
	Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, microblaze-uclinux@itee.uq.edu.au,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, kees.cook@canonical.com,
	linux-arm-kernel@lists.infradead.org,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	agl@chromium.org, linux-kernel@vger.kernel.org,
	Eric Paris <eparis@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
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

On Fri, May 13, 2011 at 2:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 12 May 2011, Will Drewry wrote:
>> This change adds a new seccomp mode based on the work by
>> agl@chromium.org in [1]. This new mode, "filter mode", provides a hash
>> table of seccomp_filter objects. =A0When in the new mode (2), all system
>> calls are checked against the filters - first by system call number,
>> then by a filter string. =A0If an entry exists for a given system call a=
nd
>> all filter predicates evaluate to true, then the task may proceed.
>> Otherwise, the task is killed (as per seccomp_mode =3D=3D 1).
>
> I've got a question about this: Do you expect the typical usage to disall=
ow
> ioctl()? Given that ioctl alone is responsible for a huge number of explo=
its
> in various drivers, while certain ioctls are immensely useful (FIONREAD,
> FIOASYNC, ...), do you expect to extend the mechanism to filter specific
> ioctl commands in the future?

In many cases, I do expect ioctl's to be dropped, but it's totally up
to whoever is setting the filters.

As is, it can already help out: [even though an LSM, if available,
would be appropriate to define a fine-grained policy]

ioctl() is hooked by the ftrace syscalls infrastructure (via SYSCALL_DEFINE=
3):

  SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned
long, arg)

This means you can do:
  sprintf(filter, "cmd =3D=3D %u || cmd =3D=3D %u", FIOASYNC, FIONREAD);
  prctl(PR_SET_SECCOMP_FILTER, __NR_ioctl, filter);
  ...
  prctl(PR_SET_SECCOMP, 2, 0);
and then you'll be able to call ioctl on any fd with any argument but
limited to only the FIOASYNC and FIONREAD commands.

Depending on integration, it could even be limited to ioctl commands
that are appropriate to a known fd if the fd is opened prior to
entering seccomp mode 2. Alternatively, __NR__ioctl could be allowed
with a filter of "1" then narrowed through a later addition of
something like "(fd =3D=3D %u && (cmd =3D=3D %u || cmd =3D=3D %u))" or some=
thing
along those lines.

Does that make sense?

In general, this interface won't need specific extensions for most
system call oriented filtering events.  ftrace events may be expanded
(to include more system calls), but that's behind the scenes.  Only
arguments subject to time-of-check-time-of-use attacks (data living in
userspace passed in by pointer) are not safe to use via this
interface.  In theory, that limitation could also be lifted in the
implementation without changing the ABI.

Thanks!
will
