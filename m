Date: Tue, 23 Jan 2001 14:03:48 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: mprotect broken on ppc
Message-ID: <20010123140348.A1745@suse.de>
References: <20010120221908.A20689@suse.de> <20010120222630.B20689@suse.de> <20010121183031.A25128@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010121183031.A25128@suse.de>; from olh@suse.de on Sun, Jan 21, 2001 at 06:30:31PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 21, Olaf Hering wrote:

>
> On Sat, Jan 20, Olaf Hering wrote:
>
> >
> > On Sat, Jan 20, Olaf Hering wrote:
> >
> > >
> > > Hi,
> > >
> > > there seems to be a bug in mprotect which was introduced in
> > > test9->test10.
> > >
> > > The result is an invalid pointer from the getpwuid(3) function, this
> > > function is used in rpm to check owner and group permissions.
> >
> > forgot some facts:
> >
> > the build host runs always a glibc2.13 system with 2.2 headers. The
> > build chroot runs a glibc2.2 system with 2.4.0ac2 headers.
> > And it fails when a kernel 2.4.0-test10 or later is running, every other
> > kernel works fine.
>
> I put some debug in mm/mprotect.c:
> ...
> asmlinkage long sys_mprotect(unsigned long start, size_t len, unsigned
> long prot)
> {
>         unsigned long nstart, end, tmp;
>         struct vm_area_struct * vma, * next;
>         int error = -EINVAL;
>
>         if (start & ~PAGE_MASK) {
>                 printk("sys_mprotect start \n");
>                 return -EINVAL;
>         }
> ...
>
> it fails here.
> Jan 21 18:28:06 mandarine kernel: sys_mprotect start

sys_mprotect start= 6ffdffb0,PAGE_MASK= fffff000


It was solved with this patch:
http://penguinppc.org/~olaf/broken_build/elf.diff


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
