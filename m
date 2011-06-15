Return-Path: <tmarri@apm.com>
Received: from exprod5og104.obsmtp.com (exprod5og104.obsmtp.com [64.18.0.178])
	by ozlabs.org (Postfix) with SMTP id 2EBA9B6F94
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2011 02:07:36 +1000 (EST)
Received: by pzk9 with SMTP id 9so362817pzk.19
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 09:07:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4DF8C453.70500@in.ibm.com>
References: <4DF74E5D.9020908@monstr.eu> <4DF84D92.2030803@in.ibm.com>
	<1308132715.2516.1.camel@pasglop> <4DF8C453.70500@in.ibm.com>
Date: Wed, 15 Jun 2011 09:02:21 -0700
Message-ID: <BANLkTimR95gM_w07=7L5h1E03nPPQYdJ6w@mail.gmail.com>
Subject: Re: Relocatable kernel for ppc44x
From: Tirumala Marri <tmarri@apm.com>
To: Suzuki Poulose <suzuki@in.ibm.com>
Content-Type: multipart/alternative; boundary=bcaec520f7d9104fd404a5c24725
Cc: monstr@monstr.eu, John Williams <john.williams@petalogix.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--bcaec520f7d9104fd404a5c24725
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Jun 15, 2011 at 7:40 AM, Suzuki Poulose <suzuki@in.ibm.com> wrote:

> On 06/15/11 15:41, Benjamin Herrenschmidt wrote:
>
>> On Wed, 2011-06-15 at 11:43 +0530, Suzuki Poulose wrote:
>>
>>> On 06/14/11 17:34, Michal Simek wrote:
>>>
>>>> Hi,
>>>>
>>>> have someone tried to support RELOCATABLE kernel on ppc44x?
>>>>
>>> As Josh, mentioned, I will be working on this. In fact I was trying a
>>> couple of
>>> patches towards this on PPC440x. But, I am stuck in debugging the hang
>>> that I am
>>> experiencing with the changes. I am setting up a RISCWatch processor
>>> probe to
>>> debug the same.
>>>
>>> Here is some information that I wanted to share :
>>>
>>> The PPC440X currently uses 256M TLB entries to pin the lowmem. When we go
>>> for a
>>> relocatable kernel we have to :
>>>
>>> 1) Restrict the kernel load address to be 256M aligned
>>>
>>
>> Wait a minute ... :-)
>>
>> There's a difference between having the kernel run from any address and
>> mapping the linear mapping not starting at 0.
>>
>> Those are completely orthogonal.
>>
>> I don't see why off hand you are changing the way the TLB is used.
>>
>
> I started off with PHYSICAL_START support and that kind of hogged me into
> this approach :-).
>
> The
>
>> only possible change needed is to make sure the initial bolted entry set
>> by the asm code properly covers the kernel in whatever it's "current"
>> location is. The rest is a matter of fixing up the relocations...
>>
> Could we do something like,
>
> If kernel is loaded at X,
>
> 1. map : ((X-1) & ~256M) to PAGE_OFFSET and so on to cover the kernel in
> 256M
> chunks.
> 2. Then process the relocations with (X % 256M)
>
> Thanks
>
> [marri] I had to deal with kernel relocation to non-zero physical address.
I  hacked
few places to make this work. In my case there were holes(mutliple of 250MB)
in
the low-memory region.  To handle these memory holes I manipulated "lmb"
structure.

 I had to depend on the bootloader making sure that it is running from
non-zero
physical address and during linux boot it checks for the current TLB where
it is
running from and creates the same new TLB in linux. And everything else
should
take care of it.

--marri

--bcaec520f7d9104fd404a5c24725
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Jun 15, 2011 at 7:40 AM, Suzuki =
Poulose <span dir=3D"ltr">&lt;<a href=3D"mailto:suzuki@in.ibm.com">suzuki@i=
n.ibm.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">On 06/15/11 15:41, Benjamin Herrenschmidt wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Wed, 2011-06-15 at 11:43 +0530, Suzuki Poulose wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 06/14/11 17:34, Michal Simek wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi,<br>
<br>
have someone tried to support RELOCATABLE kernel on ppc44x?<br>
</blockquote>
As Josh, mentioned, I will be working on this. In fact I was trying a coupl=
e of<br>
patches towards this on PPC440x. But, I am stuck in debugging the hang that=
 I am<br>
experiencing with the changes. I am setting up a RISCWatch processor probe =
to<br>
debug the same.<br>
<br>
Here is some information that I wanted to share :<br>
<br>
The PPC440X currently uses 256M TLB entries to pin the lowmem. When we go f=
or a<br>
relocatable kernel we have to :<br>
<br>
1) Restrict the kernel load address to be 256M aligned<br>
</blockquote>
<br>
Wait a minute ... :-)<br>
<br>
There&#39;s a difference between having the kernel run from any address and=
<br>
mapping the linear mapping not starting at 0.<br>
<br>
Those are completely orthogonal.<br>
<br>
I don&#39;t see why off hand you are changing the way the TLB is used.<br>
</blockquote>
<br></div>
I started off with PHYSICAL_START support and that kind of hogged me into<b=
r>
this approach :-).<div class=3D"im"><br>
The<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
only possible change needed is to make sure the initial bolted entry set<br=
>
by the asm code properly covers the kernel in whatever it&#39;s &quot;curre=
nt&quot;<br>
location is. The rest is a matter of fixing up the relocations...<br>
</blockquote></div>
Could we do something like,<br>
<br>
If kernel is loaded at X,<br>
<br>
1. map : ((X-1) &amp; ~256M) to PAGE_OFFSET and so on to cover the kernel i=
n 256M<br>
chunks.<br>
2. Then process the relocations with (X % 256M)<br>
<br>
Thanks<br><font color=3D"#888888">
<br></font></blockquote><div>[marri] I had to deal with kernel relocation t=
o non-zero physical address. I =A0hacked</div><div>few places to make this =
work. In my case there were holes(mutliple of 250MB) in</div><div>the low-m=
emory region.=A0=A0To handle these memory holes I manipulated &quot;lmb&quo=
t; structure.</div>
<div><br></div><div>=A0I had to depend on the bootloader making sure that i=
t is running from non-zero</div><div>physical address and during linux boot=
 it checks for the current TLB where it is=A0</div><div>running from and cr=
eates the same new TLB in linux. And everything else should</div>
<div>take care of it.</div><div><br></div><div>--marri</div><div><br></div>=
<div><br></div><div><br></div></div>

--bcaec520f7d9104fd404a5c24725--
