Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CFF4F2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 22:46:32 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Zhao Chenhui-B35336 <B35336@freescale.com>
Subject: Re: [PATCH v7 1/5] powerpc/85xx: implement hardware timebase sync
Date: Tue, 3 Jul 2012 12:46:24 +0000
Message-ID: <CAOZdJXUeY-_mmBLoA25_g4eLqwHxYX4c_ECbU+KYqfM307THNQ@mail.gmail.com>
References: <1341310879-5468-1-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1341310879-5468-1-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 3, 2012 at 5:21 AM, Zhao Chenhui <chenhui.zhao@freescale.com> w=
rote:

> +       np =3D of_find_matching_node(NULL, mpc85xx_smp_guts_ids);
> +       if (np) {
> +               guts =3D of_iomap(np, 0);
> +               of_node_put(np);
> +               if (!guts) {
> +                       pr_err("%s: Could not map guts node address\n",
> +                                                               __func__)=
;
> +                       return;
> +               }
> +               smp_85xx_ops.give_timebase =3D mpc85xx_give_timebase;
> +               smp_85xx_ops.take_timebase =3D mpc85xx_take_timebase;
> +       }

I had this in mind:

               guts =3D of_iomap(np, 0);
               of_node_put(np);
               if (guts) {
                       smp_85xx_ops.give_timebase =3D mpc85xx_give_timebase=
;
                       smp_85xx_ops.take_timebase =3D mpc85xx_take_timebase=
;
                } else {
                       pr_err("%s: Could not map guts node address\n",
                                                               __func__);
               }

That way, a missing GUTS node does not break everything.

--=20
Timur Tabi
Linux kernel developer at Freescale=
