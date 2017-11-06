Return-Path: <JPF@zurich.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVrWb3zdqzDq78
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 22:51:54 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA6BnUwa058740
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Nov 2017 06:51:51 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com
 [192.155.248.91])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e2nnx4v5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 06:51:51 -0500
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <linuxppc-dev@lists.ozlabs.org> from <JPF@zurich.ibm.com>;
 Mon, 6 Nov 2017 11:51:50 -0000
MIME-Version: 1.0
In-Reply-To: <877ev3bs8h.fsf@concordia.ellerman.id.au>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda: Relax max DMA window size
 check
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson
 <david@gibson.dropbear.id.au>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
From: "Jonas Pfefferle1" <JPF@zurich.ibm.com>
Date: Mon, 6 Nov 2017 12:51:44 +0100
References: <20171031040427.10909-1-aik@ozlabs.ru>
 <fd1a289f-6698-0b84-eab8-d4c67290bea8@ozlabs.ru>
 <877ev3bs8h.fsf@concordia.ellerman.id.au>
Content-type: multipart/alternative;
 Boundary="0__=4EBB0B43DFD308CE8f9e8a93df938690918c4EBB0B43DFD308CE"
Message-Id: <OFCF065D28.9A31DE1D-ONC12581D0.00408E5E-C12581D0.00412989@notes.na.collabserv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--0__=4EBB0B43DFD308CE8f9e8a93df938690918c4EBB0B43DFD308CE
Content-Transfer-Encoding: quoted-printable
Content-type: text/plain; charset=US-ASCII


Michael Ellerman <mpe@ellerman.id.au> wrote on 11/06/2017 11:45:34 AM:

> From: Michael Ellerman <mpe@ellerman.id.au>
> To: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson
> <david@gibson.dropbear.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org, Jonas Pfefferle1
> <JPF@zurich.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
> Date: 11/06/2017 11:45 AM
> Subject: Re: [PATCH kernel] powerpc/powernv/ioda: Relax max DMA
> window size check
>
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>
> > On 31/10/17 15:04, Alexey Kardashevskiy wrote:
> >> DMA windows can only have a size of power of two on IODA2 hardware and
> >> using memory=5Fhotplug=5Fmax() to determine the upper limit won't work
> >> correcly if it returns not power of two value.
> >>
> >> This relaxes the check by rounding up the value returned by
> >> memory=5Fhotplug=5Fmax().
> >>
> >> It is expected to impact DPDK on machines with non-power-of-two RAM
size,
> >> mostly. KVM guests are less likely to be affected as usually guests
get
> >> less than half of hosts RAM.
> >
> >
> > It was pointed out that this check is quite useless anyway as the
vm=5Flocked
> > memory limit should hit first, and if that is not set or the user got
the
> > root privilege level, then there are easier ways to crash the host so I
am
> > thinking of:
> >
> >
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
> > b/arch/powerpc/platforms/powernv/pci-ioda.c
> > index 269f119e4b3c..a47e4cf343b2 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -2769,7 +2769,7 @@ static long pnv=5Fpci=5Fioda2=5Ftable=5Falloc=5Fp=
ages(int
nid,
> > =5F=5Fu64 bus=5Foffset,
> >         if (!levels || (levels > POWERNV=5FIOMMU=5FMAX=5FLEVELS))
> >                 return -EINVAL;
> >
> > -       if ((window=5Fsize > memory=5Fhotplug=5Fmax()) ||
> > !is=5Fpower=5Fof=5F2(window=5Fsize))
> > +       if (!is=5Fpower=5Fof=5F2(window=5Fsize))
> >                 return -EINVAL;
> >
> >
> >
> > Makes sense?
>
> Sounds reasonable.
>
> Execpt where is the vm=5Flocked check? I think it's in the VFIO driver? If
> so I guess the only concern is that this code might be called via some
> other path that doesn't do that check.
>
> cheers
>

The vm=5Flocked is incremented here:
http://elixir.free-electrons.com/linux/v4.13.11/source/drivers/vfio/vfio=5F=
iommu=5Fspapr=5Ftce.c#L176
resp.
http://elixir.free-electrons.com/linux/v4.13.11/source/arch/powerpc/mm/mmu=
=5Fcontext=5Fiommu.c#L124
on VFIO=5FIOMMU=5FSPAPR=5FREGISTER=5FMEMORY. From my understanding only pag=
es
that have been registered through here can be mapped with MAP=5FDMA.

Cheers,
Jonas

--0__=4EBB0B43DFD308CE8f9e8a93df938690918c4EBB0B43DFD308CE
Content-Transfer-Encoding: quoted-printable
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body><p><tt><font size=3D"2">Michael Ellerman &lt;mpe@ellerman.id.au=
&gt; wrote on 11/06/2017 11:45:34 AM:<br><br>&gt; From: Michael Ellerman &l=
t;mpe@ellerman.id.au&gt;</font></tt><br><tt><font size=3D"2">&gt; To: Alexe=
y Kardashevskiy &lt;aik@ozlabs.ru&gt;, David Gibson <br>&gt; &lt;david@gibs=
on.dropbear.id.au&gt;</font></tt><br><tt><font size=3D"2">&gt; Cc: linuxppc=
-dev@lists.ozlabs.org, Jonas Pfefferle1 <br>&gt; &lt;JPF@zurich.ibm.com&gt;=
, Nicholas Piggin &lt;npiggin@gmail.com&gt;</font></tt><br><tt><font size=
=3D"2">&gt; Date: 11/06/2017 11:45 AM</font></tt><br><tt><font size=3D"2">&=
gt; Subject: Re: [PATCH kernel] powerpc/powernv/ioda: Relax max DMA <br>&gt=
; window size check</font></tt><br><tt><font size=3D"2">&gt; <br>&gt; Alexe=
y Kardashevskiy &lt;aik@ozlabs.ru&gt; writes:<br>&gt; <br>&gt; &gt; On 31/1=
0/17 15:04, Alexey Kardashevskiy wrote:<br>&gt; &gt;&gt; DMA windows can on=
ly have a size of power of two on IODA2 hardware and<br>&gt; &gt;&gt; using=
 memory=5Fhotplug=5Fmax() to determine the upper limit won't work<br>&gt; &=
gt;&gt; correcly if it returns not power of two value.<br>&gt; &gt;&gt; <br=
>&gt; &gt;&gt; This relaxes the check by rounding up the value returned by<=
br>&gt; &gt;&gt; memory=5Fhotplug=5Fmax().<br>&gt; &gt;&gt; <br>&gt; &gt;&g=
t; It is expected to impact DPDK on machines with non-power-of-two RAM size=
,<br>&gt; &gt;&gt; mostly. KVM guests are less likely to be affected as usu=
ally guests get<br>&gt; &gt;&gt; less than half of hosts RAM.<br>&gt; &gt;<=
br>&gt; &gt;<br>&gt; &gt; It was pointed out that this check is quite usele=
ss anyway as the vm=5Flocked<br>&gt; &gt; memory limit should hit first, an=
d if that is not set or the user got the<br>&gt; &gt; root privilege level,=
 then there are easier ways to crash the host so I am<br>&gt; &gt; thinking=
 of:<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; diff --git a/arch/powerpc/platf=
orms/powernv/pci-ioda.c<br>&gt; &gt; b/arch/powerpc/platforms/powernv/pci-i=
oda.c<br>&gt; &gt; index 269f119e4b3c..a47e4cf343b2 100644<br>&gt; &gt; ---=
 a/arch/powerpc/platforms/powernv/pci-ioda.c<br>&gt; &gt; +++ b/arch/powerp=
c/platforms/powernv/pci-ioda.c<br>&gt; &gt; @@ -2769,7 +2769,7 @@ static lo=
ng pnv=5Fpci=5Fioda2=5Ftable=5Falloc=5Fpages(int nid,<br>&gt; &gt; =5F=5Fu6=
4 bus=5Foffset,<br>&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; if (!levels || (le=
vels &gt; POWERNV=5FIOMMU=5FMAX=5FLEVELS))<br>&gt; &gt; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EINVAL;<br>&gt; &gt;<br>&gt; &=
gt; - &nbsp; &nbsp; &nbsp; if ((window=5Fsize &gt; memory=5Fhotplug=5Fmax()=
) ||<br>&gt; &gt; !is=5Fpower=5Fof=5F2(window=5Fsize))<br>&gt; &gt; + &nbsp=
; &nbsp; &nbsp; if (!is=5Fpower=5Fof=5F2(window=5Fsize))<br>&gt; &gt; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EINVAL;<br>&gt; =
&gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; Makes sense?<br>&gt; <br>&gt; S=
ounds reasonable.<br>&gt; <br>&gt; Execpt where is the vm=5Flocked check? I=
 think it's in the VFIO driver? If<br>&gt; so I guess the only concern is t=
hat this code might be called via some<br>&gt; other path that doesn't do t=
hat check.<br>&gt; <br>&gt; cheers<br>&gt; </font></tt><br><br><tt><font si=
ze=3D"2">The vm=5Flocked is incremented here:</font></tt><br><a href=3D"htt=
p://elixir.free-electrons.com/linux/v4.13.11/source/drivers/vfio/vfio=5Fiom=
mu=5Fspapr=5Ftce.c#L176"><tt><font size=3D"2">http://elixir.free-electrons.=
com/linux/v4.13.11/source/drivers/vfio/vfio=5Fiommu=5Fspapr=5Ftce.c#L176</f=
ont></tt></a><br><tt><font size=3D"2">resp. </font></tt><a href=3D"http://e=
lixir.free-electrons.com/linux/v4.13.11/source/arch/powerpc/mm/mmu=5Fcontex=
t=5Fiommu.c#L124"><tt><font size=3D"2">http://elixir.free-electrons.com/lin=
ux/v4.13.11/source/arch/powerpc/mm/mmu=5Fcontext=5Fiommu.c#L124</font></tt>=
</a><br><tt><font size=3D"2">on </font></tt><tt><font size=3D"2">VFIO=5FIOM=
MU=5FSPAPR=5FREGISTER=5FMEMORY.</font></tt><tt><font size=3D"2">&nbsp;From =
my understanding only pages</font></tt><br><tt><font size=3D"2">that have b=
een registered through here can be mapped with MAP=5FDMA.</font></tt><br><b=
r><tt><font size=3D"2">Cheers,</font></tt><br><tt><font size=3D"2">Jonas<br=
></font></tt><BR>
</body></html>

--0__=4EBB0B43DFD308CE8f9e8a93df938690918c4EBB0B43DFD308CE--
