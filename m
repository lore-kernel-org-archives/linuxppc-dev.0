Return-Path: <bsingharora@gmail.com>
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com
 [IPv6:2a00:1450:400c:c09::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcssP6ZkBzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 21:12:25 +1100 (AEDT)
Received: by mail-wm0-x233.google.com with SMTP id v186so85361035wmd.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Mar 2017 02:12:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170307003931.20568-1-cyrilbur@gmail.com>
References: <20170307003931.20568-1-cyrilbur@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 7 Mar 2017 21:12:22 +1100
Message-ID: <CAKTCnzmNyywxdQXDssSEP5goF_EBJaj8zm1b-oLrGyPEGfbJeA@mail.gmail.com>
Subject: Re: [PATCH] selftests/powerpc: Replace stxvx and lxvx with their
 equivalent instruction
To: Cyril Bur <cyrilbur@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=94eb2c06d0ec8061a8054a213fd2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c06d0ec8061a8054a213fd2
Content-Type: text/plain; charset=UTF-8

On 07-Mar-2017 11:43 AM, "Cyril Bur" <cyrilbur@gmail.com> wrote:

On POWER8 (ISA 2.07) lxvx and stxvx are defined to be extended mnemonics
of lxvd2x and stxvd2x. For POWER9 (ISA 3.0) the HW architects in their
infinite wisdom made lxvx and stxvx instructions in their own right.

POWER9 aware GCC will use the POWER9 instruction for lxvx and stxvx
causing these selftests to fail on POWER8. Further compounding the
issue, because of the way -mvsx works it will cause the power9
instructions to be used regardless of -mcpu=power8 to GCC or -mpower8 to
AS.

The safest way to address the problem for now is to not use the extended
mnemonic. These tests only perform register comparisons the big endian
only byte ordering for stxvd2x and lxvd2x does not impact the test.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---



Acked-by: Balbir Singh<bsingharora@gmail.com>

--94eb2c06d0ec8061a8054a213fd2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On 07-Mar-2017 11:43 AM, &quot;Cyril Bur&quot; &lt;<a href=3D"mai=
lto:cyrilbur@gmail.com">cyrilbur@gmail.com</a>&gt; wrote:<br type=3D"attrib=
ution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">On POWER8 (ISA 2.07) lxvx and stxvx are def=
ined to be extended mnemonics<br>
of lxvd2x and stxvd2x. For POWER9 (ISA 3.0) the HW architects in their<br>
infinite wisdom made lxvx and stxvx instructions in their own right.<br>
<br>
POWER9 aware GCC will use the POWER9 instruction for lxvx and stxvx<br>
causing these selftests to fail on POWER8. Further compounding the<br>
issue, because of the way -mvsx works it will cause the power9<br>
instructions to be used regardless of -mcpu=3Dpower8 to GCC or -mpower8 to<=
br>
AS.<br>
<br>
The safest way to address the problem for now is to not use the extended<br=
>
mnemonic. These tests only perform register comparisons the big endian<br>
only byte ordering for stxvd2x and lxvd2x does not impact the test.<br>
<br>
Signed-off-by: Cyril Bur &lt;<a href=3D"mailto:cyrilbur@gmail.com">cyrilbur=
@gmail.com</a>&gt;<br>
---<br>=C2=A0=C2=A0</blockquote></div></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Acked-by: Balbir Singh&lt;<a href=3D"mailto:bsingharor=
a@gmail.com">bsingharora@gmail.com</a>&gt;</div></div>

--94eb2c06d0ec8061a8054a213fd2--
