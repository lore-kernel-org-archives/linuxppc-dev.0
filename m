Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjHbR2lTwzDqMN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 15:45:55 +1000 (AEST)
Date: Wed, 7 Jun 2017 07:45:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Vineet Gupta <vgupta@synopsys.com>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>,
 Johan Hovold <johan@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Krzysztof Kozlowski <krzk@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 10/16] powerpc: vio: use dev_groups and not dev_attrs for
 bus_type
Message-ID: <20170607054546.GB7111@kroah.com>
References: <20170606192221.1617-1-gregkh@linuxfoundation.org>
 <20170606192221.1617-11-gregkh@linuxfoundation.org>
 <20170606193058.GA2497@kroah.com>
 <1496790281.31588.33.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1496790281.31588.33.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 07, 2017 at 09:04:41AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2017-06-06 at 21:30 +0200, Greg Kroah-Hartman wrote:
> > >   
> > >   static struct device_attribute vio_dev_attrs[] = {
> > >        __ATTR_RO(name),
> > > @@ -1573,6 +1576,13 @@ static struct device_attribute vio_dev_attrs[] = {
> > >        __ATTR_RO(modalias),
> > >        __ATTR_NULL
> > >   };
> > > +static struct attribute *vio_dev_attrs[] = {
> > 
> > Hm, this feels wrong, odd that 0-day passed it.  I should be deleting
> > the above vio_dev_attrs field as well.  Is powerpc really a dead
> > platform?  :)
> 
> Haha, not yet no, and the above is actually still quite actively
> in use as it's part of our hypervisor virtual IO infrastructure.

Ok, let me fix this, right after I emailed 0-day sent me the build error :)
