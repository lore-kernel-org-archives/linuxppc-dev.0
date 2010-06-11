Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 6/6] of/device: populate platform_device (of_device)
	resource table on allocation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <20100610.100140.8559628065321695.imp@bsdimp.com>
References: <AANLkTilpUi1cazljWSFbzliY78RKyHUlvBshUD3NPHPv@mail.gmail.com>
	<20100610.091357.513168276793712624.imp@bsdimp.com>
	<20100610154741.GA7484@oksana.dev.rtsoft.ru>
	<20100610.100140.8559628065321695.imp@bsdimp.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 11 Jun 2010 11:14:36 +1000
Message-ID: <1276218876.1962.80.camel@pasglop>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-06-10 at 10:01 -0600, M. Warner Losh wrote:
> : Oh, come on. Both constructions are binary equivalent.
> : 
> : So how can people seriously be with *that* code:
> : 
> :       dev->resource = (void *)&dev[1];
> : 
> : which, semantically, is a nonsense and asks for a fix.
> 
> It isn't nonsense.  That's just your opinion of it, nothing more.

No, it's dangerously fragile abuse of the C language which loses type
safety etc... It might be correct, but if somebody comes back in 2 year
to change something in that code, the chances of breaking it are higher
than having the type safe:

> :       dev_obj->dev.resource = dev_obj->resource;
> : 

Variant.

It's also less ugly.

> : simply makes sense.
> 
> But this requires extra, bogus fields in the structure and creates a
> bogus sizeof issue.
> 
> There are problems both ways.  Yelling about it isn't going to make
> you any more right, or convince me that I'm wrong.  It is an argument
> that is at least two decades old... 

Cheers,
Ben.
