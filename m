Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQR7w66SrzDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 09:32:44 +1100 (AEDT)
Received: from mail-pf0-x232.google.com (mail-pf0-x232.google.com
 [IPv6:2607:f8b0:400e:c00::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qQR7w26Frz9t3Z
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Mar 2016 09:32:44 +1100 (AEDT)
Received: by mail-pf0-x232.google.com with SMTP id 124so92197359pfg.0
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2016 15:32:44 -0700 (PDT)
Date: Thu, 17 Mar 2016 09:32:29 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Fix possible unrecoverable exception caused by
 '70fe3d9'
Message-ID: <20160317093229.04cdd959@camb691>
In-Reply-To: <1458128720.3107.66.camel@au1.ibm.com>
References: <1458095370-26731-1-git-send-email-cyrilbur@gmail.com>
 <1458128720.3107.66.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 16 Mar 2016 22:45:20 +1100
Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:

> On Wed, 2016-03-16 at 13:29 +1100, Cyril Bur wrote:
> > +#ifdef CONFIG_PPC_BOOK3S
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ld=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0r10,PACAKMSR(r13)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0li=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0r9,MSR_RI
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0andc=C2=A0=C2=A0=C2=A0=C2=A0=
r11,r10,r9 /* Re-clear RI */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtmsrd=C2=A0=C2=A0r11,1
> > +#endif
>=20
> Do you need that ? IE, mtmsrd with "1" will only update RI and EE, is
> the value of EE in PACAMSR variable ?
>=20

Indeed, so, we should check with Anton who did the disable EE and clear RI =
just
a bit before that.

I had a quick look and to the best of my knowledge EE is not set in PACAKMS=
R.

> Cheers,
> Ben.
>=20
