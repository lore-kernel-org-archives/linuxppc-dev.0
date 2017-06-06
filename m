Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wj6j32RTFzDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 09:05:11 +1000 (AEST)
Message-ID: <1496790281.31588.33.camel@kernel.crashing.org>
Subject: Re: [PATCH 10/16] powerpc: vio: use dev_groups and not dev_attrs
 for bus_type
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Vineet Gupta <vgupta@synopsys.com>, Bart Van Assche
 <bart.vanassche@sandisk.com>, Robin Murphy <robin.murphy@arm.com>, Joerg
 Roedel <jroedel@suse.de>, Johan Hovold <johan@kernel.org>, Alexey
 Kardashevskiy <aik@ozlabs.ru>,
 Krzysztof Kozlowski <krzk@kernel.org>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 07 Jun 2017 09:04:41 +1000
In-Reply-To: <20170606193058.GA2497@kroah.com>
References: <20170606192221.1617-1-gregkh@linuxfoundation.org>
 <20170606192221.1617-11-gregkh@linuxfoundation.org>
 <20170606193058.GA2497@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-06 at 21:30 +0200, Greg Kroah-Hartman wrote:
> >   
> >   static struct device_attribute vio_dev_attrs[] = {
> >        __ATTR_RO(name),
> > @@ -1573,6 +1576,13 @@ static struct device_attribute vio_dev_attrs[] = {
> >        __ATTR_RO(modalias),
> >        __ATTR_NULL
> >   };
> > +static struct attribute *vio_dev_attrs[] = {
> 
> Hm, this feels wrong, odd that 0-day passed it.  I should be deleting
> the above vio_dev_attrs field as well.  Is powerpc really a dead
> platform?  :)

Haha, not yet no, and the above is actually still quite actively
in use as it's part of our hypervisor virtual IO infrastructure.

Cheers,
Ben.
