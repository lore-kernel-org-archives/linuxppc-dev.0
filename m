Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id DA662DDF00
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 17:24:08 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: joakim.tjernlund@transmode.se
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
Date: Mon, 1 Sep 2008 09:23:28 +0200
References: <200808251131.02071.david.jander@protonic.nl>
	<200808291348.27652.david.jander@protonic.nl>
	<1220012433.5234.162.camel@gentoo-jocke.transmode.se>
In-Reply-To: <1220012433.5234.162.camel@gentoo-jocke.transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200809010923.28616.david.jander@protonic.nl>
Cc: munroesj@us.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 29 August 2008 14:20:33 Joakim Tjernlund wrote:
>[...]
> > The problem is: I have very little experience with powerpc assembly and
> > only very limited time to dedicate to this and I am looking for others
> > who have
>
> I improved the PowerPC memcpy and friends in uClibc a while ago. It does
> basically the same a the kernel memcpy but without any cache
> instructions. It is written in C, but in such a way that
> optimal assembly is generated.

Hmm, isn't that going to break on a different version of gcc?
I just copied the latest version of trunk/uClibc/libc/string/powerpc/memcpy.c 
from subversion as uclibc-memcpy.c, removed the last line and did this:

$ gcc -shared -O2 -Wall -o libucmemcpy.so uclibc-memcpy.c

(should I use other compiler options?)

Then I started my test program with LD_PRELOAD=...

My test program only copies big chunks of aligned memory, so it will only test 
for maximum throughput (such as copying video frames). I will make a better 
one, to measure throughput on different sized blocks of aligned and unaligned 
memory, but first I want to find out why I can't seem to get even close to 
the expected RAM bandwidth (bursts occur at 1.6 Gbyte/s, sustained transfers 
might be able to reach 400 Mbyte/s in theory, taking into account the video 
controller eating almost half of it, I'd like to get somewhere close to 200).

The result is quite a bit better than that of glibc-2.7 (13.2 Mbyte/s --> 22 
Mbyte/s), but still far from the 71.5 Mbyte/s achieved when using bigger 
strides of 16 registers load/store at a time.
Note, that this is copy performance, one-way througput should be double these 
figures.

I'll try to learn how cache manipulating instructions work, to see if I can 
gain some more bandwith using them.

Regards,

-- 
David Jander
