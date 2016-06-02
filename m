Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLMJV6qvHzDrbV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 08:26:18 +1000 (AEST)
Received: from mail-oi0-x232.google.com (mail-oi0-x232.google.com
 [IPv6:2607:f8b0:4003:c06::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rLMJV0Dpjz9t84
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Jun 2016 08:26:18 +1000 (AEST)
Received: by mail-oi0-x232.google.com with SMTP id j1so100067182oih.3
 for <linuxppc-dev@ozlabs.org>; Thu, 02 Jun 2016 15:26:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201606010827.u518O0bl023243@mx0a-001b2d01.pphosted.com>
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <57062722.5090706@linux.vnet.ibm.com>
 <5EA48413-85A1-4CB7-8843-CE22B2BB1F08@ellerman.id.au>
 <570B54EB.90507@linux.vnet.ibm.com>
 <1460524468.30704.5.camel@ellerman.id.au>
 <5718F901.6010104@linux.vnet.ibm.com>
 <5748004F.7040408@linux.vnet.ibm.com>
 <1464649951.16938.5.camel@ellerman.id.au>
 <201606010827.u518O0bl023243@mx0a-001b2d01.pphosted.com>
Date: Fri, 3 Jun 2016 08:26:16 +1000
Message-ID: <CAN-ccASsMPA2=rXnCQaDnnzYAFqkMACVyrM-Oz=OH76-SbogCw@mail.gmail.com>
Subject: Re: [PATCH V10 00/28] Add new powerpc specific ELF core notes
From: Cyril Bur <cyrilbur@gmail.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Michael Neuling <mikey@neuling.org>, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, davem@davemloft.net, peterz@infradead.org,
 palves@redhat.com, shuahkh@osg.samsung.com, emachado@linux.vnet.ibm.com,
 dhowells@redhat.com, Ulrich.Weigand@de.ibm.com, kirjanov@gmail.com,
 tglx@linutronix.de, oleg@redhat.com, davej@redhat.com,
 Andrew Morton <akpm@linux-foundation.org>, sukadev@linux.vnet.ibm.com,
 sam.bobroff@au1.ibm.com
Content-Type: multipart/alternative; boundary=001a113de1d4316d6d05345318d5
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a113de1d4316d6d05345318d5
Content-Type: text/plain; charset=UTF-8

On 1 June 2016 at 18:26, Anshuman Khandual <khandual@linux.vnet.ibm.com>
wrote:

> On 05/31/2016 04:42 AM, Michael Ellerman wrote:
> > Hi Laurent,
> >
> > Sorry no. My next branch closed for 4.7 about 3 weeks ago.
> >
> > This series has been blocked for a long time on the gdb support, but
> that is
> > now working. However it still doesn't pass its own selftests, and I had
> some
>
> This series was clearing all of the selftests at the time it was posted.
> But yes, it has some assumptions from timing and sync perspective which
> gets broken some times as the kernel changes. Its been bit difficult to
> perfect the sync requirements as we can do only some much inside the
> transaction once it gets started. There are scopes here to improve these
> selftests but not clearing them today does not really mean the patches are
> now functionally broken.
>
> > disagreements with the implementation - it duplicates a lot of code
> rather
> > than refactoring things.
>
> hmm, sorry, I dont remember the context here. Can you please point to the
> discussion in this regard ?
>
> >
> > I'm waiting on a patch from Cyril which will rework how the TM FP state
> is
> > handled, and that should make this series easier to implement.
>
> Can you please elaborate on this ? Has this patch been posted in the
> mailing
> list ? How does this make it easier for us to implement these ELF notes ?


Hi Anshuman,

I'm doing a bit of a rewrite of the TM handling of the FP/VMX/VSX state.

At the moment is is rather confusing since pt_regs is the always the 'live'
state
and theres a ckpt_regs that is the pt_regs for the checkpointed state.
FPU/VMX/VSX
is done differently which is really only creating confusion so I'm changing
it to do the
same at for pt_regs/ckpt_regs. Ultimately this is part of more work from me
but
Michael has told me that at least this bit is useful now so I'm splitting
it off from
the bigger picture and sending asap. At the very least it will make it
easier to know
what and where the transactional state it and where the checkpointed state
is.

It isn't on the list but I hope I'll get it out today.

Cyril


> >
> > The plan is that both should go into 4.8.
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



-- 
Cyril

--001a113de1d4316d6d05345318d5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 1 June 2016 at 18:26, Anshuman Khandual <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:khandual@linux.vnet.ibm.com" target=3D"_blank">khandual@linux.v=
net.ibm.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span c=
lass=3D"">On 05/31/2016 04:42 AM, Michael Ellerman wrote:<br>
&gt; Hi Laurent,<br>
&gt;<br>
&gt; Sorry no. My next branch closed for 4.7 about 3 weeks ago.<br>
&gt;<br>
&gt; This series has been blocked for a long time on the gdb support, but t=
hat is<br>
&gt; now working. However it still doesn&#39;t pass its own selftests, and =
I had some<br>
<br>
</span>This series was clearing all of the selftests at the time it was pos=
ted.<br>
But yes, it has some assumptions from timing and sync perspective which<br>
gets broken some times as the kernel changes. Its been bit difficult to<br>
perfect the sync requirements as we can do only some much inside the<br>
transaction once it gets started. There are scopes here to improve these<br=
>
selftests but not clearing them today does not really mean the patches are<=
br>
now functionally broken.<br>
<span class=3D""><br>
&gt; disagreements with the implementation - it duplicates a lot of code ra=
ther<br>
&gt; than refactoring things.<br>
<br>
</span>hmm, sorry, I dont remember the context here. Can you please point t=
o the<br>
discussion in this regard ?<br>
<span class=3D""><br>
&gt;<br>
&gt; I&#39;m waiting on a patch from Cyril which will rework how the TM FP =
state is<br>
&gt; handled, and that should make this series easier to implement.<br>
<br>
</span>Can you please elaborate on this ? Has this patch been posted in the=
 mailing<br>
list ? How does this make it easier for us to implement these ELF notes ?=
=C2=A0</blockquote><div><br></div><div>Hi Anshuman,</div><div><br></div><di=
v>I&#39;m doing a bit of a rewrite of the TM handling of the FP/VMX/VSX sta=
te.</div><div><br></div><div>At the moment is is rather confusing since pt_=
regs is the always the &#39;live&#39; state</div><div>and theres a ckpt_reg=
s that is the pt_regs for the checkpointed state. FPU/VMX/VSX</div><div>is =
done differently which is really only creating confusion so I&#39;m changin=
g it to do the</div><div>same at for pt_regs/ckpt_regs. Ultimately this is =
part of more work from me but</div><div>Michael has told me that at least t=
his bit is useful now so I&#39;m splitting it off from</div><div>the bigger=
 picture and sending asap. At the very least it will make it easier to know=
</div><div>what and where the transactional state it and where the checkpoi=
nted state is.</div><div><br></div><div>It isn&#39;t on the list but I hope=
 I&#39;ll get it out today.</div><div><br></div><div>Cyril</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><span class=3D"im HOEnZb">
&gt;<br>
&gt; The plan is that both should go into 4.8.<br>
<br>
</span><div class=3D"HOEnZb"><div class=3D"h5">____________________________=
___________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" rel=3D"noreferre=
r" target=3D"_blank">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></di=
v></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div=
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature">Cyril</div>
</div></div>

--001a113de1d4316d6d05345318d5--
