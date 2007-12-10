Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id D7EADDDE2D
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 05:06:35 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3733296wag
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 10:06:34 -0800 (PST)
Message-ID: <9e4733910712101006s37829df4w676eea54a98b282d@mail.gmail.com>
Date: Mon, 10 Dec 2007 13:06:34 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [i2c] [PATCH 0/4] Series to add device tree naming to i2c
In-Reply-To: <20071210164255.GA4497@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071203212032.23543.3453.stgit@terra.home>
	<9e4733910712091224mcb43f0ci69f578d221505ba7@mail.gmail.com>
	<1197233208.6563.14.camel@pasglop>
	<9e4733910712091257x4ba5e07aue55934fb6898aa2d@mail.gmail.com>
	<1197234799.6563.19.camel@pasglop>
	<9e4733910712091335g534d9248gcd920850f9f679a1@mail.gmail.com>
	<1197236326.6563.22.camel@pasglop>
	<20071210164255.GA4497@loki.buserror.net>
Cc: Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/10/07, Scott Wood <scottwood@freescale.com> wrote:
> On Mon, Dec 10, 2007 at 08:38:46AM +1100, Benjamin Herrenschmidt wrote:
> > The more I think about it, the more I tend to agree that tagging isn't
> > necessary and you are right. We should just match the name against the
> > "compatible" property of the OF nodes (which mean we need to support
> > multiple matches though since "compatible" is a list of strings).
>
> It may not be strictly necessary, but I think it's a good idea not just for
> safety reasons, but as an indication to the driver what additional
> information it has access to.  We could put a match data pointer in the i2c
> device, and have it be a valid node pointer if the match was an OF one (and
> a device-specific struct for a straight platform device, etc).  This could
> be useful if a device needs to have more properties than standard
> address/type/interrupt for some reason.

I can't see an easy way to do this. The basic problem is that the i2c
drivers are assumed to be cross platform. I would need to add a path
through the i2c core for getting a void pointer from the bus to the
device But then when the device code gets this pointer it has no way
of knowing what it was. Assuming the void is a pointer to an of_node
would make the driver for the i2c device platform specific.

Another way that would work cross platform would be for the module to
have module parameters for the extra attributes. The bus code could
then look in the of_node for extra attributes and use them to set the
module parameters. I know this can be done, but doing it is a little
above my understanding of the module code. You need to ask the module
it's parameter names, addresses and types and then match them to
attributes in the of_node and do the copy.

>
> -Scott
>


-- 
Jon Smirl
jonsmirl@gmail.com
