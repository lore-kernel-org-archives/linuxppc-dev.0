Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 32E00B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 May 2011 22:40:13 +1000 (EST)
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20110513122646.GA3924@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu> <1305289146.2466.8.camel@twins>
	<20110513122646.GA3924@elte.hu>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 13 May 2011 14:39:30 +0200
Message-ID: <1305290370.2466.14.camel@twins>
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Eric Paris <eparis@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	sparclinux@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
	linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	James Morris <jmorris@namei.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	linux-arm-kernel@lists.infradead.org, kees.cook@canonical.com,
	"Serge E. Hallyn" <serge@hallyn.com>, microblaze-uclinux@itee.uq.edu.au,
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

On Fri, 2011-05-13 at 14:26 +0200, Ingo Molnar wrote:
> * Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> > On Fri, 2011-05-13 at 14:10 +0200, Ingo Molnar wrote:
> > >         err =3D event_vfs_getname(result);
> >=20
> > I really think we should not do this. Events like we have them should b=
e=20
> > inactive, totally passive entities, only observe but not affect executi=
on=20
> > (other than the bare minimal time delay introduced by observance).
>=20
> Well, this patchset already demonstrates that we can use a single event=
=20
> callback for a rather useful purpose.

Can and should are two distinct things.

> Either it makes sense to do, in which case we should share facilities as =
much=20
> as possible, or it makes no sense, in which case we should not merge it a=
t all.

And I'm arguing we should _not_. Observing is radically different from
Affecting, at the very least the two things should have different
permission schemes. We should not confuse these two matters.

> > If you want another entity that is more active, please invent a new nam=
e for=20
> > it and create a new subsystem for them, now you could have these active=
=20
> > entities also have an (automatic) passive event side, but that's some d=
etail.
>=20
> Why should we have two callbacks next to each other:
>=20
> 	event_vfs_getname(result);
> 	result =3D check_event_vfs_getname(result);
>=20
> if one could do it all?

Did you actually read the bit where I said that check_event_* (although
I still think that name sucks) could imply a matching event_*?
