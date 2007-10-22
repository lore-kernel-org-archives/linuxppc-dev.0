Return-Path: <wangbj@lzu.edu.cn>
Received: from eyou.net (unknown [202.201.0.146])
	by ozlabs.org (Postfix) with SMTP id 4F420DDE36
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 15:50:22 +1000 (EST)
Message-ID: <393094536.19293@eyou.net>
From: "Wang, Baojun" <wangbj@lzu.edu.cn>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	Miguel Masmano <mimastel@doctor.upv.es>, rtlinuxgpl@upv.es
Subject: Re: ppc manual paging question
Date: Mon, 22 Oct 2007 13:50:31 +0800
References: <200710221203.24157.wangbj@lzu.edu.cn> <393029235.18964@lzu.edu.cn>
In-Reply-To: <393029235.18964@lzu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710221350.31688.wangbj@lzu.edu.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 22 October 2007 12:50:52, Benjamin Herrenschmidt wrote=EF=BC=9A
> On Mon, 2007-10-22 at 12:03 +0800, Wang, Baojun wrote:
> > hi,
> >
> >   I've got some qeustion about ppc(ppc44x) paging:
> >
> > how can I manually map a virtual address to a physical address through a
> > specific pgd? How does ppc translate virt address to physical one? I
> > think besides from tlb, the CPU will search the page table entries via
> > the pgd, can I alter the pgd value to change the memory translation?
> > under i386, it's very simple, we can just rewrite %%cr3, it even could
> > invalidate all tlb entries automatically, how can I do this under ppc?
> > I've tried rewrite
> > current->mm->pgd and current->thread.pgdir, but sounds like it still not
> > insufficiant, am I missing something vital?
>
> What the heck are you trying to do ? Please explain and I'll tell you
> how to do it properly :-)

I'm porting an adeos nano kernel named xtratum (http://www.xtratum.org) fro=
m=20
x86 to ppc, I think I'm near the ending except the above problem. xtratum i=
s=20
doing things like xen but it's much simpler (it's aimed for realtime), it=20
need provides memory space sperations for it's domains, so I need manually=
=20
paging. Each domain is loaded by a userspace program (instead of the root=20
domain as a kernel module), the loader will load the domain's (ELF staticly=
=20
excutable) PT_LOAD section into memory, and then raise a properly system ca=
ll=20
(passing the structurized loaded data as arguments) to load the domain via=
=20
load_domain_sys(), and at the last step of loading the domain, xtratum will=
=20
jump to the entry code of the new domain(asm wrappered start() routine) and=
=20
then everything should be fine. The problem now is as follow:

under my ppc (440GR/440EP) platform, start() is always at 0x100000a0, but I=
=20
guess there is something wrong with my mm code so after the domain is loade=
d,=20
the virt addres 0x100000a0 just point to garbage instead of the right start=
()=20
routine. So how can I setup paging properly so that the virtual memory coul=
d=20
be translated to proper data?

I can describe in more detail if neccessary.

Thanks very much for take care.

  Regards,
Wang

P.S:

The orignal xtratum (x86) code:

#define load_pd(pd) {\
  __asm__ __volatile__ ("movl %0,%%cr3": :"r" (__pa(pd))); \
}

#define save_pd(pd) {\
  __asm__ __volatile__ ("movl %%cr3, %0\n\t": "=3Dr" (pd) :); \
  pd =3D (unsigned long) __va (pd); \
}

=2E..

// Virtual address to page directory entry
#define va2pd(vaddress) ((vaddress) >> PGDIR_SHIFT)

// Virtual address to page table entry
#define va2pt(vaddress) (((vaddress) & 0x3FF000) >> PAGE_SHIFT)

// Page directory and page table to virtual address
#define pdpt2va(pd, pt) (((pd) << PGDIR_SHIFT) | ((pt) << PAGE_SHIFT))

// Next macro allows to obtain a pt address through the page directory
#define get_pd_addr(pd, pd_entry) \
  ((unsigned long) __va (((unsigned long *)(pd)) [(pd_entry)] & PAGE_MASK))

// And the following one allows to  obtain a page address via the page
// table
#define get_pt_addr(pt, pt_entry) \
  ((unsigned long)__va (((unsigned long *)*(pt)) [(pt_entry)] & PAGE_MASK))

=2E..

static inline void fill_pd_entry (unsigned long pd,
                                     unsigned long pd_entry,
                                     unsigned long pt,
                                     unsigned long flags) {
  ((unsigned long *)pd) [pd_entry] =3D
    ((__pa (pt) & PAGE_MASK) | (flags & 0xFFF));
}

static inline void fill_pt_entry (unsigned long pt,
                                     unsigned long pt_entry,
                                     unsigned long page,
                                     unsigned long flags) {
  ((unsigned long *)pt) [pt_entry] =3D
    ((__pa (page) & PAGE_MASK) | (flags & 0xFFF));
}

=2E..

static inline unsigned long create_page_directory (unsigned long
                                                   (*alloc_page) (void)) {
  unsigned long pd =3D (*alloc_page) (), c_pd;

  if (!pd) return pd;
  save_pd(c_pd);

  memset  ((unsigned char *) &((unsigned long *) pd)[0],
           0, 1024 * sizeof (unsigned long));

  memcpy ((unsigned char *) &((unsigned long *) pd)[va2pd(PAGE_OFFSET)],
          (unsigned char *) &((unsigned long *) c_pd)[va2pd(PAGE_OFFSET)],
          (1024 - va2pd(PAGE_OFFSET)) * sizeof (unsigned long));

  return pd;
}

static inline unsigned long allocate_user_page (unsigned long pd,
                                                unsigned long vaddress,
                                                unsigned long (*alloc_page)
                                                (void)) {
  unsigned long pt_entry =3D va2pt(vaddress),
    pd_entry =3D va2pd(vaddress), pt, page =3D 0;

  if (vaddress >=3D PAGE_OFFSET) return 0;

  // Check if there is already an allocated pt in the pd table
  if (!(((unsigned long *)pd) [pd_entry] & _PAGE_PRESENT)) {
    if (!(pt =3D (unsigned long) (*alloc_page) ())) return 0;
    fill_pd_entry (pd, pd_entry,
                   pt, _PAGE_PRESENT | _PAGE_RW | _PAGE_USER);
  } else
    pt =3D get_pd_addr(pd, pd_entry);

  // Check whether there is already an allocated page in the pt table
  if (!(((unsigned long *)pt)[pt_entry] & _PAGE_PRESENT)) {
    if (!(page =3D (unsigned long) (*alloc_page) ())) return 0;
    fill_pt_entry (pt, pt_entry, page,
                   _PAGE_PRESENT | _PAGE_RW | _PAGE_USER);
  }
  return page;
}


> Cheers,
> Ben.



=2D-=20
Wang, Baojun =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Lanzhou University
Distributed & Embedded System Lab =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0http://dslab.lzu.edu.cn
School of Information Science and Engeneering =C2=A0 =C2=A0 =C2=A0 =C2=A0wa=
ngbj@lzu.edu.cn
Tianshui South Road 222. Lanzhou 730000 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .P.R.China
Tel:+86-931-8912025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Fax:+86-931-8912022
