Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E79567A78
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2005 09:35:53 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: sl@bplan-gmbh.de
In-Reply-To: <20050308164310.GA9891@pegasos>
References: <422C495B.8090805@katalix.com>
	<20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
	<20050307225401.GA31041@xyzzy> <20050308064945.GC27722@pegasos>
	<1110266832.13607.267.camel@gaston> <20050308122048.GA22866@xyzzy>
	<20050308121501.GC4556@pegasos> <20050308124201.GA5545@pegasos>
	<20050308164310.GA9891@pegasos>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 09:31:26 +1100
Message-Id: <1110321086.13593.284.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-embedd@ozlabs.org, Nicolas DET <det.nicolas@free.fr>
Subject: Re: mv643xx_eth SA_SHIRQ support patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Ok, i should have something working. adding here both sven2-dale.diff which is
> a patch against linux-2.5-mv643xx-enet and sven2.diff which is a patch against
> 2.6.11.
> 
> There is still a bit of cleanup needed in arch/ppc/platforms/mv643xx_eth_pegasos.c 
> especially with regard the headers, and also the proper copyright/attibution
> of it (since dale wrote it and i just pasted it and did the detection stuff
> benh mentioned above.
> 
> I am unsure also about the : 
> 
> @@ -44,6 +44,9 @@
>  #include <asm/pgtable.h>
>  #include <asm/system.h>
>  #include <asm/delay.h>
> +#ifdef PPC_MULTIPLATEFORM
> +#include <mv64x60.h>
> +#endif
>  #include "mv643xx_eth.h"
> 
>  /*
> 
> hunk. dale can you check it ? 

Looks broken...

> Comments are welcome, in particular benh, i guess my detection code will beak
> horribly if there is another host node prior to the marvell one in the OF
> tree, which is not the case currently on pegasos though.

Why are you looking at vid/did ? Isn't there some name string (model,
compatible, whatever) you can use ? Or is your OF too bad to even give
such info ?

You can also iterate after the find_devices() using np->next

Ben.
