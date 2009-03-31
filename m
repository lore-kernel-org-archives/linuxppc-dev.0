Return-Path: <glikely@secretlab.ca>
Received: from mail-qy0-f110.google.com (mail-qy0-f110.google.com
	[209.85.221.110]) by ozlabs.org (Postfix) with ESMTP id DCD0EDDDA5
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 07:54:16 +1100 (EST)
Received: by qyk8 with SMTP id 8so6060592qyk.17
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 13:54:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <38D8651E-1AB6-4358-AD1F-408E3DB8F4E9@kernel.crashing.org>
References: <1238383506.17330.0.camel@pasglop>
	<7E26E694-85F8-445F-9113-88DCD61BC32C@kernel.crashing.org>
	<20090330135903.GA11614@oksana.dev.rtsoft.ru>
	<1238455136.17330.12.camel@pasglop>
	<38D8651E-1AB6-4358-AD1F-408E3DB8F4E9@kernel.crashing.org>
Date: Tue, 31 Mar 2009 14:54:14 -0600
Message-ID: <fa686aa40903311354y12b40a88m2f8ee16a6fae1380@mail.gmail.com>
Subject: Re: Build error
From: Grant Likely <grant.likely@secretlab.ca>
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Miller <davem@davemloft.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 31, 2009 at 2:41 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>>>>> ERROR: "fsl_pq_mdio_bus_name" [drivers/net/gianfar_driver.ko]
>>>>> undefined!
>>>>>
>>>> I believe this is fixed in net-next (and possible linus has already
>>>> pulled that in.)
>>>
>>> FWIW, I can't reproduce the issue neither in benh/powerpc.git `next'
>>> branch nor in `merge' branch...
>>
>> Ah .. .weird :-)
>
> I had this happen a few days ago already, on Linus' tree. =A0I also told
> you about it (on IRC), but you were too busy or something :-)
>
> A simple ppc6xx_defconfig is enough to reproduce, fwiw.
>
> Here's the patch I used, sorry if my mailer wraps it, it's a one-liner,
> you can handle it I'm sure :-)
>
> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>

Heh, you beat me to it Segher.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.

>
>
> Author: Segher Boessenkool <segher@kernel.crashing.org>
> Date: =A0 Fri Mar 27 21:10:59 2009 +0100
>
> =A0 =A0powerpc: EXPORT_SYMBOL_GPL(fsl_pq_mdio_bus_name)
>
> diff --git a/drivers/net/fsl_pq_mdio.c b/drivers/net/fsl_pq_mdio.c
> index b3079a5..a108332 100644
> --- a/drivers/net/fsl_pq_mdio.c
> +++ b/drivers/net/fsl_pq_mdio.c
> @@ -204,6 +204,7 @@ void fsl_pq_mdio_bus_name(char *name, struct device_n=
ode
> *np
> =A0 =A0 =A0 =A0snprintf(name, MII_BUS_ID_SIZE, "%s@%llx", np->name,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)taddr);
> =A0}
> +EXPORT_SYMBOL_GPL(fsl_pq_mdio_bus_name);
>
> =A0/* Scan the bus in reverse, looking for an empty spot */
> =A0static int fsl_pq_mdio_find_free(struct mii_bus *new_bus)
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
