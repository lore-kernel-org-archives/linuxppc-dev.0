Return-Path: <acahalan@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id E802AB7D68
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Jun 2010 22:01:48 +1000 (EST)
Received: by vws8 with SMTP id 8so2548143vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 05 Jun 2010 05:01:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100602013839.GB17579@us.ibm.com>
References: <AANLkTimDfbJkAuoK1-asvk8Ub9C9QBkK5RkzLR3ilJUY@mail.gmail.com>
	<20100601193230.GA17579@us.ibm.com>
	<AANLkTinxCKl7RVe62UhIpNe5EriCufkgaih2D2mLLmC4@mail.gmail.com>
	<20100602013839.GB17579@us.ibm.com>
Date: Sat, 5 Jun 2010 07:58:45 -0400
Message-ID: <AANLkTilcyaHmhKPsAXOdbrxFfxDeAc97AvuB_WX8VA7b@mail.gmail.com>
Subject: Re: [PATCH v21 011/100] eclone (11/11): Document sys_eclone
From: Albert Cahalan <acahalan@gmail.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: randy.dunlap@oracle.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 1, 2010 at 9:38 PM, Sukadev Bhattiprolu
<sukadev@linux.vnet.ibm.com> wrote:
> | Come on, seriously, you know it's ia64 and hppa that
> | have issues. Maybe the nommu ports also have issues.
> |
> | The only portable way to specify the stack is base and offset,
> | with flags or magic values for "share" and "kernel managed".
>
> Ah, ok, we have not yet ported to IA64 and I see now where the #ifdef
> comes in.
>
> But are you saying that we should force x86 and other architectures to
> specify base and offset for eclone() even though they currently specify
> just the stack pointer to clone() ?

Even for x86, it's an easier API. Callers would be specifying
two numbers they already have: the argument and return value
for malloc. Currently the numbers must be added together,
destroying information, except on hppa (must not add size)
and ia64 (must use what I'm proposing already).

This also provides the opportunity for the kernel (perhaps not
in the initial implementation) to have a bit of extra info about
some processes. The info could be supplied to gdb, used to
harden the system against some types of security exploits,
presented in /proc, and so on.

> That would remove the ifdef, but could be a big change to applications
> on x86 and other architectures.

It's no change at all until somebody decides to use the new
system call. At that point, you're making changes anyway.
It's certainly not a big change compared to eclone() itself.

> | > I don't understand how "making up some numbers (pids) that will work"
> | > is more portable/cleaner than the proposed eclone().
> |
> | It isolates the cross-platform problems to an obscure tool
> | instead of polluting the kernel interface that everybody uses.
>
> Sure, there was talk about using an approach like /proc/<pid>/next_pid
> where you write your target pid into the file and the next time you
> fork() you get that target pid. But it was considered racy and ugly.

Oh, you misunderstood what I meant by making up numbers
and I didn't catch it. I wasn't meaning PID numbers. I was meaning
stack numbers for processes that your strange tool is restarting.

You ignored my long-ago request to use base/size to specify
the stack. My guess was that this was because you're focused
on restarting processes, many of which will lack stack base info.
I thus suggested that you handle this obscure legacy case by
making up some reasonable numbers.

For example, suppose a process allocates 0x40000000 to
0x7fffffff (a 1 GiB chunk) and uses 0x50000000 to 0x5fffffff as
a thread stack. If done using the old clone() syscall on i386,
you're only told that 0x5fffffff is the last stack address. You
know nothing of 0x50000000. Your tool can see the size and
base of the whole mapping though, so 0x40000000...0x5fffffff
is a reasonable place to assume the stack lives. You therefore
call eclone with base=0x40000000 size=0x2000000 when
restarting the process.

For everybody NOT writing an obscure tool to restart processes,
my requested change eliminates #ifdef mess and/or needless
failure to support some architectures.

Right now user code must be like this:

base=malloc(size);
#if defined(__hppa__)
tid=clone(fn,base,flags,arg);
#elif defined(__ia64__)
tid=clone2(fn,base,size,flags,arg);
#else
tid=clone(fn,base+size,flags,arg);
#endif

The man page is likewise messy.

Note that if clone2 were available for all architectures,
we wouldn't have this mess. Let's not perpetuate the
mistakes that led to the mess. Please provide an API
that, like clone2, uses base and size. It'll work for every
architecture. It'll even be less trouble to document.
