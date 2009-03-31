Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 62DC6DDDA0
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 07:39:10 +1100 (EST)
In-Reply-To: <1238455136.17330.12.camel@pasglop>
References: <1238383506.17330.0.camel@pasglop>
	<7E26E694-85F8-445F-9113-88DCD61BC32C@kernel.crashing.org>
	<20090330135903.GA11614@oksana.dev.rtsoft.ru>
	<1238455136.17330.12.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <38D8651E-1AB6-4358-AD1F-408E3DB8F4E9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Build error
Date: Tue, 31 Mar 2009 22:41:38 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> ERROR: "fsl_pq_mdio_bus_name" [drivers/net/gianfar_driver.ko]
>>>> undefined!
>>>>
>>>> I'll ask Linus to pull anyway though.
>>>>
>>>> Cheers,
>>>> Ben.
>>>
>>> I believe this is fixed in net-next (and possible linus has already
>>> pulled that in.)
>>
>> FWIW, I can't reproduce the issue neither in benh/powerpc.git `next'
>> branch nor in `merge' branch...
>
> Ah .. .weird :-)

I had this happen a few days ago already, on Linus' tree.  I also told
you about it (on IRC), but you were too busy or something :-)

A simple ppc6xx_defconfig is enough to reproduce, fwiw.

Here's the patch I used, sorry if my mailer wraps it, it's a one-liner,
you can handle it I'm sure :-)


Segher


Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>


Author: Segher Boessenkool <segher@kernel.crashing.org>
Date:   Fri Mar 27 21:10:59 2009 +0100

     powerpc: EXPORT_SYMBOL_GPL(fsl_pq_mdio_bus_name)

diff --git a/drivers/net/fsl_pq_mdio.c b/drivers/net/fsl_pq_mdio.c
index b3079a5..a108332 100644
--- a/drivers/net/fsl_pq_mdio.c
+++ b/drivers/net/fsl_pq_mdio.c
@@ -204,6 +204,7 @@ void fsl_pq_mdio_bus_name(char *name, struct  
device_node *np
         snprintf(name, MII_BUS_ID_SIZE, "%s@%llx", np->name,
                 (unsigned long long)taddr);
  }
+EXPORT_SYMBOL_GPL(fsl_pq_mdio_bus_name);

  /* Scan the bus in reverse, looking for an empty spot */
  static int fsl_pq_mdio_find_free(struct mii_bus *new_bus)
