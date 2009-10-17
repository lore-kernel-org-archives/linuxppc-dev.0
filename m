Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C01A0B7B69
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 22:28:23 +1100 (EST)
In-Reply-To: <20091016202541.GA16358@compile2.chatsunix.int.mrv.com>
References: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091015165650.GA3837@compile2.chatsunix.int.mrv.com>
	<OFF665748B.AAF26319-ONC1257651.00296F23-C1257651.002D6BF7@transmode.se>
	<20091016202541.GA16358@compile2.chatsunix.int.mrv.com>
Subject: Re: [PATCH 0/8]  Fix 8xx MMU/TLB
To: Rex Feany <RFeany@mrv.com>
Message-ID: <OF2BB5EF59.1EE0A77D-ONC1257652.003D79DC-C1257652.003EA687@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 17 Oct 2009 13:24:18 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rex Feany <RFeany@mrv.com> wrote on 16/10/2009 22:25:41:
>
> Thus spake Joakim Tjernlund (joakim.tjernlund@transmode.se):
>
> > Right, it is the pte table walk that is blowing up.
> > I just noted that 2.6 lacks a tophys() call in its table walk
> > so I removed that one(there is one more tophys call but I don't think
> > it should be removed).
> > Try this addon patch:
>
> no difference

OK, thinking a bit more, this part should not be executed as
copy_tofrom_user executes in kernel space.

Any chance you can stick a HW breakpoint on FixupDAR?
Perhaps there is something different with kernel
virtual address to phys address?
A simple topys() works in 2.4, but perhaps not in 2.6?
this is the part of interest:
FixupDAR:	/* Entry point for dcbx workaround. */
      /* fetch instruction from memory. */
      mfspr r10, SPRN_SRR0
      andis.      r11, r10, 0x8000
      tophys  (r11, r10)
      beq-  139b		/* Branch if user space address */
140:  lwz   r11,0(r11)

If not kernel dcbX works, you could see if user space does.
Here is a start:

#include <errno.h>
#include <sys/mman.h>
#include <stdio.h>

dcbz(void const *ptr)
{
      __asm__ ("dcbz 0, %0" : : "r" (ptr) : "memory");
}

dcbf(void const *ptr)
{
      __asm__ ("dcbf 0, %0" : : "r" (ptr) : "memory");
}

dcbi(void const *ptr)
{
      __asm__ ("dcbi 0, %0" : : "r" (ptr) : "memory");
}

dcbst(void const *ptr)
{
      __asm__ ("dcbst 0, %0" : : "r" (ptr) : "memory");
}

icbi(void const *ptr)
{
      __asm__ ("icbi 0, %0" : : "r" (ptr) : "memory");
}

dcbt(void const *ptr) /* no TLB Miss */
{
      __asm__ ("dcbt 0, %0" : : "r" (ptr) : "memory");
}

dcbtst(void const *ptr) /* no TLB Miss */
{
      __asm__ ("dcbtst 0, %0" : : "r" (ptr) : "memory");
}

static const unsigned long const a[16*4094] ;
main()
{
      volatile unsigned long b, *ptr = &a[10*4096], *mptr;
      b = *ptr;

      mptr = mmap(NULL, 16*4094, PROT_WRITE | PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
      if (mptr == MAP_FAILED)
            printf("mmap failed:%s\n", strerror(errno));

      ptr = mptr;
#if 0
      dcbst(&a[2*4096]);
      b = *ptr;
      dcbf(&a[6*4096]);
      b = *ptr;
      dcbz(&a[4*4096]);
      b = *ptr;
      dcbst(&a[8*4096]);
      dcbst(&a[8*4096]);
#endif
      *ptr = 17;
      printf("dcbst(ptr)\n"); fflush(stdout);
      dcbst(ptr);
      *(ptr+3+1024) = 18;

      printf("dcbst(ptr+3*1024)\n"); fflush(stdout);
      dcbst(ptr+3*1024);

      printf("dcbt(ptr+5*1024)\n"); fflush(stdout);
      dcbt(ptr+5*1024);

      printf("dcbz(ptr+2*1024)\n"); fflush(stdout);
      dcbf(&a[6*4096]);

      printf("dcbz(&a[4*4096])\n"); fflush(stdout);
      dcbz(&a[4*4096]); fflush(stdout);

      printf("dcbf(&a[6*4096])\n"); fflush(stdout);
      dcbf(&a[6*4096]);

      //dcbz(ptr+2*1024);
      //dcbi(&a[6*4096]);
      //icbi(&a[8*4096]);
}
