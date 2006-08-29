Return-Path: <nielsen.esben@gogglemail.com>
Received: from mx02.stofanet.dk (mx02.stofanet.dk [212.10.10.12])
	by ozlabs.org (Postfix) with ESMTP id 64929679E7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 19:59:45 +1000 (EST)
Date: Tue, 29 Aug 2006 11:56:30 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@gogglemail.com>
To: Liu Dave-r63238 <DaveLiu@freescale.com>
Subject: RE: atomic operations in user space
In-Reply-To: <995B09A8299C2C44B59866F6391D263511BAE8@zch01exm21.fsl.freescale.net>
Message-ID: <Pine.LNX.4.64.0608291136370.12461@frodo.shire>
References: <995B09A8299C2C44B59866F6391D263511BAE8@zch01exm21.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Esben Nielsen <nielsen.esben@gogglemail.com>,
	Xupei Liang <tliang@yahoo.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



On Tue, 29 Aug 2006, Liu Dave-r63238 wrote:

>>> 2) These mutexes are based on futexes which requires atomic
>>> operations in userspace. These are available on most architectures.
> Look at
>>> the glibc code in
>>> nptl/sysdeps/unix/sysv/linux/powerpc/lowlevellock.h for instance.
>>> Use that and your PPC manual to implement your atomic operations.
>>
>> No matter semaphore or futex, it uses system calls to kernel.

There is only a system call if there is congestion - that is the whole idea
behind the futex.

>> And the
>> true atomic operation is in kernel not user space.

"True" atomic operations are available in user space on most architectures.

>> Maybe
>> it's feasible
>> for other architectures to do atomic operations directly in
>> user space.
>> IMHO, not for powerpc.

It is available for PowerPC, but not in POWER and POWER2 instructionsets 
according to http://www.nersc.gov/vendor_docs/ibm/asm/lwarx.htm#idx607
It is the same in the ARM world: Atomic instructions was introduced in 
ARMv6 I believe. Older ARM processors don't have them.

>
> Are you meaning that we didn't do atomic operations directly in user
> space
> on powerpc platform ?
>

Well, that is not the conclusion I get either when reading the glibc code.
Try to look at glibc-2.3.5/sysdeps/powerpc/bits/atomic.h.

This is by the way probably what the original post in this thread wanted 
in the first place!

Esben


> -DAve
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
