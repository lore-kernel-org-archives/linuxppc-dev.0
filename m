Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id D13D6DDDA5
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 07:57:45 +1100 (EST)
Date: Wed, 1 Apr 2009 00:57:44 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Build error
Message-ID: <20090331205744.GA1156@oksana.dev.rtsoft.ru>
References: <1238383506.17330.0.camel@pasglop>
	<7E26E694-85F8-445F-9113-88DCD61BC32C@kernel.crashing.org>
	<20090330135903.GA11614@oksana.dev.rtsoft.ru>
	<1238455136.17330.12.camel@pasglop>
	<38D8651E-1AB6-4358-AD1F-408E3DB8F4E9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <38D8651E-1AB6-4358-AD1F-408E3DB8F4E9@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 31, 2009 at 10:41:38PM +0200, Segher Boessenkool wrote:
>>>>> ERROR: "fsl_pq_mdio_bus_name" [drivers/net/gianfar_driver.ko]
>>>>> undefined!
>>>>>
>>>>> I'll ask Linus to pull anyway though.
>>>>>
>>>>> Cheers,
>>>>> Ben.
>>>>
>>>> I believe this is fixed in net-next (and possible linus has already
>>>> pulled that in.)
>>>
>>> FWIW, I can't reproduce the issue neither in benh/powerpc.git `next'
>>> branch nor in `merge' branch...
>>
>> Ah .. .weird :-)
>
> I had this happen a few days ago already, on Linus' tree.  I also told
> you about it (on IRC), but you were too busy or something :-)
>
> A simple ppc6xx_defconfig is enough to reproduce, fwiw.
>
> Here's the patch I used, sorry if my mailer wraps it, it's a one-liner,
> you can handle it I'm sure :-)

Ah, the modular build. Yeah, I didn't try it, but should have... :-(

Thanks!

> Segher
>
>
> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
>
>
> Author: Segher Boessenkool <segher@kernel.crashing.org>
> Date:   Fri Mar 27 21:10:59 2009 +0100
>
>     powerpc: EXPORT_SYMBOL_GPL(fsl_pq_mdio_bus_name)
>
> diff --git a/drivers/net/fsl_pq_mdio.c b/drivers/net/fsl_pq_mdio.c
> index b3079a5..a108332 100644
> --- a/drivers/net/fsl_pq_mdio.c
> +++ b/drivers/net/fsl_pq_mdio.c
> @@ -204,6 +204,7 @@ void fsl_pq_mdio_bus_name(char *name, struct  
> device_node *np
>         snprintf(name, MII_BUS_ID_SIZE, "%s@%llx", np->name,
>                 (unsigned long long)taddr);
>  }
> +EXPORT_SYMBOL_GPL(fsl_pq_mdio_bus_name);
>
>  /* Scan the bus in reverse, looking for an empty spot */
>  static int fsl_pq_mdio_find_free(struct mii_bus *new_bus)
>

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
