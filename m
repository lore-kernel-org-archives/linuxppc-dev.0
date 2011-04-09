Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B40AB6F1B
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Apr 2011 00:41:06 +1000 (EST)
Subject: Re: platform_driver/of_platform_driver compile warning in fsldma.c
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110408153246.GA13834@ovro.caltech.edu>
Date: Sat, 9 Apr 2011 09:40:58 -0500
Message-Id: <6A9F1556-6932-4A12-8306-F4914F66712A@kernel.crashing.org>
References: <D4BE3D54-805B-4D4F-B8BC-EC1A860C8E84@kernel.crashing.org>
	<20110408153246.GA13834@ovro.caltech.edu>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 8, 2011, at 10:32 AM, Ira W. Snyder wrote:

> On Fri, Apr 08, 2011 at 04:12:13AM -0500, Kumar Gala wrote:
>> Grant,
>>=20
>> I'm being lazy, can you give any quick insight on the following =
compile warning:
>>=20
>> drivers/dma/fsldma.c:1457:2: warning: initialization from =
incompatible pointer type
>> drivers/dma/fsldma.c: In function 'fsldma_init':
>> drivers/dma/fsldma.c:1468:2: warning: passing argument 1 of =
'platform_driver_register' from incompatible pointer type
>> include/linux/platform_device.h:124:12: note: expected 'struct =
platform_driver *' but argument is of type 'struct of_platform_driver *'
>> drivers/dma/fsldma.c: In function 'fsldma_exit':
>> drivers/dma/fsldma.c:1473:2: warning: passing argument 1 of =
'platform_driver_unregister' from incompatible pointer type
>> include/linux/platform_device.h:125:13: note: expected 'struct =
platform_driver *' but argument is of type 'struct of_platform_driver *'
>>=20
>=20
> The "struct of_platform_driver" needs to be changed to a
> "struct platform_driver". Just remove the "of_" prefix, the structure
> initialization is correct. I sent a patch for this yesterday to LKML. =
The
> title is: fsldma: fix build warning caused by of_platform_device =
changes
>=20
> Ira

Ira, thanks.  Hopefully it will get picked up.  If not let me know.

- k=
