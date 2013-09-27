Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CC0722C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 08:15:30 +1000 (EST)
Message-ID: <1380320118.27811.48.camel@pasglop>
Subject: Re: Please revert 928bea964827d7824b548c1f8e06eccbbc4d0d7d
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
Date: Sat, 28 Sep 2013 08:15:18 +1000
In-Reply-To: <CAE9FiQW+b7OtN4hJc6uygzbqzaCOkn3WcLDgSg5isHAJfdgmwg@mail.gmail.com>
References: <1380270519.27811.10.camel@pasglop>
 <CAE9FiQVkW7d7vFx_kPJG-FEvO71SZjZmpR+dnwVm61wkYK=0YA@mail.gmail.com>
 <CAE9FiQW+b7OtN4hJc6uygzbqzaCOkn3WcLDgSg5isHAJfdgmwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-09-27 at 10:44 -0700, Yinghai Lu wrote:
> |        /* Get and check PCI Express port services */
> |        capabilities = get_port_device_capability(dev);
> |        if (!capabilities)
> |                return 0;
> |
> |        pci_set_master(dev);
> 
> so how come that pci_set_master is not called for powerpc?
> 
> Can you send out lspci -vvxxx with current linus-tree and v3.11?

Ah good point. It should have ... except that there are a number of ways
for get_port_device_capability() to fail and that should *not* leave the
bridge without the bus master capability set.

However I don't think that's what's happening here. I'll have to dig
more, will get back to you.

Cheers,
Ben.
