Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 4D9D5DDFDC
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 08:34:45 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: monstr@seznam.cz
Subject: Re: [PATCH 58/60] microblaze_v4: sys_microblaze.c
Date: Fri, 27 Jun 2008 00:34:23 +0200
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<200806261748.30698.arnd@arndb.de> <4863E8F2.5080608@seznam.cz>
In-Reply-To: <4863E8F2.5080608@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200806270034.24455.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 June 2008, Michal Simek wrote:
> 
> >> +
> >> +/*
> >> + * sys_ipc() is the de-multiplexer for the SysV IPC calls..
> >> + *
> >> + * This is really horribly ugly.
> >> + */
> > 
> > If it's so horribly ugly, don't do it this way ;-)
> 
> :-) this is not my part of code. I'll remove it with syscall changes.

Yes, I was aware of that. I believe the comment was initially done in
order to prevent people from copying it to new architectures, but it
never worked.

> >> +int
> >> +sys_ipc(uint call, int first, int second, int third, void *ptr, long fifth)
> >> +{
> >> +	int version, ret;
> >> +
> >> +	version = call >> 16; /* hack for backward compatibility */
> >> +	call &= 0xffff;
> > 
> > Backwards compatibility with what?
> 
> I don't know.
> John: I suppose this is your comment.

No, it was a trick question, this is also copied from i386. It was meant
for the iBCS2 compatibility layer that provides support for running
Unix binaries from the late 80s, but never quite made it into the Linux
kernel.

> >> +unsigned long sys_mmap2(unsigned long addr, size_t len,
> >> +			unsigned long prot, unsigned long flags,
> >> +			unsigned long fd, unsigned long pgoff)
> >> +{
> >> +	return do_mmap2(addr, len, prot, flags, fd, pgoff);
> >> +}
> >> +
> >> +unsigned long sys_mmap(unsigned long addr, size_t len,
> >> +			unsigned long prot, unsigned long flags,
> >> +			unsigned long fd, off_t offset)
> >> +{
> >> +	int err = -EINVAL;
> >> +
> >> +	if (offset & ~PAGE_MASK) {
> >> +		printk(KERN_INFO "no pagemask in mmap\r\n");
> >> +		goto out;
> >> +	}
> >> +
> >> +	err = do_mmap2(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
> >> +out:
> >> +	return err;
> >> +}
> > 
> > Which mmap is uClibc really using? I suppose you only need mmap2, even for
> > compatibility with any binary ever built for microblaze.
> 
> I don't know. Microblaze should be compiled with uClibc and glibc. In case you
> need mmap2 for uClibc and mmap for glibc it is ok.

I looked at uClibc again and found that you probably need both for compatibility
and functionality, same as for other calls that can take either an off_t or
a loff_t. Only if you changed the libc/sysdeps/linux/microblaze/mmap.c code,
you could get rid of sys_mmap(). I don't think you need to worry about glibc
at this point, because as I understand it the old port is broken anyway
and it's easier to do a new microblaze glibc port from scratch than trying
to update it to the latest glibc version...

	Arnd <><
