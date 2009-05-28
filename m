Return-Path: <tmorrison@empirix.com>
Received: from empbedexfe.empirix.com (empbedexfe.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 2D307DDFBF
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 04:45:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Kernel bug in 2.6.23...was: RE: How to debug a hung multi-core
	system....
Date: Thu, 28 May 2009 14:46:29 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90111063E85@EMPBEDEX.empirix.com>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D90110F53C57@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D90110EFACB2@EMPBEDEX.empirix.com>
	<C966FFF1-23FD-4581-A001-79F6961F8E49@kernel.crashing.org>
	<BD261180E6D35F4D9D32F3E44FD3D90110F53A79@EMPBEDEX.empirix.com>
	<27AB6AE2-F8BA-4F05-9597-BCE0F98C1126@kernel.crashing.org>
	<BD261180E6D35F4D9D32F3E44FD3D90110F53C57@EMPBEDEX.empirix.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Morrison, Tom" <tmorrison@empirix.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: Geary Sean-R60898 <sean.geary@freescale.com>, linuxppc-dev@ozlabs.org,
	"Young, Andrew" <andrew.young@windriver.com>, "Brown,
	Jeff" <jbrown@empirix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar,

To follow up on our postings from late last week...
(which I was expecting a response (but never got) from you)...

-----

We (well, mostly a very bright engineer who was very persistent)=20
have(has) found the origin of how the kernel TLB got corrupted.

We tracked down the problem to a programming bug in the DataStorage
exception handler for our kernel (2.6.23). We have looked at newer
kernels, and have noticed that this piece of processing has changed,=20
but let me explain to you what happened (and the conditions that=20
caused the problem on our MPC8572E (running SMP)...

If you follow the logic of in this version of the kernel, it reads=20
the SPRN_DEAR into register R10, and then does some operations=20
(including a tlbsx operation (which uses R10)), and then attempts
to update the associated PTE entry.

Well, if you have REALLY bad luck, sometime between the time you=20
took this exception and try to update the PTE for this page, the=20
other core has decided to invalidate this page's PTE. The good=20
part is the kernel recognizes this unlucky case.

Unfortunately, in this 'bad luck' case, a kernel bug was=20
Introduced. The kernel uses R10 for some processing (puts
the physical address associated with this virtual page) and=20
then branches up 'above' the tlbsx operation to try again=20

...without restoring R10 to the SPRN_DEAR required by the tlbsx
operation...

This means, that even though the kernel recognized this exceptional
problem, it NEVER did the right thing, and instead, the kernel would=20
(attempt) to modify the unlucky TLB virtual address that corresponds=20
to the physical address of the original DataStorage exception.

The only way we caught this is that we also had a second piece of=20
'bad luck' by having that physical address map to the virtual address
of the kernel (0xC0000000), and thus, when it loops back to try again,
it gets the kernel page(s) from the tlbsx operation, and modifies=20
permissions on the kernel pages and thus causing an InstructionStore=20
Exception (forever).

We fixed this in our kernel by just restoring R10 to SPRN_DEAR value
just before it loops back, something like this:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
              ....
	mtspr	SPRN_MAS1, r13
	tlbwe

	/* because we did NOT find in PTE */
	/* r10 was changed - so we need   */
	/* to re-load it here to work     */
	mfspr	r10, SPRN_DEAR   	  /* restore the faulting
address */
	b	5b		/* Try again */
             ....
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

That's the short and long of it...and 4 weeks of very stressful
problems...

I am wondering why nobody has found this problem before - are we the
first to be this unlucky? I am not sure that is a good thing!

Comments? Suggestions? What else should I be doing with this
information?

Tom Morrison
Principal Software Engineer
EMPIRIX=20
20 Crosby Drive - Bedford, MA  01730
p: 781.266.3567 f: 781.266.3670=20
email: tmorrison@empirix.com=20
www.empirix.com


>> -----Original Message-----
>> From: Morrison, Tom
>> Sent: Thursday, May 21, 2009 11:24 AM
>> To: Morrison, Tom; Kumar Gala
>> Cc: linuxppc-dev@ozlabs.org; Young, Andrew; Brown, Jeff; Geary Sean-
>> R60898
>> Subject: RE: How to debug a hung multi-core system....
>>=20
>> Just had a little conference with several co-workers...to go over
results
>>=20
>> We think that LT0 (the one that maps the kernel) has been corrupted:
>>=20
>>        Entry  EPN          RPN    TID  TMASK   WIMGE  TSIZ U0:3  X0:1
>>
---------------------------------------------------------------
>>        LT0  C0000000     00000000 00     0FF     04     9     0     0
>>=20
>>        PID  TS  PROT SHEN   UR   UW   UX   SR   SW   SX  TIDZ VAL
>>
---------------------------------------------------------------
>>        0    0    P    P    E    E    D    E    E    D    D    V
>>=20
>> Is absolutely wrong - this is TLB for the kernel - and as you can see
>> ...it does NOT have execution privileges (and in fact the user space
>> HAS executive privileges for this area (complete opposite of what it
>> should be)...
>>=20
>> This is why it is stuck AT that instruction (can't even single step
>> from that location)..
>>=20
>> (one of) The first problem(s) is how can/when did this TLB get
corrupted!
>>=20
>> Tom
