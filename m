Return-Path: <nielsen.esben@gogglemail.com>
Received: from mx04.stofanet.dk (mx04.stofanet.dk [212.10.10.14])
	by ozlabs.org (Postfix) with ESMTP id 7086567B52
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 21:34:00 +1000 (EST)
Date: Tue, 29 Aug 2006 13:30:06 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@gogglemail.com>
To: Esben Nielsen <nielsen.esben@gogglemail.com>
Subject: RE: atomic operations in user space
In-Reply-To: <Pine.LNX.4.64.0608291323390.12461@frodo.shire>
Message-ID: <Pine.LNX.4.64.0608291329170.12461@frodo.shire>
References: <4879B0C6C249214CBE7AB04453F84E4D0FC7A3@zch01exm20.fsl.freescale.net>
	<Pine.LNX.4.64.0608291323390.12461@frodo.shire>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Xupei Liang <tliang@yahoo.com>, Liu Dave-r63238 <DaveLiu@freescale.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



On Tue, 29 Aug 2006, Esben Nielsen wrote:

>
>
> On Tue, 29 Aug 2006, Li Yang-r58472 wrote:
>
>> 
>> >  -----Original Message-----
>> >  From: Esben Nielsen [mailto:nielsen.esben@gogglemail.com]
>> >  Sent: Tuesday, August 29, 2006 5:57 PM
>> >  To: Liu Dave-r63238
>> >  Cc: Li Yang-r58472; Esben Nielsen; Xupei Liang;
>>  linuxppc-embedded@ozlabs.org
>> >  Subject: RE: atomic operations in user space
>> > 
>> > 
>> > 
>> >  On Tue, 29 Aug 2006, Liu Dave-r63238 wrote:
>> > 
>> > > > >  2) These mutexes are based on futexes which requires atomic
>> > > > >  operations in userspace. These are available on most
>>  architectures.
>> > >  Look at
>> > > > >  the glibc code in
>> > > > >  nptl/sysdeps/unix/sysv/linux/powerpc/lowlevellock.h for instance.
>> > > > >  Use that and your PPC manual to implement your atomic operations.
>> > > > 
>> > > >  No matter semaphore or futex, it uses system calls to kernel.
>> > 
>> >  There is only a system call if there is congestion - that is the whole
>>  idea
>> >  behind the futex.
>> > 
>> > > >  And the
>> > > >  true atomic operation is in kernel not user space.
>> > 
>> >  "True" atomic operations are available in user space on most
>>  architectures.
>> > 
>> > > >  Maybe
>> > > >  it's feasible
>> > > >  for other architectures to do atomic operations directly in
>> > > >  user space.
>> > > >  IMHO, not for powerpc.
>> > 
>> >  It is available for PowerPC, but not in POWER and POWER2
>>  instructionsets
>> >  according to http://www.nersc.gov/vendor_docs/ibm/asm/lwarx.htm#idx607
>> >  It is the same in the ARM world: Atomic instructions was introduced in
>> >  ARMv6 I believe. Older ARM processors don't have them.
>>
>>  Yes, I do know there are lwarx and stwrx instructions.  But there is
>>  only one reservation per CPU and reservation can be re-established with
>>  no difference.
>>  So there are possibilities reservation is broken and reserved again in
>>  one atomic block.
>>
>>  Task A			Task B
>>  lwarx
>>      ......
>>      lwarx
>>      stwrx
>>
>>      .....
>>      .....
>>      lwarx
>>  stwrx
>>  .....
>>      stwrx
>>
>>  The addresses of above operations are the same.
>>
>>  In this case Thread A thinks that it is atomic as it holds the same
>>  reservation, but it is actually broken.  Such control flow can't be
>>  prevented in user space.
>> 
>
> So you are saying that futexes on powerpc are broken?

Are you sure the reservation isn't automaticly broken due to the task 
switch?

>
> Esben
>

Esben

>> > 
>> > > 
>> > >  Are you meaning that we didn't do atomic operations directly in user
>> > >  space
>> > >  on powerpc platform ?
>> > > 
>> > 
>> >  Well, that is not the conclusion I get either when reading the glibc
>>  code.
>> >  Try to look at glibc-2.3.5/sysdeps/powerpc/bits/atomic.h.
>> > 
>> >  This is by the way probably what the original post in this thread
>>  wanted
>> >  in the first place!
>> > 
>> >  Esben
>> > 
>> > 
>> > >  -DAve
>>
>>  _______________________________________________
>>  Linuxppc-embedded mailing list
>>  Linuxppc-embedded@ozlabs.org
>>  https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> 
>
>
