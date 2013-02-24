Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 73CE22C02A3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2013 02:13:42 +1100 (EST)
Received: by mail-wg0-f51.google.com with SMTP id 8so1702576wgl.18
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Feb 2013 07:13:38 -0800 (PST)
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <1361717023.16950.12.camel@pasglop>
References: <1361717023.16950.12.camel@pasglop>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sun, 24 Feb 2013 10:05:17 -0500
Message-ID: <CAP=VYLpjNHkYZL0aJXFshQ0fZY9yGpKN-8qhCzHARmKx=S9jFA@mail.gmail.com>
Subject: Re: Gianfar breaks one of my test configs
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jianhua Xie <jianhua.xie@freescale.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, claudiu.manoil@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 24, 2013 at 9:43 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Hi folks !
>
> Current Linus tree as of this morning fails to build with one of my
> (semi-random) test configs (attached):
>
> /home/benh/linux-powerpc-test/drivers/net/ethernet/freescale/gianfar.c: In function 'gfar_netpoll':
> /home/benh/linux-powerpc-test/drivers/net/ethernet/freescale/gianfar.c:2909:32: error: 'struct gfar_priv_grp' has no member named 'interruptTransmit'

I see the problem - it wasn't tested with NET_POLL.   I'll have a fix
out shortly.

Thanks,
Paul.
--

> /home/benh/linux-powerpc-test/drivers/net/ethernet/freescale/gianfar.c:2910:32: error: 'struct gfar_priv_grp' has no member named 'interruptReceive'
> /home/benh/linux-powerpc-test/drivers/net/ethernet/freescale/gianfar.c:2911:32: error: 'struct gfar_priv_grp' has no member named 'interruptError'
> /home/benh/linux-powerpc-test/drivers/net/ethernet/freescale/gianfar.c:2912:35: error: 'struct gfar_priv_grp' has no member named 'interruptTransmit'
> /home/benh/linux-powerpc-test/drivers/net/ethernet/freescale/gianfar.c:2914:31: error: 'struct gfar_priv_grp' has no member named 'interruptError'
> /home/benh/linux-powerpc-test/drivers/net/ethernet/freescale/gianfar.c:2915:31: error: 'struct gfar_priv_grp' has no member named 'interruptReceive'
> /home/benh/linux-powerpc-test/drivers/net/ethernet/freescale/gianfar.c:2916:31: error: 'struct gfar_priv_grp' has no member named 'interruptTransmit'
> /home/benh/linux-powerpc-test/drivers/net/ethernet/freescale/gianfar.c:2920:32: error: 'struct gfar_priv_grp' has no member named 'interruptTransmit'
> /home/benh/linux-powerpc-test/drivers/net/ethernet/freescale/gianfar.c:2921:35: error: 'struct gfar_priv_grp' has no member named 'interruptTransmit'
> /home/benh/linux-powerpc-test/drivers/net/ethernet/freescale/gianfar.c:2923:31: error: 'struct gfar_priv_grp' has no member named 'interruptTransmit'
> make[5]: *** [drivers/net/ethernet/freescale/gianfar.o] Error 1
> make[5]: *** Waiting for unfinished jobs....
>
> Cheers,
> Ben.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
