Return-Path: <joakim.tjernlund@transmode.se>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 417C81A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 06:07:54 +1000 (AEST)
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: "scottwood@freescale.com" <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>
Subject: Re: [PATCH v2 22/25] powerpc32: move xxxxx_dcache_range() functions
 inline
Date: Tue, 22 Sep 2015 20:07:51 +0000
Message-ID: <1442952471.29498.60.camel@transmode.se>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <c1c88096cb3f6ee71048dbab44ffb9ac260b07a3.1442939410.git.christophe.leroy@c-s.fr>
 <1442945547.29498.50.camel@transmode.se>
 <1442948339.19102.270.camel@freescale.com>
 <1442950473.29498.54.camel@transmode.se>
 <1442950926.19102.280.camel@freescale.com>
 <1442951752.29498.58.camel@transmode.se>
In-Reply-To: <1442951752.29498.58.camel@transmode.se>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > And generally the one proposing uglification-for-optimization should pr=
ovide=20
> > the evidence. :-)
>=20
> When it comes to gcc, past history is my evidence until proven otherwise =
:)
> Maybe I will check again ...

OK then:
static inline void mb(void)
{
       __asm__ __volatile__ ("sync" : : : "memory");
}

static inline void dcbf(void *addr)
{
       __asm__ __volatile__ ("dcbf 0, %0" : : "r"(addr) : "memory");
}
#define L1_CACHE_SHIFT 5
#define L1_CACHE_BYTES  (1 << L1_CACHE_SHIFT)
void flush_dcache_range(unsigned long start, unsigned long stop)
{
       void *addr =3D (void *)(start & ~(L1_CACHE_BYTES - 1));
       unsigned int size =3D stop - (unsigned long)addr + (L1_CACHE_BYTES -=
 1);
       unsigned int i;

       for (i =3D 0; i < size >> L1_CACHE_SHIFT; i++, addr +=3D L1_CACHE_BY=
TES)
               dcbf(addr);
       if (i)
               mb();   /* sync */
}

gives:
flush_dcache_range:
	stwu %r1,-16(%r1)
	rlwinm %r3,%r3,0,0,26
	addi %r4,%r4,31
	subf %r9,%r3,%r4
	srwi. %r10,%r9,5
	beq %cr0,.L1
	mtctr %r10
	.p2align 4,,15
.L4:
#APP
 # 8 "gccloop.c" 1
	dcbf 0, %r3
 # 0 "" 2
#NO_APP
	addi %r3,%r3,32
	bdnz .L4
#APP
 # 3 "gccloop.c" 1
	sync
 # 0 "" 2
#NO_APP
.L1:
	addi %r1,%r1,16
	blr

good enough :)
