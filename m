Return-Path: <acahalan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id B469867C1B
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Aug 2006 14:11:21 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id k27so2156886nfc
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 21:11:19 -0700 (PDT)
Message-ID: <787b0d920608122111p79f29d74r600382658599cd63@mail.gmail.com>
Date: Sun, 13 Aug 2006 00:11:19 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: PowerPC paxtest results w/ gcc-4.1
In-Reply-To: <17630.39716.551115.850057@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920608112250q551c98f5j328183c31eebaf77@mail.gmail.com>
	<17629.48408.564322.747132@cargo.ozlabs.ibm.com>
	<787b0d920608120736n1ba0bc03jccf2964bf7ebb1d5@mail.gmail.com>
	<17630.27174.711916.643790@cargo.ozlabs.ibm.com>
	<787b0d920608121948rad24dc7le834f1b499543ace@mail.gmail.com>
	<17630.39716.551115.850057@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/12/06, Paul Mackerras <paulus@samba.org> wrote:
> Albert Cahalan writes:
>
> > VM_STACK_DEFAULT_FLAGS32 is wrong. A fail-safe
> > default is important for security. If gcc on PowerPC ever
> > does generate code which puts trampolines on the stack,
> > then that can be fixed by converting to legal C code or
> > by adding the fragile marking to the defective executables.
> > Did gcc ever generate such code on PowerPC? If not,
> > then there is no reason to ever allow an executable stack.
>
> I believe it did for nested procedures in C.

I just disassembled libgcc. You're right. Eeeeeew.
I filed a bug describing two better methods for this.

> Now that we have the VDSO and use it for signal trampolines, we
> probably could change the default stack protections.

Heh. I though i386 was the only one to ever do that.
The obvious method is to set the return address to
be a special value which will fault, like -3.

> > No. Look in the segment registers. The granularity
> > isn't great, but the stack can be protected at least.
>
> No, ld.so tends to go just below the stack:
>
> f7fe6000-f7fff000 r-xp 00000000 08:05 17069          /lib/ld-2.3.6.so
> f800e000-f800f000 r--p 00018000 08:05 17069          /lib/ld-2.3.6.so
> f800f000-f8010000 rwxp 00019000 08:05 17069          /lib/ld-2.3.6.so
> ffe67000-ffe7c000 rw-p ffe67000 00:00 0              [stack]

That looks like a 64-bit system, which doesn't have
the granularity problem anyway. 32-bit powerpc seems
to be decent. The heap shares with the executable
itself, and of course there is the yucky 2 GB limit.

$ cat /proc/self/maps
00100000-00103000 r-xp 00100000 00:00 0
0fe8b000-0ffd4000 r-xp 00000000 03:0d 2081203    /lib/tls/libc-2.3.6.so
0ffd4000-0ffe3000 ---p 00149000 03:0d 2081203    /lib/tls/libc-2.3.6.so
0ffe3000-0ffea000 r--p 00148000 03:0d 2081203    /lib/tls/libc-2.3.6.so
0ffea000-0ffee000 rwxp 0014f000 03:0d 2081203    /lib/tls/libc-2.3.6.so
0ffee000-0fff0000 rwxp 0ffee000 00:00 0
10000000-10005000 r-xp 00000000 03:0d 1327891    /bin/cat
10014000-10015000 rwxp 00004000 03:0d 1327891    /bin/cat
10015000-10036000 rwxp 10015000 00:00 0          [heap]
30000000-30019000 r-xp 00000000 03:0d 2080939    /lib/ld-2.3.6.so
30019000-3001b000 rw-p 30019000 00:00 0
30028000-30029000 r--p 00018000 03:0d 2080939    /lib/ld-2.3.6.so
30029000-3002a000 rwxp 00019000 03:0d 2080939    /lib/ld-2.3.6.so
7fa45000-7fa5a000 rw-p 7fa45000 00:00 0          [stack]
