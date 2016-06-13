Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rSlvn2l5ZzDqZV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 18:15:33 +1000 (AEST)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: multipart/alternative;
 boundary=Apple-Mail-D126BB2C-F286-4FA8-A423-D7EE8B53AAE9
Mime-Version: 1.0 (1.0)
Subject: Re: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
Message-Id: <25BBCC66-53B2-4009-B2BA-CD1070EA71E9@xenosoft.de>
Date: Mon, 13 Jun 2016 09:14:33 +0100
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
 <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
 <87d1obqxg9.fsf@skywalker.in.ibm.com>
 <9690f9a4-70c7-8acc-42d0-779bcc93db52@xenosoft.de>
 <66397458-c40a-4e83-c5e5-0ba69fb48986@xenosoft.de>
 <874m99uibc.fsf@skywalker.in.ibm.com>
 <ab51f49d-fc8f-24ce-6763-c641b949971e@xenosoft.de>
 <1465174304.12265.0.camel@ellerman.id.au>
 <50194690-18ac-edfd-42cb-8f1cc96055c9@xenosoft.de>
 <484bd17c3f3.74dd55e@auth.smtp.1and1.co.uk>
 <87r3c71zs9.fsf@skywalker.in.ibm.com>
 <d3753fa2-d88b-2e31-7d0d-d8952c29a12b@xenosoft.de>
 <bab57839-0160-ae01-3cfb-6950067652c0@xenosoft.de>
 <1465470910.31662.10.camel@ellerman.id.au>
 <40816527-1be8-329c-2be0-86c39062c2e9@xenosoft.de>
In-Reply-To: <40816527-1be8-329c-2be0-86c39062c2e9@xenosoft.de>
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Darren Stevens <darren@stevens-zone.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <michaele@au1.ibm.com>,
 Julian Margetson <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>,
 "R.T.Dickinson" <rtd@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Pat Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>,
 "contact@a-eon.com" <contact@a-eon.com>,
 Matthew Leaman <matthew@a-eon.biz>, luigi burdo <intermediadc@hotmail.com>,
 Christian Zigotzky <info@xenosoft.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail-D126BB2C-F286-4FA8-A423-D7EE8B53AAE9
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi All,

Can I disable the new PowerPC features with

Radix MMU Support (PPC_RADIX_MMU) [Y/n/?] (NEW) -> n

?????

I can't compile the RC3 without the PowerPC commits. Our kernel lost the mai=
nline kernel support. Revert of the three PowerPC commits works but the kern=
el doesn't compile anymore.

Cheers,

Christian

Sent from my iPhone

> On 09 Jun 2016, at 14:13, Christian Zigotzky <chzigotzky@xenosoft.de> wrot=
e:
>=20
> Michael,
>=20
> Thank you for your patch. I was able to compile the kernel but unfortunate=
ly it doesn't boot.
>=20
> Do you have another hint or patch for me?
>=20
> Thanks in advance,
>=20
> Christian
>=20
>> On 09 June 2016 at 1:15 PM, Michael Ellerman wrote:
>>> On Thu, 2016-06-09 at 10:48 +0200, Christian Zigotzky wrote:
>>>=20
>>> Shall I modify the workaround? Is the workaround for lack of the device
>>> tree the problem?
>> I don't think so.
>>=20
>> You could try this patch to try and isolate it:
>>=20
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/=
include/asm/book3s/64/pgtable.h
>> index 88a5ecaa157b..ae2f2705e8a0 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -251,7 +251,7 @@ extern unsigned long ioremap_bot;
>>   *  PHB_IO_BASE =3D ISA_IO_BASE + 64K to ISA_IO_BASE + 2G, PHB IO spaces=

>>   * IOREMAP_BASE =3D ISA_IO_BASE + 2G to VMALLOC_START + PGTABLE_RANGE
>>   */
>> -#define KERN_IO_START    (KERN_VIRT_START + (KERN_VIRT_SIZE >> 1))
>> +#define KERN_IO_START    (H_KERN_VIRT_START + (H_KERN_VIRT_SIZE >> 1))
>>  #define FULL_IO_SIZE    0x80000000ul
>>  #define  ISA_IO_BASE    (KERN_IO_START)
>>  #define  ISA_IO_END    (KERN_IO_START + 0x10000ul)
>>=20
>>=20
>> cheers
>=20

--Apple-Mail-D126BB2C-F286-4FA8-A423-D7EE8B53AAE9
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><div>Hi All,</div><div><br></div><div>Can I=
 disable the new PowerPC features with</div><div><br></div><div><span style=3D=
"background-color: rgba(255, 255, 255, 0);">Radix MMU Support (PPC_RADIX_MMU=
) [Y/n/?] (NEW) -&gt; n</span></div><div><span style=3D"background-color: rg=
ba(255, 255, 255, 0);"><br></span></div><div><span style=3D"background-color=
: rgba(255, 255, 255, 0);">?????</span></div><div><span style=3D"background-=
color: rgba(255, 255, 255, 0);"><br></span></div><div><span style=3D"backgro=
und-color: rgba(255, 255, 255, 0);">I can't compile the RC3 without the Powe=
rPC commits. Our kernel lost the mainline kernel support. Revert of the thre=
e PowerPC commits works but the kernel doesn't compile anymore.</span></div>=
<div><span style=3D"background-color: rgba(255, 255, 255, 0);"><br></span></=
div><div><span style=3D"background-color: rgba(255, 255, 255, 0);">Cheers,</=
span></div><div><span style=3D"background-color: rgba(255, 255, 255, 0);"><b=
r></span></div><div><span style=3D"background-color: rgba(255, 255, 255, 0);=
">Christian</span></div><div><font color=3D"#2e8b57" face=3D"Monaco, Andale M=
ono, Courier New, Courier, mono"><span style=3D"font-size: 20px; -webkit-tex=
t-size-adjust: auto; background-color: rgb(255, 255, 255);"><br></span></fon=
t></div><div>Sent from my iPhone</div><div><div><br></div>On 09 Jun 2016, at=
 14:13, Christian Zigotzky &lt;<a href=3D"mailto:chzigotzky@xenosoft.de">chz=
igotzky@xenosoft.de</a>&gt; wrote:<br><br></div><blockquote type=3D"cite"><d=
iv><span>Michael,</span><br><span></span><br><span>Thank you for your patch.=
 I was able to compile the kernel but unfortunately it doesn't boot.</span><=
br><span></span><br><span>Do you have another hint or patch for me?</span><b=
r><span></span><br><span>Thanks in advance,</span><br><span></span><br><span=
>Christian</span><br><span></span><br><span>On 09 June 2016 at 1:15 PM, Mich=
ael Ellerman wrote:</span><br><blockquote type=3D"cite"><span>On Thu, 2016-0=
6-09 at 10:48 +0200, Christian Zigotzky wrote:</span><br></blockquote><block=
quote type=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite">=
<blockquote type=3D"cite"><span>Shall I modify the workaround? Is the workar=
ound for lack of the device</span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>tree the problem?</span><br></b=
lockquote></blockquote><blockquote type=3D"cite"><span>I don't think so.</sp=
an><br></blockquote><blockquote type=3D"cite"><span></span><br></blockquote>=
<blockquote type=3D"cite"><span>You could try this patch to try and isolate i=
t:</span><br></blockquote><blockquote type=3D"cite"><span></span><br></block=
quote><blockquote type=3D"cite"><span>diff --git a/arch/powerpc/include/asm/=
book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h</span><br=
></blockquote><blockquote type=3D"cite"><span>index 88a5ecaa157b..ae2f2705e8=
a0 100644</span><br></blockquote><blockquote type=3D"cite"><span>--- a/arch/=
powerpc/include/asm/book3s/64/pgtable.h</span><br></blockquote><blockquote t=
ype=3D"cite"><span>+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h</span>=
<br></blockquote><blockquote type=3D"cite"><span>@@ -251,7 +251,7 @@ extern u=
nsigned long ioremap_bot;</span><br></blockquote><blockquote type=3D"cite"><=
span> &nbsp;&nbsp;* &nbsp;PHB_IO_BASE =3D ISA_IO_BASE + 64K to ISA_IO_BASE +=
 2G, PHB IO spaces</span><br></blockquote><blockquote type=3D"cite"><span> &=
nbsp;&nbsp;* IOREMAP_BASE =3D ISA_IO_BASE + 2G to VMALLOC_START + PGTABLE_RA=
NGE</span><br></blockquote><blockquote type=3D"cite"><span> &nbsp;&nbsp;*/</=
span><br></blockquote><blockquote type=3D"cite"><span>-#define KERN_IO_START=
 &nbsp; &nbsp;(KERN_VIRT_START + (KERN_VIRT_SIZE &gt;&gt; 1))</span><br></bl=
ockquote><blockquote type=3D"cite"><span>+#define KERN_IO_START &nbsp; &nbsp=
;(H_KERN_VIRT_START + (H_KERN_VIRT_SIZE &gt;&gt; 1))</span><br></blockquote>=
<blockquote type=3D"cite"><span> &nbsp;#define FULL_IO_SIZE &nbsp; &nbsp;0x8=
0000000ul</span><br></blockquote><blockquote type=3D"cite"><span> &nbsp;#def=
ine &nbsp;ISA_IO_BASE &nbsp; &nbsp;(KERN_IO_START)</span><br></blockquote><b=
lockquote type=3D"cite"><span> &nbsp;#define &nbsp;ISA_IO_END &nbsp; &nbsp;(=
KERN_IO_START + 0x10000ul)</span><br></blockquote><blockquote type=3D"cite">=
<span></span><br></blockquote><blockquote type=3D"cite"><span></span><br></b=
lockquote><blockquote type=3D"cite"><span>cheers</span><br></blockquote><blo=
ckquote type=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite=
"><span></span><br></blockquote><span></span><br></div></blockquote></body><=
/html>=

--Apple-Mail-D126BB2C-F286-4FA8-A423-D7EE8B53AAE9--
