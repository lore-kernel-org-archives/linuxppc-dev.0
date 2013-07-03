Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B808A2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 00:52:59 +1000 (EST)
Received: from mail103-db9 (localhost [127.0.0.1])	by
 mail103-db9-R.bigfish.com (Postfix) with ESMTP id 096C6C00F4	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 14:52:54 +0000 (UTC)
Received: from DB9EHSMHS001.bigfish.com (unknown [10.174.16.226])	by
 mail103-db9.bigfish.com (Postfix) with ESMTP id 1165D2A0267	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 14:52:52 +0000 (UTC)
Date: Wed, 3 Jul 2013 09:52:46 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH][v2] powerpc/85xx: Move ePAPR paravirt initialization
 earlier
To: Tudor Laurentiu <Laurentiu.Tudor@freescale.com>
References: <1372769189-17864-1-git-send-email-Laurentiu.Tudor@freescale.com>
 <1372787740.8183.113@snotra> <51D41937.3000509@freescale.com>
In-Reply-To: <51D41937.3000509@freescale.com> (from
 Laurentiu.Tudor@freescale.com on Wed Jul  3 07:29:43 2013)
Message-ID: <1372863166.8183.129@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/2013 07:29:43 AM, Tudor Laurentiu wrote:
> On 07/02/2013 08:55 PM, Scott Wood wrote:
>> On 07/02/2013 07:46:29 AM, Laurentiu Tudor wrote:
>>> - insts =3D of_get_property(hyper_node, "hcall-instructions", &len);
>>> - if (!insts)
>>> - return -ENODEV;
>>> +#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
>>> + if (of_get_flat_dt_prop(node, "has-idle", NULL))
>>> + ppc_md.power_save =3D epapr_ev_idle;
>>> +#endif
>>=20
>> Why are you doing this before processing hcall-instructions?
>>=20
>=20
> Nothing of importance. The code seemed more clear to me.

It seems wrong to expose epapr_ev_idle to ppc_md before the hcall has =20
been patched in, even if you don't expect to actually go idle at this =20
point.

-Scott=
