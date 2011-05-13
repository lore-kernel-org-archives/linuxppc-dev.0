Return-Path: <wad@chromium.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9E4FFB6F08
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 14 May 2011 02:29:13 +1000 (EST)
Received: by fxm5 with SMTP id 5so2085593fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 May 2011 09:29:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1305302141.2076.56.camel@localhost.localdomain>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
	<alpine.LRH.2.00.1105122133500.31507@tundra.namei.org>
	<20110512130104.GA2912@elte.hu>
	<alpine.LRH.2.00.1105131018040.3047@tundra.namei.org>
	<20110513121034.GG21022@elte.hu>
	<1305299455.2076.26.camel@localhost.localdomain>
	<1305300181.2466.72.camel@twins>
	<1305302141.2076.56.camel@localhost.localdomain>
Date: Fri, 13 May 2011 11:29:06 -0500
Message-ID: <BANLkTinDO0OSav7NgjuE4E5E-Yu2==EQwg@mail.gmail.com>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
From: Will Drewry <wad@chromium.org>
To: Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>, linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	James Morris <jmorris@namei.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, kees.cook@canonical.com,
	linux-arm-kernel@lists.infradead.org,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>,
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

On Fri, May 13, 2011 at 10:55 AM, Eric Paris <eparis@redhat.com> wrote:
> On Fri, 2011-05-13 at 17:23 +0200, Peter Zijlstra wrote:
>> On Fri, 2011-05-13 at 11:10 -0400, Eric Paris wrote:
>> > Then again, I certainly don't see a
>> > reason that this syscall hardening patch should be held up while a who=
le
>> > new concept in computer security is contemplated...
>>
>> Which makes me wonder why this syscall hardening stuff is done outside
>> of LSM? Why isn't is part of the LSM so that say SELinux can have a
>> syscall bitmask per security context?
>
> I could do that, but I like Will's approach better. =A0From the PoV of
> meeting security goals of information flow, data confidentiality,
> integrity, least priv, etc limiting on the syscall boundary doesn't make
> a lot of sense. =A0You just don't know enough there to enforce these
> things. =A0These are the types of goals that SELinux and other LSMs have
> previously tried to enforce. =A0From the PoV of making the kernel more
> resistant to attacks and making a process more resistant to misbehavior
> I think that the syscall boundary is appropriate. =A0Although I could do
> it in SELinux it don't really want to do it there.

There's also the problem that there are no hooks per-system call for
LSMs, only logical hooks that sometimes mirror system call names and
are called after user data has been parsed.  If system call enter
hooks, like seccomp's, were added for LSMs, it would allow the lsm
bitmask approach, but it still wouldn't satisfy the issues you raise
below (and I wholeheartedly agree with).

> In case people are interested or confused let me give my definition of
> two words I've used a bit in these conversations: discretionary and
> mandatory. =A0Any time I talk about a 'discretionary' security decision i=
t
> is a security decisions that a process imposed upon itself. =A0Aka the
> choice to use seccomp is discretionary. =A0The choice to mark our own fil=
e
> u-wx is discretionary. =A0This isn't the best definition but it's one tha=
t
> works well in this discussion. =A0Mandatory security is one enforce by a
> global policy. =A0It's what selinux is all about. =A0SELinux doesn't give
> hoot what a process wants to do, it enforces a global policy from the
> top down. =A0You take over a process, well, too bad, you still have no
> choice but to follow the mandatory policy.
>
> The LSM does NOT enforce a mandatory access control model, it's just how
> it's been used in the past. =A0Ingo appears to me (please correct me if
> I'm wrong) to really be a fan of exposing the flexibility of the LSM to
> a discretionary access control model. =A0That doesn't seem like a bad
> idea. =A0And maybe using the filter engine to define the language to do
> this isn't a bad idea either. =A0But I think that's a 'down the road'
> project, not something to hold up a better seccomp.
>
>> Making it part of the LSM also avoids having to add this prctl().
>
> Well, it would mean exposing some new language construct to every LSM
> (instead of a single prctl construct) and it would mean anyone wanting
> to use the interface would have to rely on the LSM implementing those
> hooks the way they need it. =A0Honestly chrome can already get all of the
> benefits of this patch (given a perfectly coded kernel) and a whole lot
> more using SELinux, but (surprise surprise) not everyone uses SELinux.
> I think it's a good idea to expose a simple interface which will be
> widely enough adopted that many userspace applications can rely on it
> for hardening.
>
> The existence of the LSM and the fact that there exists multiple
> security modules that may or may not be enabled really leads application
> developers to be unable to rely on LSM for security. =A0If linux had a
> single security model which everyone could rely on we wouldn't really
> have as big of an issue but that's not possible. =A0So I'm advocating for
> this series which will provide a single useful change which applications
> can rely upon across distros and platforms to enhance the properties and
> abilities of the linux kernel.
>
> -Eric
>
>
