Return-Path: <pozzi.fabio@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 06C05B6EEF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2012 06:56:49 +1100 (EST)
Received: by obbun3 with SMTP id un3so3366768obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2012 12:56:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F74AB70.7070209@freescale.com>
References: <CAP-cLV5pF-j_izadBSVD7p4hQte96O_g2udCxi=9tkaPwxEsaw@mail.gmail.com>
 <4F74AB70.7070209@freescale.com>
From: Fabio <pozzi.fabio@gmail.com>
Date: Thu, 29 Mar 2012 21:56:15 +0200
Message-ID: <CAP-cLV5hAT8sp7uxy5o3_NOw5xoAvoz-rV04zB4pmULSp3pXcg@mail.gmail.com>
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

> Which old kernel driver? =C2=A0Why do you need to mess with fs_platform_i=
nfo?
I have to port a custom platform driver written for 2.6.10 to support
this custom board.
That driver directly initializes the fs_platform_info data structure,
so after some failed attempts I thought to directly assign some values
to the fs_platform_info structure to see reuse part of the old code,
just to get the device to work.

> Why do you think the interrupt is misconfigured?
Because I don't get any error during boot or when I run ifconfig, but
I don't see
any interrupt if I run 'cat /proc/interrupts':
---
           CPU0
 16:        136   CPM2 SIU         Level        cpm_uart
 32:          0   CPM2 SIU         Level        fs_enet-mac
LOC:       1219   Local timer interrupts
SPU:          0   Spurious interrupts
CNT:          0   Performance monitoring interrupts
MCE:          0   Machine check exceptions
----

>Looking at the code, though, I'm not sure if this stuff still works --
>e.g. I don't see where any fields of fixed-link but the ID are used, or
>what's supposed to happen when of_phy_connect_fixed_link() calls
>phy_connect().
If it isn't so, do you have any suggestion about how to re-add this
functionality to the existing code?

I will make some other tests taking as an example the mgcoge.dts which
seems the most similar to my custom board.

Thanks in advance,

--=20
Fabio Pozzi
