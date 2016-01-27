Return-Path: <linus971@gmail.com>
Received: from mail-ig0-x229.google.com (mail-ig0-x229.google.com
 [IPv6:2607:f8b0:4001:c05::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F8B61A0174
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 19:05:27 +1100 (AEDT)
Received: by mail-ig0-x229.google.com with SMTP id z14so75549974igp.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 00:05:27 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20160127075129.GH6357@twins.programming.kicks-ass.net>
References: <20160114204827.GE3818@linux.vnet.ibm.com>
 <20160118081929.GA30420@gondor.apana.org.au>
 <20160118154629.GB3818@linux.vnet.ibm.com>
 <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
 <20160126172227.GG6357@twins.programming.kicks-ass.net>
 <CA+55aFzcC6C8imPs5vk4yH1Y2YHjnAdFM9HCkVs04COxuDQH6w@mail.gmail.com>
 <20160126201037.GU4503@linux.vnet.ibm.com>
 <CA+55aFxjb+2rs2wVHtiSCcOzgMrE8H=yDeNcjyujPQudDCtLgw@mail.gmail.com>
 <CA+55aFwxTJd+uibcxtZD3tGnj_n=LMwyAa0s8qyx_OF0OMWQkA@mail.gmail.com>
 <20160127075129.GH6357@twins.programming.kicks-ass.net>
Date: Wed, 27 Jan 2016 00:05:24 -0800
Message-ID: <CA+55aFzb0pppMXSY0ZWVsq2hNooohJsfEUx6zSdxz0A94BnV=Q@mail.gmail.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-metag@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 xen-devel@lists.xenproject.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-sh@vger.kernel.org, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Will Deacon <will.deacon@arm.com>,
 linux-xtensa@linux-xtensa.org, Ingo Molnar <mingo@elte.hu>,
 Ralf Baechle <ralf@linux-mips.org>,
 uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 linux-mips <linux-mips@linux-mips.org>,
 David Miller <davem@davemloft.net>, Andrew Cooper <andrew.cooper3@citrix.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Ingo Molnar <mingo@kernel.org>,
 adi-buildroot-devel@lists.sourceforge.net,
 Michael Ellerman <mpe@ellerman.id.au>, James Hogan <james.hogan@imgtec.com>,
 Joe Perches <joe@perches.com>, Peter Anvin <hpa@zytor.com>,
 David Daney <ddaney.cavm@gmail.com>,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, sparclinux@vger.kernel.org
Content-Type: multipart/alternative; boundary=089e01184ac2b275bb052a4c4361
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--089e01184ac2b275bb052a4c4361
Content-Type: text/plain; charset=UTF-8

On Jan 26, 2016 23:51, "Peter Zijlstra" <peterz@infradead.org> wrote:
>
> So for a moment it looked like MIPS wanted to equal or surpass Alpha in
> this respect.

If there is an architecture that I'd expect to try to take the "sucks more"
crown, MIPS would be it. They've already done the "worst cache award"
thing, and are proud members of the "stupid branch delay slot" crowd. MIPS
historically even did the "delayed load slot".

The only mistake they've never done, AFAIK, is to have a rotating register
file.

At the same time, the "load-to-dependent-store" thing you really have to
*work* at doing wrong. It's not enough to just have bad taste and
incompetent architects. You really have to spend real effort to screw up
that badly. It's really hard to do by mistake.

So I suspect that even MIPS can't get it wrong.

   Linus

--089e01184ac2b275bb052a4c4361
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Jan 26, 2016 23:51, &quot;Peter Zijlstra&quot; &lt;<a href=3D"mailto:pet=
erz@infradead.org">peterz@infradead.org</a>&gt; wrote:<br>
&gt;<br>
&gt; So for a moment it looked like MIPS wanted to equal or surpass Alpha i=
n<br>
&gt; this respect.</p>
<p dir=3D"ltr">If there is an architecture that I&#39;d expect to try to ta=
ke the &quot;sucks more&quot; crown, MIPS would be it. They&#39;ve already =
done the &quot;worst cache award&quot; thing, and are proud members of the =
&quot;stupid branch delay slot&quot; crowd. MIPS historically even did the =
&quot;delayed load slot&quot;.</p>
<p dir=3D"ltr">The only mistake they&#39;ve never done, AFAIK, is to have a=
 rotating register file. </p>
<p dir=3D"ltr">At the same time, the &quot;load-to-dependent-store&quot; th=
ing you really have to *work* at doing wrong. It&#39;s not enough to just h=
ave bad taste and incompetent architects. You really have to spend real eff=
ort to screw up that badly. It&#39;s really hard to do by mistake.</p>
<p dir=3D"ltr">So I suspect that even MIPS can&#39;t get it wrong. </p>
<p dir=3D"ltr">=C2=A0=C2=A0 Linus</p>

--089e01184ac2b275bb052a4c4361--
