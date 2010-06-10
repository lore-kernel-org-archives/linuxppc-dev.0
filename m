Return-Path: <cbouatmailru@gmail.com>
Date: Thu, 10 Jun 2010 21:10:29 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 6/6] of/device: populate platform_device (of_device)
	resource table on allocation
Message-ID: <20100610171029.GA18824@oksana.dev.rtsoft.ru>
References: <20100608194809.GA32732@oksana.dev.rtsoft.ru>
	<1276150663.1962.43.camel@pasglop>
	<AANLkTilpUi1cazljWSFbzliY78RKyHUlvBshUD3NPHPv@mail.gmail.com>
	<20100610.091357.513168276793712624.imp@bsdimp.com>
	<20100610154741.GA7484@oksana.dev.rtsoft.ru>
	<AANLkTimjIyclTWZZW1A26zOcWroK-bwOkmEqsLm4DINk@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTimjIyclTWZZW1A26zOcWroK-bwOkmEqsLm4DINk@mail.gmail.com>
Cc: sfr@canb.auug.org.au, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org, "M. Warner Losh" <imp@bsdimp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 10, 2010 at 10:30:26AM -0600, Grant Likely wrote:
[...]
> C)
> struct of_device *alloc_function(int num_res)
> {
> 	struct device *ofdev;
> 	struct resource *res;
> 	ofdev = kzalloc(sizeof(*ofdev), GFP_KERNEL)
> 	if (!ofdev)
> 		return NULL;
> 	res = kzalloc((sizeof(*res) * num_res), GFP_KERNEL);
> 	if (!res) {
> 		kfree(ofdev);  /* or goto an error unwind label */
> 		return NULL;
> 	}
> 	res = (struct resource *)&ofdev[1];

You mean ofdev->resource = res; ?

> That being said, I'm looking at refactoring to use
> platform_device_alloc() instead, which is effectively option C. (which
> I'd normally avoid, but it removes otherwise duplicate code from
> drivers/of).

Sounds great!

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
