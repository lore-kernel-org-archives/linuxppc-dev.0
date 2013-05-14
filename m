Return-Path: <michael.neuling@gmail.com>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C64F2C00A5
 for <linuxppc-dev@ozlabs.org>; Tue, 14 May 2013 11:25:01 +1000 (EST)
Received: by mail-pd0-f176.google.com with SMTP id x10so4832761pdj.21
 for <linuxppc-dev@ozlabs.org>; Mon, 13 May 2013 18:25:00 -0700 (PDT)
MIME-Version: 1.0
Sender: michael.neuling@gmail.com
In-Reply-To: <20130514110924.091b7177d22d69e19478a134@canb.auug.org.au>
References: <1368220707.3378.57.camel@shinybook.infradead.org>
 <9813.1368428999@ale.ozlabs.ibm.com>
 <20130514110924.091b7177d22d69e19478a134@canb.auug.org.au>
Date: Tue, 14 May 2013 11:25:00 +1000
Message-ID: <CAEjGV6yR+GSwu_CZWSLrL8q8D-AM7yi3685fq9vgjt9MN7HPTA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: provide __bswapdi2
From: Michael Neuling <mikey@neuling.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: multipart/alternative; boundary=047d7b62485a7e2d9a04dca38074
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 David Woodhouse <dwmw2@infradead.org>, viro@zeniv.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b62485a7e2d9a04dca38074
Content-Type: text/plain; charset=ISO-8859-1

On 14 May 2013 11:09, "Stephen Rothwell" <sfr@canb.auug.org.au> wrote:
>
> Hi Mikey,
>
> On Mon, 13 May 2013 17:09:59 +1000 Michael Neuling <mikey@neuling.org>
wrote:
> >
> > This doesn't work for me but the below does:
> >
> > _GLOBAL(__bswapdi2)
> >       rotlwi  r9,r4,8
> >       rotlwi  r10,r3,8
> >       rlwimi  r9,r4,24,0,7
> >       rlwimi  r10,r3,24,0,7
> >       rlwimi  r9,r4,24,16,23
> >       rlwimi  r10,r3,24,16,23
> >       mr      r4,r10
> >       mr      r3,r9
> >       blr
> >
> > stolen from GCC -02 output of:
> >   unsigned long long __bswapdi2(unsigned long long x)
> >   {
> >        return ((x & 0x00000000000000ffULL) << 56) |
> >               ((x & 0x000000000000ff00ULL) << 40) |
> >               ((x & 0x0000000000ff0000ULL) << 24) |
> >               ((x & 0x00000000ff000000ULL) <<  8) |
> >               ((x & 0x000000ff00000000ULL) >>  8) |
> >               ((x & 0x0000ff0000000000ULL) >> 24) |
> >               ((x & 0x00ff000000000000ULL) >> 40) |
> >               ((x & 0xff00000000000000ULL) >> 56);
> >   }
>
> So, if we are just stealing the output of gcc, why not just use the C
> version (at least for 32 bit)?

Woodhouse: can we just do this?

Mikey

--047d7b62485a7e2d9a04dca38074
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On 14 May 2013 11:09, &quot;Stephen Rothwell&quot; &lt;<a href=3D"mailto:sf=
r@canb.auug.org.au">sfr@canb.auug.org.au</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Mikey,<br>
&gt;<br>
&gt; On Mon, 13 May 2013 17:09:59 +1000 Michael Neuling &lt;<a href=3D"mail=
to:mikey@neuling.org">mikey@neuling.org</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; This doesn&#39;t work for me but the below does:<br>
&gt; &gt;<br>
&gt; &gt; _GLOBAL(__bswapdi2)<br>
&gt; &gt; =A0 =A0 =A0 rotlwi =A0r9,r4,8<br>
&gt; &gt; =A0 =A0 =A0 rotlwi =A0r10,r3,8<br>
&gt; &gt; =A0 =A0 =A0 rlwimi =A0r9,r4,24,0,7<br>
&gt; &gt; =A0 =A0 =A0 rlwimi =A0r10,r3,24,0,7<br>
&gt; &gt; =A0 =A0 =A0 rlwimi =A0r9,r4,24,16,23<br>
&gt; &gt; =A0 =A0 =A0 rlwimi =A0r10,r3,24,16,23<br>
&gt; &gt; =A0 =A0 =A0 mr =A0 =A0 =A0r4,r10<br>
&gt; &gt; =A0 =A0 =A0 mr =A0 =A0 =A0r3,r9<br>
&gt; &gt; =A0 =A0 =A0 blr<br>
&gt; &gt;<br>
&gt; &gt; stolen from GCC -02 output of:<br>
&gt; &gt; =A0 unsigned long long __bswapdi2(unsigned long long x)<br>
&gt; &gt; =A0 {<br>
&gt; &gt; =A0 =A0 =A0 =A0return ((x &amp; 0x00000000000000ffULL) &lt;&lt; 5=
6) |<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((x &amp; 0x000000000000ff00ULL) &lt;=
&lt; 40) |<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((x &amp; 0x0000000000ff0000ULL) &lt;=
&lt; 24) |<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((x &amp; 0x00000000ff000000ULL) &lt;=
&lt; =A08) |<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((x &amp; 0x000000ff00000000ULL) &gt;=
&gt; =A08) |<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((x &amp; 0x0000ff0000000000ULL) &gt;=
&gt; 24) |<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((x &amp; 0x00ff000000000000ULL) &gt;=
&gt; 40) |<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((x &amp; 0xff00000000000000ULL) &gt;=
&gt; 56);<br>
&gt; &gt; =A0 }<br>
&gt;<br>
&gt; So, if we are just stealing the output of gcc, why not just use the C<=
br>
&gt; version (at least for 32 bit)?</p>
<p dir=3D"ltr">Woodhouse: can we just do this?</p>
<p dir=3D"ltr">Mikey =A0 =A0 </p>

--047d7b62485a7e2d9a04dca38074--
