Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Bill Fink <billfink@capu.net>,
	Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: xine, ppc and illegal instructions
Date: Sun, 1 Apr 2001 16:02:17 -0400
Cc: linuxppc-dev@lists.linuxppc.org, billfink@capu.net
References: <Pine.LNX.4.21.0104011246570.868-100000@gwiz.nasa.atd.net>
In-Reply-To: <Pine.LNX.4.21.0104011246570.868-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Message-Id: <01040116021700.15950@localhost>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

couple of  things:

- was the shared library loaded by dlopen properly built with -fPIC or -fpic?

- could there be a cache flushing bug?  When run in gdb if you set some
breakpoints in the shared library, it will flush the icache (to make sure the
breakpoint gets flushed out of data cache and any preloaded instruction are
thrown away) this in turn seems to "fix" the cache flush problem if one
exists.

- can you set ulimit -c unlimited and generate a core file from xine
  and post the resulting backtrace.

  If it looks empty, try the following:
  x/20i $lr -32
  in gdb just in case the problem was a branch out into the weeds

(if we are lucky lr will have the return address so that we can
possibly see at least where the bad branch comes from).  One way to get
an illegal instruction is to follow a calculated branch into the weeds
(happens sometimes in some C++ code during tailcalls when compiled above -O0).

Kevin

On Sunday 01 April 2001 13:51, Bill Fink wrote:
> Some further investigation on my part and a question for Franz Sirl:
>
> I updated to the latest Paulus rsync kernel (2.4.3-pre8) and the
> latest gcc (2.95.3-2v) and 2.1 glibc (glibc-2.1.3-15g) from Franz,
> but unfortunately none of this helps.  xine 0.4.01 still gets
> illegal instructions (sometimes it gets a segmentation fault
> instead).  No core dump is produced and it runs basically OK
> when run under control of gdb, so it makes tracking down the
> problem very difficult.
>
> From debug printout, it appears that it is dying in a call to dlopen,
> which is in libdl, which is part of glibc.  Here's the tail end of an
> strace of a xine run:
>
> open("/usr/local/install/xine-0.4.01/lib/xine/plugins",
O_RDONLY|O_NONBLOCK|O_DI
> RECTORY) = 7
> fstat(7, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
> fcntl(7, F_SETFD, FD_CLOEXEC)           = 0
> lseek(7, 0, SEEK_CUR)                   = 0
> getdents(7, /* 12 entries */, 2980)     = 284
> open("/usr/local/install/xine-0.4.01/lib/xine/plugins/input_file.so",
O_RDONLY)
> = 8
> fstat(8, {st_mode=S_IFREG|0755, st_size=17054, ...}) = 0
> read(8, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\t"..., 4096)
= 409
> 6
> mmap(0xfa28000, 70000, PROT_READ|PROT_EXEC, MAP_PRIVATE, 8, 0) = 0xfa28000
> mprotect(0xfa29000, 65904, PROT_NONE)   = 0
> mmap(0xfa38000, 8192, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED, 8,
> 0) = 0xfa38000
> close(8)                                = 0
> mprotect(0xfa28000, 4096, PROT_READ|PROT_WRITE) = 0
> mprotect(0xfa28000, 4096, PROT_READ|PROT_EXEC) = 0
> --- SIGILL (Illegal instruction) ---
> +++ killed by SIGILL +++
>
> Given that the last system call was an mprotect, I searched the archives
> and discovered that Olaf Hering reported a problem with mprotect on
> January 23 on the linuxppc-dev list, see:
>
> http://lists.linuxppc.org/listarcs/linuxppc-dev/200101/msg00324.html
>
> Olaf provided a patch to fix the problem, which I wasn't totally clear
> exactly what it was against, but I'm assuming it was glibc (I've never
> looked at the glibc source).  Assuming it was a glibc patch, it wouldn't
> be in the glibc-2.1.3-15g I downloaded since that was dated January 14.
>
> Now my question for Franz.  Do you think the problem/patch reported
> by Olaf is likely related to the apparent dlopen/mprotect problem I'm
> having with the 0.4.01 version of xine (note the 0.3.7 version works
> fine)?  Or could it possibly be hardware related?  I'm running on a
> G4 which has Altivec, while Henry's system is a G3 IIRC, which I believe
> doesn't have Altivec (or some other hardware difference).
>
> I've pulled down the source for glibc-2.1.3-15g, but before I actually
> try rebuilding it on my system (with or without Olaf's patch), I'd
> appreciate some expert advice about whether it's worth the effort or
> likely to have any effect.
>
> 						-Thanks
>
> 						-Bill
>
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
