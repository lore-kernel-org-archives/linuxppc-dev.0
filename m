Return-Path: <acahalan@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.239])
	by ozlabs.org (Postfix) with ESMTP id B7BB467BA6
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 03:48:38 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 57so190472wri
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Aug 2006 10:48:36 -0700 (PDT)
Message-ID: <787b0d920608201048h29cb98cevbdc81a2ce0ef751d@mail.gmail.com>
Date: Sun, 20 Aug 2006 13:48:36 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH] no-execute -- please test
In-Reply-To: <17631.62819.24167.555967@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920608132020q4ad2b5c2y49e25ca7ecc33536@mail.gmail.com>
	<17631.62819.24167.555967@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/14/06, Paul Mackerras <paulus@samba.org> wrote:
> Albert Cahalan writes:
>
> > This kernel patch implements no-execute protection (like x86 "NX bit")
> > for the Mac G2, Mac G3, Mac G4, and other systems running 32-bit
> > PowerPC processors in the 6xx, 7xx, and 7xxx families.
>
> I'd be interested in benchmark comparisons with/without this patch, if
> anyone cares to run lmbench, kernbench etc. with and without...  If
> the performance impact is minimal I'll be happy to apply it.  If the
> impact is noticeable then it might need to be selectable with a config
> option.

With no special effort at optimization, the patch appears to be harmless.
Actually most things are a tad faster, which is entirely illogical.
I must have gotten lucky with the cache.

Note that lmbench sucks. It won't compile out of the box. The Debian
package is unavailable for PowerPC, and anyway places files in all
sorts of unusual and annoying root-only locations. One of the tests
gets SIGSEGV while trying to do Sun RPC. The nice summary report
contains no data. I did find the raw results after digging around in
various directories though.

Before:

Simple syscall: 0.3180 microseconds
Simple read: 1.1413 microseconds
Simple write: 1.0040 microseconds
Simple stat: 5.5255 microseconds
Simple fstat: 1.6198 microseconds
Simple open/close: 8.3318 microseconds
Select on 10 fd's: 2.3284 microseconds
Select on 100 fd's: 18.2500 microseconds
Select on 250 fd's: 45.2063 microseconds
Select on 500 fd's: 89.6290 microseconds
Select on 10 tcp fd's: 2.6409 microseconds
Select on 100 tcp fd's: 31.1889 microseconds
Select on 250 tcp fd's: 79.1831 microseconds
Select on 500 tcp fd's: 160.2571 microseconds
Signal handler installation: 1.5846 microseconds
Signal handler overhead: 7.8899 microseconds
Protection fault: 0.7714 microseconds
Pipe latency: 24.4466 microseconds
AF_UNIX sock stream latency: 34.4834 microseconds
Process fork+exit: 671.3750 microseconds
Process fork+execve: 2417.0000 microseconds
Process fork+/bin/sh -c: 10904.0000 microseconds
File /tmp/XXX write bandwidth: 25636 KB/sec
Pagefaults on /tmp/XXX: 3.9404 microseconds

After:

Simple syscall: 0.3179 microseconds
Simple read: 1.1355 microseconds
Simple write: 0.9964 microseconds
Simple stat: 5.5497 microseconds
Simple fstat: 1.6473 microseconds
Simple open/close: 8.0965 microseconds
Select on 10 fd's: 2.3278 microseconds
Select on 100 fd's: 18.0789 microseconds
Select on 250 fd's: 44.1440 microseconds
Select on 500 fd's: 88.1935 microseconds
Select on 10 tcp fd's: 2.6399 microseconds
Select on 100 tcp fd's: 30.8939 microseconds
Select on 250 tcp fd's: 77.5070 microseconds
Select on 500 tcp fd's: 156.3438 microseconds
Signal handler installation: 1.5741 microseconds
Signal handler overhead: 7.8997 microseconds
Protection fault: 0.8085 microseconds
Pipe latency: 24.2050 microseconds
AF_UNIX sock stream latency: 33.7037 microseconds
Process fork+exit: 656.6250 microseconds
Process fork+execve: 2392.3333 microseconds
Process fork+/bin/sh -c: 10454.0000 microseconds
File /tmp/XXX write bandwidth: 25911 KB/sec
Pagefaults on /tmp/XXX: 3.6414 microseconds

Right now I have the code doing printk() rather than killing processes
that misbehave, and I'm doing something about the heap too. It seems
that GNOME things like to execute the heap, while non-GNOME things
do not. Perhaps libORBit is at fault. Things that execute the heap
include:

abiword
firefox-bin
gedit
gimp
gnome-panel
gnome-settings-
gnome-vfs-daemo
metacity
x-session-manag

Apps that behave well include xterm, xcalc, and xli.

I haven't found anything unusual in the ELF section flags. Both libORBit
and libX11 (which is fine) have flags like this:

[ 7] .rela.plt RELA   000138e4 0138e4 001824 12 A   2 23 4
[22] .sbss     NOBITS 000f2f34 0e2f34 000140  0 WA  0  0 4
[23] .plt      NOBITS 000f3074 0e2f34 00186c  0 WAX 0  0 4
[24] .bss      NOBITS 000f48e0 0e2f34 000328  0 WA  0  0 4

Firefox is less than a month old. It's newer than xterm.
