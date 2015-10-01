Return-Path: <boqun.feng@gmail.com>
Received: from mail-lb0-x233.google.com (mail-lb0-x233.google.com
 [IPv6:2a00:1450:4010:c04::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B05D21A007F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 09:19:08 +1000 (AEST)
Received: by lbcao8 with SMTP id ao8so17845823lbc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2015 16:19:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20151001122802.GR2881@worktop.programming.kicks-ass.net>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-7-git-send-email-boqun.feng@gmail.com>
 <20151001122802.GR2881@worktop.programming.kicks-ass.net>
Date: Fri, 2 Oct 2015 07:19:04 +0800
Message-ID: <CAL0jBu_=w-GDtg6B+YXLmEn=Qac0mnWaWzS6NvLC9KMcNSj8=w@mail.gmail.com>
Subject: Re: [RFC v2 6/7] powerpc: atomic: Make atomic{,64}_xchg and xchg a
 full barrier
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Waiman Long <waiman.long@hp.com>,
 Ingo Molnar <mingo@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: multipart/alternative; boundary=001a11401a64e68ddd0521134500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11401a64e68ddd0521134500
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Please forgive me for the format of my reply. I'm travelling,
and replying from my phone.

2015=E5=B9=B410=E6=9C=881=E6=97=A5 =E4=B8=8B=E5=8D=887:28=EF=BC=8C"Peter Zi=
jlstra" <peterz@infradead.org>=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Sep 16, 2015 at 11:49:34PM +0800, Boqun Feng wrote:
> > According to memory-barriers.txt, xchg and its atomic{,64}_ versions
> > need to imply a full barrier, however they are now just RELEASE+ACQUIRE=
,
> > which is not a full barrier.
> >
> > So remove the definition of xchg(), and let __atomic_op_fence() build
> > the full-barrier versions of these operations.
>
> Do you want to do a patch for -stable fixing the current implementation?

Good idea! I didn't think of this before, and I'd love to do the patch,
but thing is that I'm not able to use my laptop until Oct 10th.
I will send the patch once I'm back.
Does that work for you?

Regards,
Boqun

--001a11401a64e68ddd0521134500
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hi Peter,</p>
<p dir=3D"ltr">Please forgive me for the format of my reply. I&#39;m travel=
ling,<br>
and replying from my phone.</p>
<p dir=3D"ltr">2015=E5=B9=B410=E6=9C=881=E6=97=A5 =E4=B8=8B=E5=8D=887:28=EF=
=BC=8C&quot;Peter Zijlstra&quot; &lt;<a href=3D"mailto:peterz@infradead.org=
">peterz@infradead.org</a>&gt;=E5=86=99=E9=81=93=EF=BC=9A<br>
&gt;<br>
&gt; On Wed, Sep 16, 2015 at 11:49:34PM +0800, Boqun Feng wrote:<br>
&gt; &gt; According to memory-barriers.txt, xchg and its atomic{,64}_ versi=
ons<br>
&gt; &gt; need to imply a full barrier, however they are now just RELEASE+A=
CQUIRE,<br>
&gt; &gt; which is not a full barrier.<br>
&gt; &gt;<br>
&gt; &gt; So remove the definition of xchg(), and let __atomic_op_fence() b=
uild<br>
&gt; &gt; the full-barrier versions of these operations.<br>
&gt;<br>
&gt; Do you want to do a patch for -stable fixing the current implementatio=
n?</p>
<p dir=3D"ltr">Good idea! I didn&#39;t think of this before, and I&#39;d lo=
ve to do the patch,<br>
but thing is that I&#39;m not able to use my laptop until Oct 10th.<br>
I will send the patch once I&#39;m back.<br>
Does that work for you?</p>
<p dir=3D"ltr">Regards,<br>
Boqun</p>

--001a11401a64e68ddd0521134500--
