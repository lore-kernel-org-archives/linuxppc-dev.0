Return-Path: <srs0=73t8=3g=gmail.com=kirjanov@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtNCy4JZXzDqGt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 20:45:18 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vtNCy36ZQz8w6P
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 20:45:18 +1100 (AEDT)
MIME-Version: 1.0
In-Reply-To: <20170329093747.GC13844@fergus.ozlabs.ibm.com>
References: <1490603214-30116-1-git-send-email-kda@linux-powerpc.org>
 <87a884evrc.fsf@concordia.ellerman.id.au>
 <20170329093747.GC13844@fergus.ozlabs.ibm.com>
From: Denis Kirjanov <kirjanov@gmail.com>
Date: Wed, 29 Mar 2017 12:45:13 +0300
Message-ID: <CAHj3AV=0dBL-2WfKcsVK57zYRWwnpz+w-89y8Tek5wGNVA-=qg@mail.gmail.com>
Subject: Re: [PATCH] kvm: powerpc: book3s: Disable preemption while accessing
 paca xics_phys filed
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Denis Kirjanov <kda@linux-powerpc.org>
Content-Type: multipart/alternative; boundary=94eb2c092b64e388ed054bdb6e7a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c092b64e388ed054bdb6e7a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, March 29, 2017, Paul Mackerras <paulus@ozlabs.org> wrote:

> On Wed, Mar 29, 2017 at 12:07:03PM +1100, Michael Ellerman wrote:
> > Denis Kirjanov <kda@linux-powerpc.org <javascript:;>> writes:
> >
> [...]
> > > @@ -3930,7 +3934,11 @@ static int kvmppc_book3s_init_hv(void)
> > >      * indirectly, via OPAL.
> > >      */
> > >  #ifdef CONFIG_SMP
> > > -   if (!get_paca()->kvm_hstate.xics_phys) {
> > > +   preempt_disable();
> > > +   xics_phys =3D get_paca()->kvm_hstate.xics_phys;
> > > +   preempt_enable();
> > > +
> > > +   if (!xics_phys) {
> > >             struct device_node *np;
> >
> > Can you tell me what actual problem (other than the warning) this is
> > fixing?
>
> If paca->kvm_hstate.xics_phys is non-zero on one cpu, it will be
> non-zero on them all.  Therefore this is not fixing any actual
> problem, just the warning.
>
> By the way, the #ifdefs are ugly, and could be removed.  (Yes I know
> it was me that put the first #ifdef in that function.)
>
> Paul.
>

Then we can replace get_paca with local_paca to avoid the warning, right?


--=20
Regards / Mit besten Gr=C3=BC=C3=9Fen,
Denis

--94eb2c092b64e388ed054bdb6e7a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, March 29, 2017, Paul Mackerras &lt;<a href=3D"mailto:=
paulus@ozlabs.org">paulus@ozlabs.org</a>&gt; wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">On Wed, Mar 29, 2017 at 12:07:03PM +1100, Michael Ellerman wrote=
:<br>
&gt; Denis Kirjanov &lt;<a href=3D"javascript:;" onclick=3D"_e(event, &#39;=
cvml&#39;, &#39;kda@linux-powerpc.org&#39;)">kda@linux-powerpc.org</a>&gt; =
writes:<br>
&gt;<br>
[...]<br>
&gt; &gt; @@ -3930,7 +3934,11 @@ static int kvmppc_book3s_init_hv(void)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 * indirectly, via OPAL.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt;=C2=A0 #ifdef CONFIG_SMP<br>
&gt; &gt; -=C2=A0 =C2=A0if (!get_paca()-&gt;kvm_hstate.xics_<wbr>phys) {<br=
>
&gt; &gt; +=C2=A0 =C2=A0preempt_disable();<br>
&gt; &gt; +=C2=A0 =C2=A0xics_phys =3D get_paca()-&gt;kvm_hstate.xics_<wbr>p=
hys;<br>
&gt; &gt; +=C2=A0 =C2=A0preempt_enable();<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0if (!xics_phys) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node=
 *np;<br>
&gt;<br>
&gt; Can you tell me what actual problem (other than the warning) this is<b=
r>
&gt; fixing?<br>
<br>
If paca-&gt;kvm_hstate.xics_phys is non-zero on one cpu, it will be<br>
non-zero on them all.=C2=A0 Therefore this is not fixing any actual<br>
problem, just the warning.<br>
<br>
By the way, the #ifdefs are ugly, and could be removed.=C2=A0 (Yes I know<b=
r>
it was me that put the first #ifdef in that function.)<br>
<br>
Paul.<br>
</blockquote><div><br></div><div>Then we can replace get_paca with local_pa=
ca to avoid the warning, right?=C2=A0</div><br><br>-- <br>Regards / Mit bes=
ten Gr=C3=BC=C3=9Fen,<br>Denis<br><br>

--94eb2c092b64e388ed054bdb6e7a--
