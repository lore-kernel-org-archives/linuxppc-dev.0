Return-Path: <noah.yan@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.192])
	by ozlabs.org (Postfix) with ESMTP id 763E16857D
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2005 01:56:38 +1000 (EST)
Received: by xproxy.gmail.com with SMTP id s15so328515wxc
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Oct 2005 08:56:36 -0700 (PDT)
Message-ID: <59521b110510280856y9c39f4by54cadd01830ded07@mail.gmail.com>
Date: Fri, 28 Oct 2005 10:56:36 -0500
From: Noah yan <noah.yan@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1130452630.29054.77.camel@gaston>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5036_3668529.1130514996260"
References: <59521b110510270605k6e098826w2d37c50e82ddd758@mail.gmail.com>
	<1130452630.29054.77.camel@gaston>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: How the linux use BAT
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_5036_3668529.1130514996260
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thans Ben very much. More questions below ... :)

On 10/27/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Thu, 2005-10-27 at 08:05 -0500, Noah yan wrote:
> > I am studying source code for power mac. I am curious how linux use
> > the BAT MMU.
> > The address translation of BAT MMU is parallel with that of
> > segment/page MMU. BAT MMU is known as superpages in other
> > architecture.
> > I am not good at the kernel coding part, hope that my questions share
> > the common fundermental with you and no stupid.
> >
> > Here is my questions:
> > Is the kernel turn BAT MMU on? if so, a BAT array have been setup for
> > that, which part of the kernel code does this?
> > If BAT MMU is used, how about segment/page address translation in
> > kernel, is this also enabled and page table is setup?
> >
> > If both BAT and seg/page are enabled, how the kernel make sure that
> > the correct one is used in adress translation?
>
> Both are used and they don't overlap (well, they can overlap but if they
> do, the BAT takes over).
>
> > Is kernel really use the segment MMU of the powerpc, I have an
> > impression that most kernel only use the page MMU?
>
> page MMU vs. segment MMU ? hrm... what do you mean ? :) There is one MMU
> in the "classsic" PowerPC and it does segment and hash table, you have to
> use both, you can't just use one or the other :) You virtual addresses
> go through the segments first to get the vsid which is then used along
> with the remaining bits of the address to hash into the hash table in
> order to get to the translations.

I am sorry that I did make it clear. It is a little confusing for me betwee=
n
the hardware segment and the term "segment" or "section" used in a process'=
s
address space (AS). One of my understanding is that a section in a process'=
s
AS is mapped to a hardware segment, which sound straightforward but maybe
wrong because a process binary may have lots of segments that are not the
same size. Pure segment VM is also hard to maintain memory efficiency. Or,
several sections, such as different data section are in segments. I remembe=
r
in Linux x86 (posibbly 2.4), segment is not fully used in term of VM. The
segmentation of the kernel and userland are defined upon booting and never
changed later on.

Thanks very much!
Noah




The way linux uses BATs is for the kernel linear mapping. Linux uses by
> default (though that can be configued differently) a 3G/1G split, that
> is the low 3G of address space are used by userland (and covered by the
> user page tables) and the high 1G are used by the kernel. That kernel
> space itself is split into a bottom part up to 768Mb (by default, that
> can also be configured differently) which is the linear mapping, that is
> a single linear mapping of all RAM from 0xc0000000. The rest of the
> kernel space is mapped with page tables and known as the kernel virtual
> space, used for vmalloc and ioremap.
>
> The BATs are used for the linear mapping. They "override" the page
> tables over it if any (though we usually don't bother setting up PTEs
> over the space that is BAT mapped). They basically improve performances
> by not requiring to go through the hash trasnslation for most kernel
> accesses to memory and not using space in the TLB/ERAT.
>
> Ben.
>
>
>

------=_Part_5036_3668529.1130514996260
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thans Ben very much. More questions below ... :)<br><br><div><span class=3D=
"gmail_quote">On 10/27/05, <b class=3D"gmail_sendername">Benjamin Herrensch=
midt</b> &lt;<a href=3D"mailto:benh@kernel.crashing.org">benh@kernel.crashi=
ng.org
</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;">On Thu, 2005-10-27 at 08:05 -0500, Noah yan wrote:<br>&gt; I am studyi=
ng source code for power mac. I am curious how linux use
<br>&gt; the BAT MMU.<br>&gt; The address translation of BAT MMU is paralle=
l with that of<br>&gt; segment/page MMU. BAT MMU is known as superpages in =
other<br>&gt; architecture.<br>&gt; I am not good at the kernel coding part=
, hope that my questions share
<br>&gt; the common fundermental with you and no stupid.<br>&gt;<br>&gt; He=
re&nbsp;&nbsp;is my questions:<br>&gt; Is the kernel turn BAT MMU on? if so=
, a BAT array have been setup for<br>&gt; that, which part of the kernel co=
de does this?
<br>&gt; If BAT MMU is used, how about segment/page address translation in<=
br>&gt; kernel, is this also enabled and page table is setup?<br>&gt;<br>&g=
t; If both BAT and seg/page are enabled, how the kernel make sure that<br>
&gt; the correct one is used in adress translation?<br><br>Both are used an=
d they don't overlap (well, they can overlap but if they<br>do, the BAT tak=
es over).<br><br>&gt; Is kernel really use the segment MMU of the powerpc, =
I have an
<br>&gt; impression that most kernel only use the page MMU?<br><br>page MMU=
 vs. segment MMU ? hrm... what do you mean ? :) There is one MMU<br>in the =
&quot;classsic&quot; PowerPC and it does segment and hash table, you have t=
o
<br>use both, you can't just use one or the other :) You virtual addresses<=
br>go through the segments first to get the vsid which is then used along<b=
r>with the remaining bits of the address to hash into the hash table in
<br>order to get to the translations.</blockquote><div>I
am sorry that I did make it clear. It is a little confusing for me
between the hardware segment and the term &quot;segment&quot; or &quot;sect=
ion&quot; used
in a process's address space (AS). One of my understanding is that a
section in a process's AS is mapped to a hardware segment, which sound
straightforward but maybe wrong because a process binary may have lots
of segments that are not the same size. Pure segment VM is also hard to
maintain memory efficiency.&nbsp; Or, several sections, such as
different data section are in segments. I remember in Linux x86
(posibbly 2.4), segment is not fully used in term of VM. The
segmentation of the kernel and userland are defined upon booting and
never changed later on. <br>
<br>
Thanks very much!<br>
Noah<br>
<br>
<br>
<br>
&nbsp;</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">T=
he way linux uses BATs is for the kernel linear mapping. Linux uses by<br>d=
efault (though that can be configued differently) a 3G/1G split, that
<br>is the low 3G of address space are used by userland (and covered by the=
<br>user page tables) and the high 1G are used by the kernel. That kernel<b=
r>space itself is split into a bottom part up to 768Mb (by default, that
<br>can also be configured differently) which is the linear mapping, that i=
s<br>a single linear mapping of all RAM from 0xc0000000. The rest of the<br=
>kernel space is mapped with page tables and known as the kernel virtual
<br>space, used for vmalloc and ioremap.<br><br>The BATs are used for the l=
inear mapping. They &quot;override&quot; the page<br>tables over it if any =
(though we usually don't bother setting up PTEs<br>over the space that is B=
AT mapped). They basically improve performances
<br>by not requiring to go through the hash trasnslation for most kernel<br=
>accesses to memory and not using space in the TLB/ERAT.<br><br>Ben.<br><br=
><br></blockquote></div><br>

------=_Part_5036_3668529.1130514996260--
