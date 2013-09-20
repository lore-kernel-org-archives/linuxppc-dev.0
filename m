Return-Path: <htejun@gmail.com>
Received: from mail-ye0-x233.google.com (mail-ye0-x233.google.com
 [IPv6:2607:f8b0:4002:c04::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E2A482C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 22:26:12 +1000 (EST)
Received: by mail-ye0-f179.google.com with SMTP id r6so82358yen.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 05:26:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 20 Sep 2013 07:26:03 -0500
From: Tejun Heo <tj@kernel.org>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Message-ID: <20130920122603.GC7630@mtj.dyndns.org>
References: <20130905200608.GA3846@htj.dyndns.org>
 <CAErSpo4TU2geqzY3AYsL08KimBqtfwa4iUoFHgcFt0zMTBJkHw@mail.gmail.com>
 <20130906160621.GF22763@mtj.dyndns.org>
 <20130906233205.GF12956@google.com>
 <20130909152044.GA24962@dhcp-26-207.brq.redhat.com>
 <20130916102210.GA14102@dhcp-26-207.brq.redhat.com>
 <20130917143022.GA7707@concordia>
 <20130918094759.GA2353@dhcp-26-207.brq.redhat.com>
 <20130918142231.GA21650@mtj.dyndns.org>
 <20130918165045.GB2353@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130918165045.GB2353@dhcp-26-207.brq.redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Jan Beulich <JBeulich@suse.com>,
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

On Wed, Sep 18, 2013 at 06:50:45PM +0200, Alexander Gordeev wrote:
> Actually, I do not see much contradiction with what I proposed. The
> key words here "determine the number of MSIs the controller wants".
> 
> In general case it is not what pci_msix_table_size() returns (or at
> least we should not limit ourselves to it) - there could be non-
> standard means to report number of MSIs: hardcoded, version-dependant,
> device-specific registers etc.
> 
> Next, if we opt to determine the number of MSIs by non-MSI standard
> means then there is no reason not to call pci_get_msix_limit() (or
> whatever) at this step.

Yeah, that's all fine.  My point is that we shouldn't try to use
"degraded" multiple MSI mode where the number of MSIs allocated is
smaller than performing full multiple MSI operation.  How that number
is determined doesn't really matter but that number is a property
which is solely decided by the device driver, right?  If a device
needs full multiple MSI mode, given specific configuration, it needs
>= X number of MSIs and that's the number it should request.

> Being Captain Obvious here, but it is up to the device driver to handle
> a failure. There could be no such option as single MSI mode after all :)

I don't think there actually is a mainstream device which can't
fallback to single interrupt.  Anyways, the point is the same, let's
please not try to create an interface which encourages complex retry
logic in its users which are likely to involve less traveled and
tested paths in both the driver and firmware.

Thanks.

-- 
tejun
