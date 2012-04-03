Return-Path: <pozzi.fabio@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D8DABB6FE8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2012 21:05:22 +1000 (EST)
Received: by obbef5 with SMTP id ef5so2841455obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2012 04:05:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F74C65A.2000006@freescale.com>
References: <CAP-cLV5pF-j_izadBSVD7p4hQte96O_g2udCxi=9tkaPwxEsaw@mail.gmail.com>
 <4F74AB70.7070209@freescale.com>
 <CAP-cLV5hAT8sp7uxy5o3_NOw5xoAvoz-rV04zB4pmULSp3pXcg@mail.gmail.com>
 <4F74C65A.2000006@freescale.com>
From: Fabio <pozzi.fabio@gmail.com>
Date: Tue, 3 Apr 2012 13:04:48 +0200
Message-ID: <CAP-cLV4VW52fWvTr+6f441Jfr5WkPwtDjDbsoy0anKJbhnYxmQ@mail.gmail.com>
Subject: Re: Help initialize phy-less ethernet in 2.6.38
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Andy Fleming <afleming@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> So it's old arch/ppc stuff. =C2=A0Now fs_platform_info is driver-internal=
 and
> info comes from the device tree. =C2=A0You shouldn't touch the struct dir=
ectly.
Now I moved all the initialization functions to the platform driver in
arch/powerpc/platform/82xx and the external ethernet on FCC2 still
works, so at least it seems that
the problem is related to the fixed-link initialization of FCC1.

>>> Looking at the code, though, I'm not sure if this stuff still works --
>>> e.g. I don't see where any fields of fixed-link but the ID are used, or
>>> what's supposed to happen when of_phy_connect_fixed_link() calls
>>> phy_connect().

The fixed-link fields are used inside arch/powerpc/sysdev/fsl_soc.c in
the function
of_add_fixed_phys.
I'm trying to understand what I am missing to configure or initialize
to get the same behaviour as in the old kernel but I failed to do so
until now.
If you have any suggestion it will be of great help for me.
Thanks in advance



--=20
Fabio Pozzi
