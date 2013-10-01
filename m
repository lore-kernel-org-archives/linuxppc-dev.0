Return-Path: <htejun@gmail.com>
Received: from mail-qe0-x231.google.com (mail-qe0-x231.google.com
 [IPv6:2607:f8b0:400d:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 33F312C00E9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 21:55:10 +1000 (EST)
Received: by mail-qe0-f49.google.com with SMTP id s14so4829724qeb.36
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Oct 2013 04:55:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 1 Oct 2013 07:55:03 -0400
From: Tejun Heo <tj@kernel.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Message-ID: <20131001115503.GA23722@mtj.dyndns.org>
References: <20130905200608.GA3846@htj.dyndns.org>
 <CAErSpo4TU2geqzY3AYsL08KimBqtfwa4iUoFHgcFt0zMTBJkHw@mail.gmail.com>
 <20130906160621.GF22763@mtj.dyndns.org>
 <20130906233205.GF12956@google.com>
 <20130909152044.GA24962@dhcp-26-207.brq.redhat.com>
 <20130916102210.GA14102@dhcp-26-207.brq.redhat.com>
 <20130917143022.GA7707@concordia>
 <20130918094759.GA2353@dhcp-26-207.brq.redhat.com>
 <20130918142231.GA21650@mtj.dyndns.org>
 <20131001073548.GI17966@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131001073548.GI17966@concordia>
Cc: Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Alexander Gordeev <agordeev@redhat.com>, Jan Beulich <JBeulich@suse.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Tue, Oct 01, 2013 at 05:35:48PM +1000, Michael Ellerman wrote:
> > > Roughly third of the drivers just do not care and bail out once
> > > pci_enable_msix() has not succeeded. Not sure how many of these are
> > > mandated by the hardware.
> > 
> > Yeah, I mean, this type of interface is a trap.  People have to
> > actively resist to avoid doing silly stuff which is a lot to ask.
> 
> I really think you're overstating the complexity here.
> 
> Functions typically return a boolean   -> nothing to see here
> This function returns a tristate value -> brain explosion!

It is an interface which forces the driver writers to write
complicated fallback code which won't usually be excercised.  The same
goes for the hardware.  In isolation, it doesn't look like much but
things like this are bound to lead to subtle bugs which are diffiuclt
to trigger.

> > * Determine the number of MSIs the controller wants.  Don't worry
> >   about quotas or limits or anything.  Just determine the number
> >   necessary to enable enhanced interrupt handling.
> > 	
> > * Try allocating that number of MSIs.  If it fails, then just revert
> >   to single interrupt mode.  It's not the end of the world and mostly
> >   guaranteed to work.  Let's please not even try to do partial
> >   multiple interrupts.  I really don't think it's worth the risk or
> >   complexity.
> 
> It will potentially break existing setups on our hardware.

I think it'd be much better to have a separate interface for the
drivers which actually require it *in practice* rather than forcing
everyone to go "oh this interface supports that, I don't know if I
need it but let's implement fallback logic which I won't and have no
means of testing".  Are we talking about some limited number of device
drivers here?  Also, is the quota still necessary for machines in
production today?

Thanks.

-- 
tejun
