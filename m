Return-Path: <hongwoo7@gmail.com>
Received: from mail-vw0-f188.google.com (mail-vw0-f188.google.com
	[209.85.212.188])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 19607B7BA9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 16:33:54 +1000 (EST)
Received: by vws26 with SMTP id 26so614753vws.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 01 Sep 2009 23:33:53 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 2 Sep 2009 15:33:53 +0900
Message-ID: <5e2889710909012333q69874b24qf6e3c0abfceb8dfd@mail.gmail.com>
Subject: why do we need reloc_offset ??
From: HongWoo Lee <hongwoo7@gmail.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=001485e76f125f229d0472927307
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001485e76f125f229d0472927307
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi everyone~

In ther linux kernel code, I found the reloc_offset.

{{{
// file : misc.S
/* Returns (address we are running at) - (address we were linked at)
 * for use before the text and data are mapped to KERNELBASE.
 */
_GLOBAL(reloc_offset)
}}}

I couldn't understand the comment saying "Returns (address we are running
at) - (address we were linked at)".
For now, I'm studying each instruction.

And below is best comment I can explain for each instruction.

_GLOBAL(reloc_offset)
        mflr    r0                // move from link register, save the
return address
        bl      1f                 // bl 1f
1:     mflr    r3                // move from link register, r3 is just
return address pointing itself
        LOAD_REG_IMMEDIATE(r4,1b)    // get the 1b address, r4 is the
address
        subf    r3,r4,r3        // r3 =3D r3 =96 r4
        mtlr    r0                // restore return address
        blr

After this, I still don't know why "r3-r4" is the offset.
And what does it mean ??

Please explain to me the reason why we need reloc_offset and the code.
Or let me know any helpful reference about this.

Thank in advance.

HongWoo.

--001485e76f125f229d0472927307
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi everyone~ <br><br>In ther linux kernel code, I found the reloc_offset. <=
br><br>{{{<br>// file : misc.S <br>/* Returns (address we are running at) -=
 (address we were linked at)<br>=A0* for use before the text and data are m=
apped to KERNELBASE.<br>
=A0*/<br>_GLOBAL(reloc_offset)<br>}}}<br><br>I couldn&#39;t understand the =
comment saying &quot;Returns (address we are running at) - (address we were=
 linked at)&quot;. <br>
For now, I&#39;m studying each instruction. <br>
<br>And below is best comment I can explain for each instruction. <br><br>_=
GLOBAL(reloc_offset)<br>=A0=A0=A0=A0=A0=A0=A0 mflr=A0=A0=A0 r0=A0=A0=A0 =A0=
=A0=A0 =A0 =A0 =A0 =A0 // move from link register, save the return address<=
br>=A0=A0=A0=A0=A0=A0=A0 bl=A0=A0=A0=A0=A0 1f=A0=A0=A0 =A0 =A0 =A0 =A0 =A0=
=A0=A0=A0 // bl 1f<br>
1:=A0=A0=A0=A0 mflr=A0=A0=A0 r3 =A0 =A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 // mov=
e from link register, r3 is just return address pointing itself <br>=A0=A0=
=A0=A0=A0=A0=A0 LOAD_REG_IMMEDIATE(r4,1b)=A0=A0=A0 // get the 1b address, r=
4 is the address <br>=A0=A0=A0=A0=A0=A0=A0 subf=A0=A0=A0 r3,r4,r3 =A0=A0 =
=A0=A0=A0 // r3 =3D r3 =96 r4 <br>
=A0=A0=A0=A0=A0=A0=A0 mtlr=A0=A0=A0 r0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=
=A0=A0 // restore return address <br>=A0=A0=A0=A0=A0=A0=A0 blr<br><br>After=
 this, I still don&#39;t know why &quot;r3-r4&quot; is the offset. <br>And =
what does it mean ?? <br><br>Please explain to me the reason why  we need r=
eloc_offset and the code. <br>
Or let me know any helpful reference about this. <br><br>Thank in advance. =
<br><br>HongWoo. <br><br>

--001485e76f125f229d0472927307--
