Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCWw86pZ2zDrCQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 08:31:20 +1000 (AEST)
Date: Thu, 20 Jul 2017 08:31:12 +1000
In-Reply-To: <20170719194634.GA1222@pacoca>
References: <20170719194634.GA1222@pacoca>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----44PLYYQYFRV5TE9RHBQUNSTD16LXBH"
Subject: Re: KVM guests freeze under upstream kernel
To: joserz@linux.vnet.ibm.com,linuxppc-dev@lists.ozlabs.org
CC: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 oohall@gmail.com
From: Michael Ellerman <michael@ellerman.id.au>
Message-ID: <8B83C9C0-30C8-48A5-A8E9-E8ADFE52EDBE@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------44PLYYQYFRV5TE9RHBQUNSTD16LXBH
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the report=2E

My Jenkins does a test boot of a KVM guest, so there must be something dif=
ferent in our setups=2E Can you tell us all the details of your setup, eg=
=2E Hardware, host kernel, qemu, guest kernel etc=2E Thanks=2E

cheers

On 20 July 2017 05:46:34 GMT+10:00, joserz@linux=2Evnet=2Eibm=2Ecom wrote:
>Hello!
>
>We're not able to boot any KVM guest using upstream kernel
>(cb8c65ccff7f77d0285f1b126c72d37b2572c865 - 4=2E13=2E0-rc1+)=2E
>After reaching the SLOF initial counting, the guest simply freezes:
>
>SLOF
>**********************************************************************
>QEMU Starting
> Build Date =3D Mar  3 2017 13:29:19
>  FW Version =3D git-66d250ef0fd06bb8
>   Press "s" to enter Open Firmware=2E
>
>   C0360
>
>After bisecting I found the commit:
>
>https://github=2Ecom/torvalds/linux/commit/ebd3119
>
>    powerpc/mm: Add devmap support for ppc64
>
>Add support for the devmap bit on PTEs and PMDs for PPC64 Book3S=2E  This
>    is used to differentiate device backed memory from transparent huge
>pages since they are handled in more or less the same manner by the
>core
>    mm code=2E
>
>Reverting the commit and rebuilding 4=2E13=2E0-rc1+ was enough to make a
>workaround=2E
>But I'll need some help from you guys in order to solve it=2E
>
>Thanks!
>
>Jose Ziviani

--=20
Sent from my Android phone with K-9 Mail=2E Please excuse my brevity=2E
------44PLYYQYFRV5TE9RHBQUNSTD16LXBH
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>Thanks for the report=2E<br>
<br>
My Jenkins does a test boot of a KVM guest, so there must be something dif=
ferent in our setups=2E Can you tell us all the details of your setup, eg=
=2E Hardware, host kernel, qemu, guest kernel etc=2E Thanks=2E<br>
<br>
cheers<br><br><div class=3D"gmail_quote">On 20 July 2017 05:46:34 GMT+10:0=
0, joserz@linux=2Evnet=2Eibm=2Ecom wrote:<blockquote class=3D"gmail_quote" =
style=3D"margin: 0pt 0pt 0pt 0=2E8ex; border-left: 1px solid rgb(204, 204, =
204); padding-left: 1ex;">
<pre class=3D"k9mail">Hello!<br /><br />We're not able to boot any KVM gue=
st using upstream kernel (cb8c65ccff7f77d0285f1b126c72d37b2572c865 - 4=2E13=
=2E0-rc1+)=2E<br />After reaching the SLOF initial counting, the guest simp=
ly freezes:<br /><br />SLOF<br />******************************************=
****************************<br />QEMU Starting<br /> Build Date =3D Mar  3=
 2017 13:29:19<br />  FW Version =3D git-66d250ef0fd06bb8<br />   Press &qu=
ot;s&quot; to enter Open Firmware=2E<br /><br />   C0360<br /><br />After b=
isecting I found the commit:<br /><br /><a href=3D"https://github=2Ecom/tor=
valds/linux/commit/ebd3119">https://github=2Ecom/torvalds/linux/commit/ebd3=
119</a><br /><br />    powerpc/mm: Add devmap support for ppc64<br /><br />=
    Add support for the devmap bit on PTEs and PMDs for PPC64 Book3S=2E  Th=
is<br />    is used to differentiate device backed memory from transparent =
huge<br />    pages since they are handled in more or less the same manner =
by the core<br />    mm code=2E<br /><br />Reverting the commit and rebuild=
ing 4=2E13=2E0-rc1+ was enough to make a workaround=2E<br />But I'll need s=
ome help from you guys in order to solve it=2E<br /><br />Thanks!<br /><br =
/>Jose Ziviani<br /><br /></pre></blockquote></div><br>
-- <br>
Sent from my Android phone with K-9 Mail=2E Please excuse my brevity=2E</b=
ody></html>
------44PLYYQYFRV5TE9RHBQUNSTD16LXBH--
