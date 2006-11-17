Return-Path: <leisun124@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.230])
	by ozlabs.org (Postfix) with ESMTP id 43FA567BB7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Nov 2006 03:47:04 +1100 (EST)
Received: by qb-out-0506.google.com with SMTP id q12so173447qbq
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Nov 2006 08:47:02 -0800 (PST)
Message-ID: <f9a7e7a80611170847n7a19073fief69dede52d1c199@mail.gmail.com>
Date: Fri, 17 Nov 2006 11:47:01 -0500
From: "Lei Sun" <leisun124@gmail.com>
To: "Dave Liu" <r63238@freescale.com>
Subject: Re: memory corruption after MMU turned on
In-Reply-To: <1163753324.3655.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <f9a7e7a80611160744t7071ff6clf5e1d42cfaa2c856@mail.gmail.com>
	<1163753324.3655.18.camel@localhost.localdomain>
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

No, i didn't do the burst memory test, how do i do it then ?

On 11/17/06, Dave Liu <r63238@freescale.com> wrote:
> On Thu, 2006-11-16 at 10:44 -0500, Lei Sun wrote:
> > Hi all:
> >    I am trying to bring up customized board based on MPC8270, the
> > kernel version is 2.4.30, it works fine on one of the Eval board
> > (PQ2FADS-VR, which use MPC8275).
> >    The kernel hangs after uncompressing is done, further debug shows
> > that it hangs right after "rfi " instruction of the turn_on_mmu:
> > function in head.S
> >
> >  turn_on_mmu:
> >     240     mfmsr   r0
> >     241     ori r0,r0,MSR_DR|MSR_IR
> >     242     mtspr   SRR1,r0
> >     243     lis r0,start_here@h
> >     244     ori r0,r0,start_here@l
> >     245     mtspr   SRR0,r0
> >     246     SYNC
> >     247     RFI             /* enables MMU */
> >
> > After i step over the RFI instruction, the PC points to C000XXX , but
> > all memory content is 0 by then.
> > my BATU0 is 0xC000FFE0  BATL0 is 0x00000002, I have 128MB RAM. The
> > u-boot works fine, without MMU turned on. We do have some hardware
> > problem, such that i have to lower the bus frequency to make the SDRAM
> > stable. What physical parameter could cause the board not working with
> > MMU on?
>
> When MMU turn on, the kernel memory should be cacheable, so the
> processor will burst read instructions from memory to i-cache. Did you
> do the burst read/write memory test in u-boot? As you said, you did not
> do the test.
>
> -Dave
>
>
>
