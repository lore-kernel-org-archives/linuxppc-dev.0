Return-Path: <linasvepstas@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 23E0CB70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 00:44:38 +1000 (EST)
Received: from mail-yx0-f199.google.com (mail-yx0-f199.google.com
	[209.85.210.199]) by ozlabs.org (Postfix) with ESMTP id 738A3DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 00:44:34 +1000 (EST)
Received: by yxe37 with SMTP id 37so1629917yxe.17
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 07:44:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A5E23D0.9020906@us.ibm.com>
References: <4A5CCFDF.7000901@us.ibm.com> <4A5E23D0.9020906@us.ibm.com>
Date: Thu, 23 Jul 2009 09:44:33 -0500
Message-ID: <3ae3aa420907230744ya3a9342w4f29e150b3b5658f@mail.gmail.com>
Subject: Re: [PATCH] Support for PCI Express reset type in EEH
From: Linas Vepstas <linasvepstas@gmail.com>
To: Mike Mason <mmlnx@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Richard Lary <rlary@us.ibm.com>, linux-pci@vger.kernel.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/7/15 Mike Mason <mmlnx@us.ibm.com>:
> By default, EEH does what's known as a "hot reset" during error recovery =
of
> a PCI Express device. =C2=A0We've found a case where the device needs a
> "fundamental reset" to recover properly. =C2=A0The current PCI error reco=
very and
> EEH frameworks do not support this distinction.
>
> The attached patch (courtesy of Richard Lary) adds a bit field to pci_dev
> that indicates whether the device requires a fundamental reset during err=
or
> recovery. =C2=A0This bit can be checked by EEH to determine which reset t=
ype is
> required.
>
> This patch supersedes the previously submitted patch that implemented a
> reset type callback.
>
> Please review and let me know of any concerns.

I like this patch a *lot* better .. it is vastly simpler, more direct.


> diff -uNrp a/include/linux/pci.h b/include/linux/pci.h
> --- a/include/linux/pci.h =C2=A0 =C2=A0 =C2=A0 2009-07-13 14:25:37.000000=
000 -0700
> +++ b/include/linux/pci.h =C2=A0 =C2=A0 =C2=A0 2009-07-15 10:25:37.000000=
000 -0700
> @@ -273,6 +273,7 @@ struct pci_dev {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0ari_enabled:1; =C2=
=A0/* ARI forwarding */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0is_managed:1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0is_pcie:1;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0fndmntl_rst_rqd:1; /* De=
v requires fundamental reset
> */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0state_saved:1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0is_physfn:1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0is_virtfn:1;

As Ben points out, the name is awkward.  How about needs_freset ?

Since this affects the entire pci subsystem, it should be documented
properly.  The "pci error recovery" subsystem was designed to be
usable in other architectures, and so the error recovery docs should
take at least a paragraph to describe what this flag means, and when
its supposed to be used.

Providing the docs patch together with the pci.h patch *only* would
probably simplify acceptance by the PCI community.

--linas
