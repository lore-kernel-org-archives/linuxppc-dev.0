Return-Path: <htejun@gmail.com>
Received: from mail-vc0-x22a.google.com (mail-vc0-x22a.google.com
 [IPv6:2607:f8b0:400c:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 16A282C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 07:00:23 +1000 (EST)
Received: by mail-vc0-f170.google.com with SMTP id kw10so207559vcb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 14:00:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 25 Sep 2013 17:00:16 -0400
From: Tejun Heo <tj@kernel.org>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Message-ID: <20130925210016.GA8926@htj.dyndns.org>
References: <20130909152044.GA24962@dhcp-26-207.brq.redhat.com>
 <20130916102210.GA14102@dhcp-26-207.brq.redhat.com>
 <20130917143022.GA7707@concordia>
 <20130918094759.GA2353@dhcp-26-207.brq.redhat.com>
 <20130918142231.GA21650@mtj.dyndns.org>
 <20130918165045.GB2353@dhcp-26-207.brq.redhat.com>
 <20130920082458.GA10507@dhcp-26-207.brq.redhat.com>
 <20130920122736.GD7630@mtj.dyndns.org>
 <20130925180220.GB26273@google.com>
 <20130925205804.GA21737@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130925205804.GA21737@dhcp-26-207.brq.redhat.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Jan Beulich <JBeulich@suse.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Wed, Sep 25, 2013 at 10:58:05PM +0200, Alexander Gordeev wrote:
> Unfortunately, pSeries is a shows-topper here :( It seems we have to
> introduce pci_get_msi{,x}_limit() interfaces to honour the quota
> thing.  I just hope the hardware set for pSeries is limited and we
> won't need to use it for all drivers.

Can you please go into a bit of detail on that?  Why does it matter?
Is it because you're worried you might cause performance regression by
forcing prevoius partial multiple allocations to single interrupt
operation?

Thanks.

-- 
tejun
