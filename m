Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 5AE8FDE01F
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 08:14:25 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so322728anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 15:14:23 -0700 (PDT)
Message-ID: <fa686aa40805161514r513d0eebt380a76f64abe8434@mail.gmail.com>
Date: Fri, 16 May 2008 16:14:23 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: cbouatmailru@gmail.com
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
In-Reply-To: <20080516220338.GA3255@zarina>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193613.28030.13950.stgit@trillian.secretlab.ca>
	<20080516220338.GA3255@zarina>
Cc: fabrizio.garetto@gmail.com, linuxppc-dev@ozlabs.org,
	dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 16, 2008 at 4:03 PM, Anton Vorontsov <cbouatmailru@gmail.com> wrote:
> On Fri, May 16, 2008 at 01:36:13PM -0600, Grant Likely wrote:
>> +             /* Store a pointer to the node in the device structure */
>> +             of_node_get(nc);
>> +             spi->dev.archdata.of_node = nc;
>> +
>> +             /* Register the new device */
>> +             rc = spi_register_device(spi);
>> +             if (rc) {
>> +                     dev_err(&master->dev, "spi_device register error %s\n",
>> +                             np->full_name);
>> +                     spi_device_release(spi);
>> +             }
>
> No way to pass platform data... can you suggest any idea to use
> this for things like
> "[POWERPC] 86xx: mpc8610_hpcd: add support for SPI and MMC-over-SPI"
> I've sent just recently...?

That's right.  platform_data being a very driver specific thing there
is no way to generically extract a pdata structure from the device
tree.  Instead, I'm storing the device node in archdata.of_node (line
immediately above spi_register_device) so that drivers can read the
device node themselves to populate a platform_device structure.
(Protected by CONFIG_OF of course).

> Maybe this code could do something like
> spi->dev.platform_data = nc->data;
> and board code would fill nc->data at early stages? This needs to be a
> convention, not just random use though.. Maybe we can expand the struct
> device_node to explicitly include .platform_data for such cases?

Hmmm, as you say, this could end up being rather messy.  However, by
passing the device node pointer, the driver could extract that data on
a per case basis.  (ie. it would be decided on a per driver basis
where to get the platform data).  I'm not sure; this bears more
thought...

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
