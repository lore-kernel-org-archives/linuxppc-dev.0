Return-Path: <sam.bobroff@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEEB81A046F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 09:37:41 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6F30F140F8E
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2015 09:37:41 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Thu, 15 Oct 2015 08:37:40 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B87403578053
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2015 09:37:36 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9EMbS6o46530684
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2015 09:37:36 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9EMb4NQ006959
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2015 09:37:04 +1100
Date: Thu, 15 Oct 2015 09:36:29 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, anton@samba.org
Subject: Re: [v2,1/1] powerpc: Individual System V IPC system calls
Message-ID: <20151014223629.GB1900@tungsten.ozlabs.ibm.com>
References: <a3cfb270cd61cc3aacdf929e7739ae46dcff86bd.1444700960.git.sam.bobroff@au1.ibm.com>
 <20151013093842.B3EA21402D6@ozlabs.org>
 <20151014070029.GA8383@tungsten.ozlabs.ibm.com>
 <1444815495.1843.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444815495.1843.3.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 14, 2015 at 08:38:15PM +1100, Michael Ellerman wrote:
> On Wed, 2015-10-14 at 18:00 +1100, Sam Bobroff wrote:
> > On Tue, Oct 13, 2015 at 08:38:42PM +1100, Michael Ellerman wrote:
> > > On Tue, 2015-13-10 at 01:49:28 UTC, Sam bobroff wrote:
> > > > This patch provides individual system call numbers for the following
> > > > System V IPC system calls, on PowerPC, so that they do not need to be
> > > > multiplexed:
> > > > * semop, semget, semctl, semtimedop
> > > > * msgsnd, msgrcv, msgget, msgctl
> > > > * shmat, shmdt, shmget, shmctl
> > > 
> > > You tested this right? :)  Tell me about it.
> > 
> > Why yes I did:
> 
> ...
> 
> > (I also re-ran the tests both for little-endian and big-endian hosts.)
> 
> Did you test on 32-bit at all?

I ran the test program, compiled for 32 and 64 bit, on a biarch power7 machine
(using -m32 and -m64 to the compiler) but only to verify that the fully patched
system succeeded. Is that sufficient?

> > It would obviously be good to have someone else test this, but I can't see a
> > way to make it easy to do. They would presumably have to go through all of the
> > above, which seems too much to ask given how trivial the kernel side of the
> > patch is. Still, it bothers me a bit so if there is any way please let me know.
> > (I thought about writing some assembly to directly test the syscall numbers but
> > all it would do is verify that the numbers are valid, which really isn't much
> > of a test.)
> 
> Actually that is still a useful test, it at least tells you if the kernel
> you're running on implements the syscalls. Obviously if you're on mainline
> that's easy enough to work out from the git history, but if/when these get
> backported to distro kernels, it's often harder to work out what's in the
> source than just testing it directly.

Oh, fair enough then.

> So I wrote a quick dirty test for that, it seems to work for me:

[snip]

Thanks :-)

> Which gives:
> 
> test: ipc_unmuxed
> tags: git_version:v4.3-rc3-44-g10053fa531a8-dirty
> Testing semop	returned -1, errno 22
> Testing semget	returned -1, errno 2
> Testing semctl	returned -1, errno 22
> Testing semtimedop	returned -1, errno 22
> Testing msgsnd	returned -1, errno 14
> Testing msgrcv	returned -1, errno 22
> Testing msgget	returned -1, errno 2
> Testing msgctl	returned -1, errno 22
> Testing shmat	returned -1, errno 22
> Testing shmdt	returned -1, errno 22
> Testing shmget	returned -1, errno 2
> Testing shmctl	returned -1, errno 22
> success: ipc_unmuxed
> 
> 
> And on an unpatched system:
> 
> test: ipc_unmuxed
> tags: git_version:v4.3-rc3-44-g10053fa531a8-dirty
> Testing semop	returned -1, errno 38
> [FAIL] Test FAILED on line 2
> failure: ipc_unmuxed
> 
> 
> Look OK?

Yep! And 38 (ENOSYS) is the code we'd expect in the failure case.

> cheers

Cheers,
Sam.
