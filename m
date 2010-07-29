Return-Path: <dceravigupta@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by ozlabs.org (Postfix) with ESMTP id BA9D6B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 16:16:01 +1000 (EST)
Received: by pzk5 with SMTP id 5so88646pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Jul 2010 23:15:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100728142140.GA9494@richter>
References: <AANLkTikVrftUUC2W+NgWyZi6cc4H4c+mPza9MfsDKuxF@mail.gmail.com>
	<20100728142140.GA9494@richter>
Date: Thu, 29 Jul 2010 11:45:59 +0530
Message-ID: <AANLkTikErKYOEvs-mUQeiMTKTR3GyGK4dEsEGHj2mUdp@mail.gmail.com>
Subject: Re: Memory Mapping Buffers smaller than page size?
From: Ravi Gupta <dceravigupta@gmail.com>
To: Simon Richter <Simon.Richter@hogyros.de>
Content-Type: multipart/alternative; boundary=0016364c654ffff7ad048c80aa7d
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016364c654ffff7ad048c80aa7d
Content-Type: text/plain; charset=ISO-8859-1

Hi Simon,

Thanks for the quick reply. One more thing I want to ask is what if I create
a dma pool (using pci_pool_create()), allocate dma buffers from that pool
and then try to memory map them? will the buffers in that case will be
continuous and is it possible to memory map them in a single user space
page?

Thanks in advance
Ravi Gupta

On Wed, Jul 28, 2010 at 7:51 PM, Simon Richter <Simon.Richter@hogyros.de>wrote:

> Hi,
>
> On Wed, Jul 28, 2010 at 06:44:10PM +0530, Ravi Gupta wrote:
>
> > I am new to linux device drivers development. I have created 16 buffers
> of
> > size 256 bytes each(using kmalloc()) in my device driver code. I want to
> > memory map these buffers to user space. Now is it possible to memory map
> > these buffer(16*256 = 4096 = 1 page on 32 bit linux) into a single page
> in
> > user space OR i have to map them in individual pages in user space? Note,
> > all the buffers may not be stored in continuous memory location.
>
> Pages are the smallest unit for mappings, so each buffer would end up in
> its own mapping. If you want the buffers to be accessible without an
> offset, then you cannot have them in continuous locations, as you cannot
> map memory from the middle of a page to the beginning either.
>
> So your options are: one page per buffer (wasteful, but gives you
> granular access control), or allocating all the buffers as a single
> block.
>
>   Simon
>

--0016364c654ffff7ad048c80aa7d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Simon,<br><br>Thanks for the quick reply. One more thing I want to ask i=
s what if I create a dma pool (using pci_pool_create()), allocate dma=20
buffers from that pool and then try to memory map them? will the buffers=20
in that case will be continuous and is it possible to memory map them in
 a single user space page?<br><br>Thanks in advance<br>Ravi Gupta<br><br><d=
iv class=3D"gmail_quote">On Wed, Jul 28, 2010 at 7:51 PM, Simon Richter <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:Simon.Richter@hogyros.de">Simon.Richte=
r@hogyros.de</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Hi,<br>
<div><div></div><div class=3D"h5"><br>
On Wed, Jul 28, 2010 at 06:44:10PM +0530, Ravi Gupta wrote:<br>
<br>
&gt; I am new to linux device drivers development. I have created 16 buffer=
s of<br>
&gt; size 256 bytes each(using kmalloc()) in my device driver code. I want =
to<br>
&gt; memory map these buffers to user space. Now is it possible to memory m=
ap<br>
&gt; these buffer(16*256 =3D 4096 =3D 1 page on 32 bit linux) into a single=
 page in<br>
&gt; user space OR i have to map them in individual pages in user space? No=
te,<br>
&gt; all the buffers may not be stored in continuous memory location.<br>
<br>
</div></div>Pages are the smallest unit for mappings, so each buffer would =
end up in<br>
its own mapping. If you want the buffers to be accessible without an<br>
offset, then you cannot have them in continuous locations, as you cannot<br=
>
map memory from the middle of a page to the beginning either.<br>
<br>
So your options are: one page per buffer (wasteful, but gives you<br>
granular access control), or allocating all the buffers as a single<br>
block.<br>
<font color=3D"#888888"><br>
 =A0 Simon<br>
</font></blockquote></div><br>

--0016364c654ffff7ad048c80aa7d--
