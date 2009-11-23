Return-Path: <vinayak.kale@gmail.com>
Received: from mail-vw0-f230.google.com (mail-vw0-f230.google.com
	[209.85.212.230]) by ozlabs.org (Postfix) with ESMTP id E224F1007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 18:29:38 +1100 (EST)
Received: by vws19 with SMTP id 19so105812vws.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 23:29:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <001636832accdcc8a40479024c96@google.com>
Message-ID: <0016e646923c937a80047904c936@google.com>
Date: Mon, 23 Nov 2009 07:29:35 +0000
Subject: Re: Fwd: Re: DTS for PowerPC 440 based board
From: vinayak.kale@gmail.com
To: david@gibson.dropbear.id.au, grant.likely@secretlab.ca,
	Vinayak Kale <vinayak.kale@gmail.com>
Content-Type: multipart/alternative; boundary=0016e646923c937a6f047904c933
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e646923c937a6f047904c933
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes

Hi,

David, Grant thank you for providing the info.
 From your reply and the other sources what I gather is as below. Please  
confirm whether I am on the right track.

1) Bootloader passing BDInfo:
Here, I have to create a .dts file inside /arch/powerpc/boot/dts directory.  
dtc compiles the .dts file and creates a dtb. The kernel, dtb and  
boot-wrapper are then embedded in a cuImage.* file after make. We need to  
write the platform-specific fix-ups in the cuboot-*.c file. The bootloader  
will pass BDInfo struct to kernel. The kernel will also receive the dtb.
The only kernel changes we need to do here are fixups in cuboot-*.c and  
creation of .dts file.

2) Bootloader passing DT:
Here, the booloader will directly pass the DT instead of BDInfo. The  
platform-specific code in simpleboot.c will get excuted. We don't have to  
do any fixups inside kernel here.
I have queries with this approach -
a) In this case, who creates DT? Do we need to use any tools to create a  
DT? or it can be created the same way by compiling the .dts file using dtc?
b) From previous implementaions of other boards, I didn't see any platform  
specific fix-ups inside kernel being done? Why is so that in case of BDInfo  
we need fix-ups and here we don't?


Please confirm my understanding of above to approaches. Also please suggest  
which way is better.

Regards,
Vinayak

----------------------------------------------------------------------------------------------------
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, Nov 22, 2009 at 2:50 AM
Subject: Re: DTS for PowerPC 440 based board
To: Vinayak Kale <vinayak.kale@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org



On Sun, Nov 22, 2009 at 12:16:59AM +0530, Vinayak Kale wrote:
> Hi,
> I am porting 2.6.31 for a PowerPC 440 core based board. I have couple of
> queries. I would really appreciate if someone could answer since i  
> couldn't
> find info from other places.

> 1) Is it mandatory to create a DTS file?


Roughly speaking, yes. You have to supply a device tree to the
kernel somehow, so if the firmware doesn't supply one itself, you will
need to create a DTS.


> 2) If uboot passes BDInfo struct to kernel instead of DT blob, then in  
> this
> case does kernel creates FDT at run time?


Not exactly. In this case the bootwrapper will be built with an FDT
(compiled from a dts) built in. It will however tweak the FDT with
information from the BDInfo before booting the kernel proper.


> 3) I believe in case of DTS, the kernel picks up the h/w info from DTS  
> blob
> so we need not hardcode any register addresses etc inside kernel other  
> than
> in dts file. What happens in case of uboot passing just BDInfo struct. How
> do we specify the register addresses etc?


There's always a device tree which specifies register addresses. If
the firmware only supplies a BDInfo, then the kernel wrapper must have
a device tree built in. In practice that will always be built from a
dts, though it doesn't have to be in theory.

--
David Gibson | I'll have my music baroque, and my code
david AT gibson.dropbear.id.au | minimalist, thank you. NOT _the_ _other_
| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0016e646923c937a6f047904c933
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,
<br />
<br />David, Grant thank you for providing the info.
<br />From your reply and the other sources what I gather is as below. Plea=
se confirm whether I am on the right track.
<br />
<br />1) Bootloader passing BDInfo: =20
<br />Here, I have to create a .dts file inside /arch/powerpc/boot/dts dire=
ctory. dtc compiles the .dts file and creates a dtb. The kernel, dtb and bo=
ot-wrapper are then embedded in a cuImage.* file after make. We need to wri=
te the platform-specific fix-ups in the cuboot-*.c file. The bootloader wil=
l pass BDInfo struct to kernel. The kernel will also receive the dtb.
<br />The only kernel changes we need to do here are fixups in cuboot-*.c a=
nd creation of .dts file.=20
<br />
<br />2) Bootloader passing DT:
<br />Here, the booloader will directly pass the DT instead of BDInfo. The =
platform-specific code in simpleboot.c will get excuted. We don&#39;t have =
to do any fixups inside kernel here.=20
<br />I have queries with this approach -
<br />a) In this case, who creates DT? Do we need to use any tools to creat=
e a DT? or it can be created the same way by compiling the .dts file using =
dtc?=20
<br />b) From previous implementaions of other boards, I didn&#39;t see any=
 platform specific fix-ups inside kernel being done? Why is so that in case=
 of BDInfo we need fix-ups and here we don&#39;t?
<br />
<br />
<br />Please confirm my understanding of above to approaches. Also please s=
uggest which way is better.
<br />
<br />Regards,
<br />Vinayak
<br />=20
<br />---------------------------------------------------------------------=
-------------------------------
<br />From: David Gibson &lt;david@gibson.dropbear.id.au&gt;
<br />Date: Sun, Nov 22, 2009 at 2:50 AM
<br />Subject: Re: DTS for PowerPC 440 based board
<br />To: Vinayak Kale &lt;vinayak.kale@gmail.com&gt;
<br />Cc: linuxppc-dev@lists.ozlabs.org
<br />
<br />
<br />
<br />On Sun, Nov 22, 2009 at 12:16:59AM +0530, Vinayak Kale wrote:
<br />&gt; Hi,
<br />&gt; I am porting 2.6.31 for a PowerPC 440 core based board. I have c=
ouple of
<br />&gt; queries. I would really appreciate if someone could answer since=
 i couldn&#39;t
<br />&gt; find info from other places.
<br />&gt;
<br />&gt; 1) Is it mandatory to create a DTS file?
<br />
<br />
<br />Roughly speaking, yes.  You have to supply a device tree to the
<br />kernel somehow, so if the firmware doesn&#39;t supply one itself, you=
 will
<br />need to create a DTS.
<br />
<br />
<br />&gt; 2) If uboot passes BDInfo struct to kernel instead of DT blob, t=
hen in this
<br />&gt; case does kernel creates FDT at run time?
<br />
<br />
<br />Not exactly.  In this case the bootwrapper will be built with an FDT
<br />(compiled from a dts) built in.  It will however tweak the FDT with
<br />information from the BDInfo before booting the kernel proper.
<br />
<br />
<br />&gt; 3) I believe in case of DTS, the kernel picks up the h/w info fr=
om DTS blob
<br />&gt; so we need not hardcode any register addresses etc inside kernel=
 other than
<br />&gt; in dts file. What happens in case of uboot passing just BDInfo s=
truct. How
<br />&gt; do we specify the register addresses etc?
<br />
<br />
<br />There&#39;s always a device tree which specifies register addresses. =
 If
<br />the firmware only supplies a BDInfo, then the kernel wrapper must hav=
e
<br />a device tree built in.  In practice that will always be built from a
<br />dts, though it doesn&#39;t have to be in theory.
<br />
<br />--
<br />David Gibson                    | I&#39;ll have my music baroque, and=
 my code
<br />david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _=
other_
<br />                               | _way_ _around_!
<br />http://www.ozlabs.org/~dgibson
--0016e646923c937a6f047904c933--
