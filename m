Return-Path: <michael.neuling@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZ0sc1sdszDsW4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 22:17:08 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id z143so873456qka.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 05:17:08 -0700 (PDT)
MIME-Version: 1.0
Sender: michael.neuling@gmail.com
In-Reply-To: <20160914221222.57e84324@roar.ozlabs.ibm.com>
References: <20160914080216.13833-1-cyrilbur@gmail.com>
 <20160914212824.4936a9a2@roar.ozlabs.ibm.com>
 <1473853599.22937.85.camel@neuling.org>
 <20160914221222.57e84324@roar.ozlabs.ibm.com>
From: Michael Neuling <mikey@neuling.org>
Date: Wed, 14 Sep 2016 22:17:04 +1000
Message-ID: <CAEjGV6wLp6-YyV2iD8FFAjrH+57xZxjUECA2WGu=jt8xa22EuA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Enable MSR_TM lazily
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Anton Blanchard <anton@samba.org>, wei.guo.simon@gmail.com,
 Carlos Eduardo Seo <cseo@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, Cyril Bur <cyrilbur@gmail.com>
Content-Type: multipart/alternative; boundary=94eb2c05a8780ec368053c76b5ae
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c05a8780ec368053c76b5ae
Content-Type: text/plain; charset=UTF-8

On 14 Sep. 2016 10:12 pm, "Nicholas Piggin" <npiggin@gmail.com> wrote:
>
> On Wed, 14 Sep 2016 21:46:39 +1000
> Michael Neuling <mikey@neuling.org> wrote:
>
> > On Wed, 2016-09-14 at 21:28 +1000, Nicholas Piggin wrote:
> > > Cc'ing Carlos
> > >
> > > On Wed, 14 Sep 2016 18:02:14 +1000

> > I think we might be able to detect this case in the kernel. If it's a
tabort
> > that's trapped on, we can't have been transactional.  Hence we can
safely PC+=4
> > and leave off TM off.
> >
> > It would cost us a get_user(inst, regs->nip); but it might be worth it
for this
> > special but common case.
>
> That would take an extra trap for every syscall, I think.

You're right. That wouldn't work.

Mikey

--94eb2c05a8780ec368053c76b5ae
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On 14 Sep. 2016 10:12 pm, &quot;Nicholas Piggin&quot; &lt;<a=
 href=3D"mailto:npiggin@gmail.com">npiggin@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Wed, 14 Sep 2016 21:46:39 +1000<br>
&gt; Michael Neuling &lt;<a href=3D"mailto:mikey@neuling.org">mikey@neuling=
.org</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; On Wed, 2016-09-14 at 21:28 +1000, Nicholas Piggin wrote:<br>
&gt; &gt; &gt; Cc&#39;ing Carlos<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, 14 Sep 2016 18:02:14 +1000</p>
<p dir=3D"ltr">&gt; &gt; I think we might be able to detect this case in th=
e kernel. If it&#39;s a tabort<br>
&gt; &gt; that&#39;s trapped on, we can&#39;t have been transactional.=C2=
=A0 Hence we can safely PC+=3D4<br>
&gt; &gt; and leave off TM off.=C2=A0<br>
&gt; &gt;<br>
&gt; &gt; It would cost us a get_user(inst, regs-&gt;nip); but it might be =
worth it for this<br>
&gt; &gt; special but common case.<br>
&gt;<br>
&gt; That would take an extra trap for every syscall, I think.</p>
<p dir=3D"ltr">You&#39;re right. That wouldn&#39;t work.</p>
<p dir=3D"ltr">Mikey<br></p>

--94eb2c05a8780ec368053c76b5ae--
