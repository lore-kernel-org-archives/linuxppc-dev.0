Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 649232C013A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2013 08:16:11 +1000 (EST)
Date: Mon, 15 Jul 2013 17:15:58 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/fsl-booke: Work around erratum A-006958
To: Scott Wood <scottwood@freescale.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6026B72E1@saturn3.aculab.com>
 <1373907234.8183.297@snotra>
In-Reply-To: <1373907234.8183.297@snotra> (from scottwood@freescale.com on
 Mon Jul 15 11:53:54 2013)
Message-ID: <1373926558.8183.317@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: David Laight <David.Laight@ACULAB.COM>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/2013 11:53:54 AM, Scott Wood wrote:
> On 07/15/2013 03:45:36 AM, David Laight wrote:
>> Also, if the high word changes, there is no need to loop.
>> Just return the second value with a low word of zero
>> (the returned count happened while the function was active).
>=20
> That would be more complicated than looping.

That said, it's since been confirmed internally that the low word =20
should always be zero when this happens, so we could share the Cell =20
workaround code -- as long as we do something special in the timebase =20
sync code so that we don't get stuck if the timebase happens to be =20
frozen with TBL=3D=3D0.  This would avoid the need for scratch registers =20
(other than CR0).

-Scott=
