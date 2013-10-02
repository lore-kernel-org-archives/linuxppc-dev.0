Return-Path: <htejun@gmail.com>
Received: from mail-qa0-x235.google.com (mail-qa0-x235.google.com
 [IPv6:2607:f8b0:400d:c00::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 678412C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Oct 2013 13:23:46 +1000 (EST)
Received: by mail-qa0-f53.google.com with SMTP id k4so255099qaq.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Oct 2013 20:23:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 1 Oct 2013 23:23:38 -0400
From: Tejun Heo <tj@kernel.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Message-ID: <20131002032338.GA2417@htj.dyndns.org>
References: <20130906160621.GF22763@mtj.dyndns.org>
 <20130906233205.GF12956@google.com>
 <20130909152044.GA24962@dhcp-26-207.brq.redhat.com>
 <20130916102210.GA14102@dhcp-26-207.brq.redhat.com>
 <20130917143022.GA7707@concordia>
 <20130918094759.GA2353@dhcp-26-207.brq.redhat.com>
 <20130918142231.GA21650@mtj.dyndns.org>
 <20131001073548.GI17966@concordia>
 <20131001115503.GA23722@mtj.dyndns.org>
 <20131002023337.GB22748@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131002023337.GB22748@concordia>
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

On Wed, Oct 02, 2013 at 12:33:38PM +1000, Michael Ellerman wrote:
> > It is an interface which forces the driver writers to write
> > complicated fallback code which won't usually be excercised.  
> 
> It does not force anyone to do anything. That's just bull.

Yeah, sure, we don't have shitty code in drivers which don't need any
of that retry logic, right?  What the hell is up with the gratuituous
escalation?  You really wanna go that way?

> Code which is unwilling or unable to cope with the extra complexity
> can simply do:
> 
> if (pci_enable_msix(..))
> 	goto fail;
> 
> It's as simple as that.

You apparently have no clue how people behave.  You give a function
which indicates complex failure mode, driver writers *will* try to
handle that whether they actually understand the implication or not.
That's a natural and correct behavior too because any half-competent
software eng would design API so that it receives and returns
information which is relevant to its users.  If there are special
cases to handle, make the damn interface for it special too so that it
doesn't confuse the common case.

Driver codes already have generally lower quality than core code, if
for nothing else, due to the sheer volume, and there are many driver
writers who aren't too privvy with various kernel subsystems.  They
usually just copy whatever other similar driver is doing, and this one
is a lot worse - this thing affects hardware directly.  If you expect
all the shitty implementations of ahci to handle the different
variations of multiple MSI config cases, you just don't have any
experience dealing with cheap commodity hardware.

Driver APIs should be intuitive, clear in its intentions, and don't
tempt fate with hairy configs for vast majority of cases.

> +int pci_enable_msix_or_fail(struct pci_dev *dev, struct msix_entry *entries,
> +                           int nvec)
> +{
> +       int rc;
> +
> +       rc = pci_enable_msix(dev, entries, nvec);
> +       if (rc > 0)
> +               rc = -ENOSPC;
> +
> +       return rc;
> +}

Make the *default* case simple and give clearly special interface for
the special cases.  What's so hard about that?

> > Are we talking about some limited number of device drivers here?  
> 
> I don't have a list, but yeah there are certain drivers that folks care about.

And here's another problem with the current interface.  Because the
default interface is the unnecessrily complicated one, now we can't
tell which ones actually need the complicated treatment.

> > Also, is the quota still necessary for machines in production today?
> 
> As far as I know yes. The number of MSIs is growing on modern systems, but so
> is the number of cpus and devices.

That's a bummer, but let's please make the default interface simple.
I really don't wanna see partial allocations for ahci.

-- 
tejun
