Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3133EDDEC0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 09:30:32 +1100 (EST)
In-Reply-To: <000b01c74583$7166e6f0$3a0d10ac@Radstone.Local>
References: <000b01c74583$7166e6f0$3a0d10ac@Radstone.Local>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <9445098E-3EA5-485D-86AC-DDDBA664821F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Huge page support for PowerPC 32 bit and WIMG flexibility
Date: Wed, 31 Jan 2007 16:29:25 -0600
To: Ilya Lipovsky <lipovsky@cs.bu.edu>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 31, 2007, at 4:01 PM, Ilya Lipovsky wrote:

> Hi,
>
> I am not experienced in kernel development, so please be patient.
>
> After exploring the latest (2.19.2) sources it appears that there =20
> is no huge page support for the 32 bit powerpc platform. I deduced =20
> it by starting from 0x300 in head_32.S and comparing notes with =20
> head_64.S. It appears that the only sensible path for hashing in a =20
> huge page (on 64bit ppc) is via:
>
> 0x300: data_access -> do_hash_page -> hash_page -> hash_huge_page
>
> Unfortunately, on the 32bit, all paths that do anything useful end =20
> up in create_hpte() found in hash_low_32.S. I noticed someone on =20
> this mailing list claiming huge page support for IBM 44x core=85 Is =20=

> it possible to make it general enough to encompass ppc32 in general?
>
> Another issue I have is the absence of control over hardware =20
> specific attributes of memory such as WIMG. More concretely, I am =20
> interested in having the ability to allocate off the heap in such a =20=

> way so as to explicitly set the M (coherency) bit off =20
> (independently of SMP or non-SMP mode). This is needed because some =20=

> multicore PowerPC platforms (e.g. 745x) perform an extra address =20
> broadcast to guarantee cache coherency per each store miss on a =20
> cacheline. This degrades performance for store-bound programs.
>
> I understand that hashing pages as non-cache-coherent makes data =20
> contained therein a potential victim to cache coherency paradoxes. =20
> Nevertheless, since I am working on high performance library, I am =20
> prepared to shift coherency guarantees to the library, which is =20
> supposed the one managing the data flow between memory and CPU =20
> caches intelligently.
>
> So, I have 2 main questions:
>
> 1)       What=92s so special about ppc32 that it didn=92t get the =20
> matching feature of huge page support that ppc64 has? Who is =20
> responsible/willing to fix it?
The ppc32 HW doesn't support the same MMU features that ppc64 does.  =20
There's a possibility for something like tlbfs support using BATs, =20
but the normal MMU path doesn't have any HW capable of doing large =20
pages.

> 2)       Is it appropriate to provide a syscall mechanism (parallel =20=

> to sys_brk, sys_mmap, and sys_shmget) to add WIMG settings?
You can do some of this via mmap today.  I think O_SYNC is the flag =20
you need (well at least for mmap'ing /dev/mem).

> Overall, the vision here is to be able (from user-side, on =20
> powerpc32) to call:
>
>
>
> shmid =3D shmget(2, LENGTH, SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W | =20=

> POWERPC_NONCOHERENT);
>
> shmaddr =3D shmat(shmid, ADDR, SHMAT_FLAGS);
>
>
>
> And get a segment mapped with wimg=3D0bxx0x (actually, I assume all =20=

> x=92s are 0). This would be very nice!
>
>
>
>
>
> Thank you,
>
> -Ilya
>
>
>
> P.S. As a side note, it is pretty difficult to read kernel sources =20
> (especially assembly ones) because of the lack of comments for =20
> people who are not in the kernel hacker =93circle.=94 For example, =
what =20
> in the whole world is =93paca??=94
"paca" has to deal with the IBM HV interface.

- k=
