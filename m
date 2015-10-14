Return-Path: <sam.bobroff@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E586F1A0742
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 18:01:42 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B8A54140E40
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2015 18:01:42 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Wed, 14 Oct 2015 17:01:41 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 287202CE8052
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2015 18:01:35 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9E71RdY66781294
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2015 18:01:35 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9E712YA012017
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2015 18:01:02 +1100
Date: Wed, 14 Oct 2015 18:00:29 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, anton@samba.org
Subject: Re: [v2,1/1] powerpc: Individual System V IPC system calls
Message-ID: <20151014070029.GA8383@tungsten.ozlabs.ibm.com>
References: <a3cfb270cd61cc3aacdf929e7739ae46dcff86bd.1444700960.git.sam.bobroff@au1.ibm.com>
 <20151013093842.B3EA21402D6@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151013093842.B3EA21402D6@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 13, 2015 at 08:38:42PM +1100, Michael Ellerman wrote:
> On Tue, 2015-13-10 at 01:49:28 UTC, Sam bobroff wrote:
> > This patch provides individual system call numbers for the following
> > System V IPC system calls, on PowerPC, so that they do not need to be
> > multiplexed:
> > * semop, semget, semctl, semtimedop
> > * msgsnd, msgrcv, msgget, msgctl
> > * shmat, shmdt, shmget, shmctl
> 
> You tested this right? :)  Tell me about it.

Why yes I did:

I have written a (fairly) trivial test program that calls each function in a
way that doesn't fail (but that doesn't necessarily attempt to exercise the
full functionality of it; my intent was primarily to validate the parameter
passing part as that is where most of the code change is (on the glibc side)).

I patched a local copy of glibc with the new kernel header and various tweaks
to correctly format the parameter lists for the new calls (there is actually
quite a lot of code in glibc around the IPC calls due to various compatibility
issues). I could then build a full tool chain that supported the new calls.

(This was a lot more extensive than the kernel patch but should be fairly close
to what needs to go into glibc.)

I used that tool chain to build a complete host system (using buildroot). Then
I could run the following tests:

* glibc: stock
  Host kernel: stock
  Result: success
  Notes: As expected, base case.

* glibc: stock
  Host kernel: patched
  Result: success
  Notes: As expected, the old ipc() call still exists in the patched host.

* glibc: patched
  Host kernel: stock
  Result: failure
  Notes: As expected, the test was run with a glibc that requires a patched
  kernel on an unpatched one so the syscalls are unknown.

* glibc: patched
  Host kernel: patched
  Result: success
  Notes: As expected. (Also, a bit of debug in glibc shows the new system call
  paths being followed.)

(I also re-ran the tests both for little-endian and big-endian hosts.)

It would obviously be good to have someone else test this, but I can't see a
way to make it easy to do. They would presumably have to go through all of the
above, which seems too much to ask given how trivial the kernel side of the
patch is. Still, it bothers me a bit so if there is any way please let me know.
(I thought about writing some assembly to directly test the syscall numbers but
all it would do is verify that the numbers are valid, which really isn't much
of a test.)

> Also we could make these available to SPU programs, but I don't think there's
> any point, no one's going to do a libc update for that.
> 
> cheers

Cheers,
Sam.
