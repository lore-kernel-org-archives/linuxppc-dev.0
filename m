Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 501752C00EF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 17:50:46 +1000 (EST)
Message-ID: <1380613830.645.18.camel@pasglop>
Subject: Re: [PATCH V2] powerpc/kernel/sysfs: disable writing to purr in
 non-powernv
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 01 Oct 2013 17:50:30 +1000
In-Reply-To: <20131001063129.GF17966@concordia>
References: <1380281634-9921-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20131001063129.GF17966@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-10-01 at 16:31 +1000, Michael Ellerman wrote:

> > 1)Changed the test for to hypervisor mode instead of platform
> 
> I think Ben's wrong about that.
> 
> Almost all existing code uses FW_FEATURE_LPAR to differentiate
> hypervisor vs guest mode, so I think we should do the same here.

I didn't object to using the FW test, it's a reasonable way to do it, I
objected to using the platform as an indication (powernv vs. pseries)

Ben.

> So it would be:
> 
> > +	if (cpu_has_feature(CPU_FTR_PURR)) {
> > +		if (!firmware_has_feature(FW_FEATURE_LPAR))
> > +			add_write_permission_dev_attr((void *)&dev_attr_purr);
> >  		device_create_file(s, &dev_attr_purr);
> > +	}
> 
> 
> > +static void add_write_permission_dev_attr(void *ptr)
> > +{
> > +	struct device_attribute *attr = (struct device_attribute *)ptr;
> > +
> > +	attr->attr.mode |= (unsigned short) 0200;
> > +}
> 
> Why does it take a void *, which then requires a cast at the call site?
> 
> And do you need the cast to short? If so shouldn't you use umode_t
> directly?
> 
> cheers
