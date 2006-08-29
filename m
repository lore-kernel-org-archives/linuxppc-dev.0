Return-Path: <tliang@yahoo.com>
Received: from web36110.mail.mud.yahoo.com (web36110.mail.mud.yahoo.com
	[66.163.179.224]) by ozlabs.org (Postfix) with SMTP id A6E7A67B56
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 10:43:38 +1000 (EST)
Message-ID: <20060829004336.97699.qmail@web36110.mail.mud.yahoo.com>
Date: Mon, 28 Aug 2006 17:43:36 -0700 (PDT)
From: Xupei Liang <tliang@yahoo.com>
Subject: RE: atomic operations in user space
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I think it is less expensive using atomic operation
sometimes in the user space, e.g. when updating a
counter. If this counter is to be updated by a lot of
processes, using semaphore can potentially cause a lot
of task switching. 

Regards,

Terry Liang


> -----Original Message-----
> From: Brent Cook [mailto:bcook at bpointsys.com]
> Sent: Thursday, August 24, 2006 10:18 PM
> To: linuxppc-embedded at ozlabs.org
> Cc: Li Yang-r58472; Terry Liang
> Subject: Re: atomic operations in user space
> 
> On Thursday 24 August 2006 05:39, Li Yang-r58472
wrote:
> 
> > Why do you need atomic operations in user land?
IPC will be
sufficient
> 
> > to deal with race conditions between processes.
> 
> >
> 
> > Best Regards,
> 
> > Leo
> 
> What about multiple threads within a process
updating a counter?

Is there anything preventing semaphore to be used in
threads?
> 
> Of course, if you look at these functions in the
kernel header,
they're just 2 or
> 3 inline assembly calls - you could easily rewrite
them. Google for
'PowerPC atomic
> increment' and grab one of the unencumbered
implementations if you
need to use it
> in a non-GPL program.
> 
> On the other hand, I see no license at the top of my
/usr/include/asm-i386/atomic.h
> file at all, same for PowerPC - are Linux header
files actually GPL or
are they
> more like the glibc headers, with exceptions made
for userspace
programs?
> 
> The atomic operations on x86 were accidentally
exported early on, so
they have to
> hang around apparently for compatibility (there are
some mailing list
threads out
> there to this effect.) Currently, you just have to
assume in Linux
that if you
> include something from /usr/include/linux or asm
that it will not
necessarily be
> cross-version or cross-architecture compatible. Not
every arch in
Linux even has
> atomic operations of this nature, which I guess is
the main reason why
they are
> not exported in general.
> 
> - Brent



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
