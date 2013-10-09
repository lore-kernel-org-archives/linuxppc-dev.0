Return-Path: <htejun@gmail.com>
Received: from mail-qe0-x231.google.com (mail-qe0-x231.google.com
 [IPv6:2607:f8b0:400d:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7568A2C016E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 02:54:20 +1100 (EST)
Received: by mail-qe0-f49.google.com with SMTP id ff1so568691qeb.36
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Oct 2013 08:54:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 9 Oct 2013 11:54:13 -0400
From: Tejun Heo <tj@kernel.org>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 07/77] PCI/MSI: Re-design MSI/MSI-X interrupts
 enablement pattern
Message-ID: <20131009155413.GD22495@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <d8c36203ada6efbfa9f7ce92c2f713ee3b6d6b8d.1380703262.git.agordeev@redhat.com>
 <20131007181749.GB27396@htj.dyndns.org>
 <20131008074826.GD10669@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131008074826.GD10669@dhcp-26-207.brq.redhat.com>
Cc: linux-mips@linux-mips.org, linux-doc@vger.kernel.org, "VMware,
 Inc." <pv-drivers@vmware.com>, linux-nvme@lists.infradead.org,
 linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
 Andy King <acking@vmware.com>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-pci@vger.kernel.org, iss_storagedev@hp.com, linux-driver@qlogic.com,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, e1000-devel@lists.sourceforge.net,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Alexander.

On Tue, Oct 08, 2013 at 09:48:26AM +0200, Alexander Gordeev wrote:
> > If there are many which duplicate the above pattern, it'd probably be
> > worthwhile to provide a helper?  It's usually a good idea to reduce
> > the amount of boilerplate code in drivers.
> 
> I wanted to limit discussion in v1 to as little changes as possible.
> I 'planned' those helper(s) for a separate effort if/when the most
> important change is accepted and soaked a bit.

The thing is doing it this way generates more churns and noises.  Once
the simpler ones live behind a wrapper which can be built on the
existing interface, we can have both reduced cost and more latitude on
the complex cases.

> > If we do things this way, it breaks all drivers using this interface
> > until they're converted, right?
> 
> Right. And the rest of the series does it.

Which breaks bisection which we shouldn't do.

> > Also, it probably isn't the best idea
> > to flip the behavior like this as this can go completely unnoticed (no
> > compiler warning or anything, the same function just behaves
> > differently).  Maybe it'd be a better idea to introduce a simpler
> > interface that most can be converted to?
> 
> Well, an *other* interface is a good idea. What do you mean with the
> simpler here?

I'm still talking about a simpler wrapper for common cases, which is
the important part anyway.

Thanks.

-- 
tejun
