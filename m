From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: roger blofeld <blofeldus@yahoo.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Patch: Fix SMP hang on modem close
Date: Sat, 6 Apr 2002 12:24:10 +0200
Message-Id: <20020406102410.14763@smtp.wanadoo.fr>
In-Reply-To: <20020405202021.61407.qmail@web11105.mail.yahoo.com>
References: <20020405202021.61407.qmail@web11105.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Ben,
> This patch removes two dangling LOCK() statements for
>core99/pangea. The core99 one hung my dual g4.
>-roger

Good catch ! That would indeed have cause SMP lockups
when using the modem.

Thanks,
Ben.

>--- linux/arch/ppc/kernel/pmac_feature.c.orig   Tue
>Apr  2 08:17:31 2002
>+++ linux/arch/ppc/kernel/pmac_feature.c        Fri
>Apr  5 14:02:13 2002
>@@ -788,7 +788,7 @@
>                UNLOCK(flags); mdelay(250);
>LOCK(flags);
>                MACIO_OUT8(KL_GPIO_MODEM_RESET, gpio |
>KEYLARGO_GPIO_OUTOUT_DATA);
>                (void)MACIO_IN8(KL_GPIO_MODEM_RESET);
>-               UNLOCK(flags); mdelay(250);
>LOCK(flags);
>+               UNLOCK(flags); mdelay(250);
>        }
>        return 0;
> }
>@@ -1445,7 +1445,7 @@
>                UNLOCK(flags); mdelay(250);
>LOCK(flags);
>                MACIO_OUT8(KL_GPIO_MODEM_RESET, gpio |
>KEYLARGO_GPIO_OUTOUT_DATA);
>                (void)MACIO_IN8(KL_GPIO_MODEM_RESET);
>-               UNLOCK(flags); mdelay(250);
>LOCK(flags);
>+               UNLOCK(flags); mdelay(250);
>        }
>        return 0;
> }
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
