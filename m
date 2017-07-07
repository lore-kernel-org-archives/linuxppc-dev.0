Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3vW00Zd7zDr5V
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jul 2017 22:46:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Al Viro <viro@ZenIV.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [git pull] vfs.git part 1
In-Reply-To: <20170705071423.GY10672@ZenIV.linux.org.uk>
References: <20170705071423.GY10672@ZenIV.linux.org.uk>
Date: Fri, 07 Jul 2017 22:46:32 +1000
Message-ID: <87eftsv2hj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Al Viro <viro@ZenIV.linux.org.uk> writes:

> 	vfs.git topology is rather convoluted this cycle, so
> I'm afraid that it'll take more pull requests than usual ;-/
>
> The first pile is #work.misc-set_fs.  Assorted getting rid
> of cargo-culted access_ok(), cargo-culted set_fs() and
> field-by-field copyouts.  The same description applies to
> a lot of stuff in other branches - this is just the stuff that
> didn't fit into a more specific topical branch.
>
> The following changes since commit c86daad2c25bfd4a33d48b7691afaa96d9c5ab46:
>
>   Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input (2017-05-26 16:45:13 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc-set_fs
>
> for you to fetch changes up to 8c6657cb50cb037ff58b3f6a547c6569568f3527:
>
>   Switch flock copyin/copyout primitives to copy_{from,to}_user() (2017-06-26 23:52:44 -0400)

This commit seems to have broken networking on a bunch of my PPC
machines (64-bit kernel, 32-bit userspace).

# first bad commit: [8c6657cb50cb037ff58b3f6a547c6569568f3527] Switch flock copyin/copyout primitives to copy_{from,to}_user()

The symptom is eth0 doesn't get address via dhcp.

Reverting it on top of master (9f45efb928) everything works OK again.


Trying to bring networking up manually gives:

# ifup eth0
ifup: failed to lock lockfile /run/network/ifstate.eth0: Invalid argument

strace shows:

5647  fcntl64(3, F_SETLK, {l_type=F_WRLCK, l_whence=SEEK_SET, l_start=0, l_len=0}) = -1 EINVAL (Invalid argument)
5647  write(2, "ifup: failed to lock lockfile /r"..., 74) = 74

vs the working case:

6005  fcntl64(3, F_SETLK, {l_type=F_WRLCK, l_whence=SEEK_SET, l_start=0, l_len=0}) = 0

Patch coming.

cheers
