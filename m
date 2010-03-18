Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f177.google.com (mail-yw0-f177.google.com
	[209.85.211.177]) by ozlabs.org (Postfix) with ESMTP id D33F4B7D0A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 03:22:36 +1100 (EST)
Received: by ywh7 with SMTP id 7so1039871ywh.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Mar 2010 09:22:34 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100318154747.GA7767@oksana.dev.rtsoft.ru>
References: <20100318144836.21082.93040.stgit@angua>
	<20100318152250.21082.35352.stgit@angua>
	<20100318154747.GA7767@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 18 Mar 2010 10:22:14 -0600
Message-ID: <fa686aa41003180922g3e867bedo337568c3ca6f2097@mail.gmail.com>
Subject: Re: [V2 PATCH 08/10] arch/powerpc: Remove obsolete
	dev_archdata.of_node and of_devce.node
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 18, 2010 at 9:47 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> Hi Grant,
>
> On Thu, Mar 18, 2010 at 09:22:50AM -0600, Grant Likely wrote:
>> Both dev_archdata.of_node and of_device.node are duplications of the
>> device.of_node value. =A0This patch removes them.
>
> Yeah, they're plain duplications since you introduced dev.of_node.
> I wonder what was the problem with using dev.archdata.of_node?
> Why dev.of_node is better?

CONFIG_OF support is not going to be an arch-specific thing any
longer.  The code is being generalized, and I'm removing as many
things as possible that arch code needs to add to enable CONFIG_OF.
That includes the dev_archdata element.

The impact of moving of_node from dev_archdata to device is pretty
small anyway.  Most current users are getting the device node from
of_device.node instead of archdata.  The number of dev_archdata users
is comparatively small.

> Also, by using dev.of_node directly you have to introduce ugly
> #ifdefs in the non-OF code (as in i2c patch), which you don't
> need with transparent archdata and accessors, which you've just
> removed:

The #ifdefs are only needed in the i2c code because the i2c API
doesn't currently support separate allocation and registration of i2c
devices.  With separate allocation and registration, the of_i2c code
could set the device node pointer directly without touching the common
i2c code at all (like how of_register_spi_devices handles it).  I do
plan to write a patch to do this, but that is a task for another patch
series.

g.
