Return-Path: <wangbj@lzu.edu.cn>
Received: from eyou.net (unknown [202.201.0.146])
	by ozlabs.org (Postfix) with SMTP id 05BBADDE3C
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 16:17:34 +1000 (EST)
Message-ID: <393096168.21831@eyou.net>
From: "Wang, Baojun" <wangbj@lzu.edu.cn>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org, rtlinuxgpl@upv.es,
	Miguel Masmano <mimastel@doctor.upv.es>
Subject: Re: ppc manual paging question
Date: Mon, 22 Oct 2007 14:17:43 +0800
References: <200710221203.24157.wangbj@lzu.edu.cn>
	<200710221350.31688.wangbj@lzu.edu.cn> <393033430.04221@lzu.edu.cn>
In-Reply-To: <393033430.04221@lzu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710221417.43544.wangbj@lzu.edu.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 22 October 2007 14:01:33, Benjamin Herrenschmidt wrote=EF=BC=9A
> > I'm porting an adeos nano kernel named xtratum (http://www.xtratum.org)
> > from x86 to ppc, I think I'm near the ending except the above problem.
> > xtratum is doing things like xen but it's much simpler (it's aimed for
> > realtime), it need provides memory space sperations for it's domains, so
> > I need manually paging. Each domain is loaded by a userspace program
> > (instead of the root domain as a kernel module), the loader will load t=
he
> > domain's (ELF staticly excutable) PT_LOAD section into memory, and then
> > raise a properly system call (passing the structurized loaded data as
> > arguments) to load the domain via load_domain_sys(), and at the last st=
ep
> > of loading the domain, xtratum will jump to the entry code of the new
> > domain(asm wrappered start() routine) and then everything should be fin=
e.
> > The problem now is as follow:
> >
> > under my ppc (440GR/440EP) platform, start() is always at 0x100000a0, b=
ut
> > I guess there is something wrong with my mm code so after the domain is
> > loaded, the virt addres 0x100000a0 just point to garbage instead of the
> > right start() routine. So how can I setup paging properly so that the
> > virtual memory could be translated to proper data?
>
> Are you aware that the 440 MMU doesn't actually know what a page table
> is and doesn't load PTEs from memory ?
Sorry I didn't realized that. I've finished looking pem64b.pdf, but it's=20
almost nothing like in ppc 4xx/44x.
> It's a software loaded TLB, you'll have to put translations in the TLB
> yourself. You'll need to design your own data structures for that, tho
> you can use a page table for tracking, like we do in linux, and then
> have your own TLB miss handler to fill the TLB from that.
OK, Shall I look for the DataTLBError code in head.S? I realized that I've =
got=20
DataTLBError sometimes via BDI2000/kgdb (the fault address is within=20
DataTLBError), Shall I should also look for arch/ppc/mm/fault.c?
> Your initial code probably need to bolt a TLB entry for the kernel
> itself.
I don't understand this clearly, how can I do this?
> Ben.

  Regards,
Wang


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
