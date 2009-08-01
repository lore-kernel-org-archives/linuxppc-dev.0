Return-Path: <linasvepstas@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5264CB70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  2 Aug 2009 08:56:02 +1000 (EST)
Received: from mail-yw0-f171.google.com (mail-yw0-f171.google.com
	[209.85.211.171]) by ozlabs.org (Postfix) with ESMTP id A1F7CDDDA0
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Aug 2009 08:56:00 +1000 (EST)
Received: by ywh1 with SMTP id 1so3156731ywh.9
	for <linuxppc-dev@ozlabs.org>; Sat, 01 Aug 2009 15:55:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A7221DF.5040402@us.ibm.com>
References: <4A722121.4010307@us.ibm.com> <4A7221DF.5040402@us.ibm.com>
Date: Sat, 1 Aug 2009 17:55:58 -0500
Message-ID: <3ae3aa420908011555r72136e4cy7141f541019f13a3@mail.gmail.com>
Subject: Re: [PATCH 3/3] Support for PCI Express reset type
From: Linas Vepstas <linasvepstas@gmail.com>
To: Mike Mason <mmlnx@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Richard Lary <rlary@us.ibm.com>,
	Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/7/30 Mike Mason <mmlnx@us.ibm.com>:
> This is the third of three patches that implement a bit field that PCI
> Express device drivers can use to indicate they need a fundamental reset
> during error recovery.
>
> By default, the EEH framework on powerpc does what's known as a "hot rese=
t"
> during recovery of a PCI Express device. =C2=A0We've found a case where t=
he
> device needs a "fundamental reset" to recover properly. =C2=A0The current=
 PCI
> error recovery and EEH frameworks do not support this distinction.
>
> The attached patch makes changes to EEH to utilize the new bit field.
>
> These patches supersede the previously submitted patch that implemented a
> fundamental reset bit field.
>
> Please review and let me know of any concerns.
>
> Signed-off-by: Mike Mason <mmlnx@us.ibm.com>
> Signed-off-by: Richard Lary <rlary@us.ibm.com>

Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>

> + =C2=A0 =C2=A0 =C2=A0 /* Determine type of EEH reset required by device,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* default hot reset or fundamental reset
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 if (dev->needs_freset)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtas_pci_slot_reset(pd=
n, 3);
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtas_pci_slot_reset(pd=
n, 1);

Gack!  I remember deluges of emails and conference calls
where the hardware guys went on about this; and I admit I didn't
quite get it, which I guess is why this patch is showing up many
years late.

FWIW some of the variants of the IPR chipset almost surely
need the freset  bit set.

--linas
