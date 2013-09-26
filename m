Return-Path: <htejun@gmail.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 615BC2C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 00:42:13 +1000 (EST)
Received: by mail-pa0-f50.google.com with SMTP id fb1so1400698pad.37
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 07:42:10 -0700 (PDT)
MIME-Version: 1.0
Sender: htejun@gmail.com
In-Reply-To: <20130926143901.GE16774@dhcp-26-207.brq.redhat.com>
References: <20130918094759.GA2353@dhcp-26-207.brq.redhat.com>
 <20130918142231.GA21650@mtj.dyndns.org>
 <20130918165045.GB2353@dhcp-26-207.brq.redhat.com>
 <20130920082458.GA10507@dhcp-26-207.brq.redhat.com>
 <20130920122736.GD7630@mtj.dyndns.org>
 <20130925180220.GB26273@google.com>
 <20130925205804.GA21737@dhcp-26-207.brq.redhat.com>
 <20130925210016.GA8926@htj.dyndns.org>
 <20130926074646.GA16774@dhcp-26-207.brq.redhat.com>
 <20130926131147.GA31249@mtj.dyndns.org>
 <20130926143901.GE16774@dhcp-26-207.brq.redhat.com>
Date: Thu, 26 Sep 2013 10:42:10 -0400
Message-ID: <CAOS58YOZ4u7po=wb-v4Ua=oBiaKG==S1LMT70SdGEcNfAOVcOQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
From: Tejun Heo <tj@kernel.org>
To: Alexander Gordeev <agordeev@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Thu, Sep 26, 2013 at 10:39 AM, Alexander Gordeev <agordeev@redhat.com> wrote:
> I can imagine a scenario where the first device probes in, requests its

Well, we can imagine a lot of thing but usually have to draw the line somewhere.

> optimal number, acquires that number and exhausts MSIs in pSeries firmware.
> The next few devices possibly end up with single MSI, since no MSIs left
> to satisfy their optimal numbers. If one of those single-MSI'ed devices
> happened to be a high-performance HBA hitting a degraded performance that
> alone would force (IBM) to introduce the quotas. Now, if the same/another
> device happened does not support the legacy interrupt mode and no MSI
> resources have left in the platform firmware at all...

If that happens, that's just the platform code being dumb. Quota is
there to prevent that from happening, right? Let's please do something
simple and worry about problems if they actually exist.

Thanks.

-- 
tejun
