Return-Path: <bhelgaas@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35F48B6FB8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Apr 2011 01:25:47 +1000 (EST)
Received: from hpaq5.eem.corp.google.com (hpaq5.eem.corp.google.com
	[172.25.149.5]) by smtp-out.google.com with ESMTP id p34FPfaA015286
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Apr 2011 08:25:41 -0700
Received: from vws2 (vws2.prod.google.com [10.241.21.130])
	by hpaq5.eem.corp.google.com with ESMTP id p34FPNhc001196
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Apr 2011 08:25:40 -0700
Received: by vws2 with SMTP id 2so6341083vws.34
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 04 Apr 2011 08:25:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1301902664.2549.76.camel@pasglop>
References: <1301882694.2549.53.camel@pasglop>
	<1301887630.2549.71.camel@pasglop>
	<1301902664.2549.76.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 4 Apr 2011 09:25:20 -0600
Message-ID: <BANLkTimBD=NfFKGpy0ZTnT9Dcu=dkTHxZg@mail.gmail.com>
Subject: Re: [RFC/PATCH] of: Match PCI devices to OF nodes generically
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 4, 2011 at 1:37 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> powerpc has two different ways of matching PCI devices to their
> corresponding OF node (if any) for historical reasons. The ppc64 one
> does a scan looking for matching bus/dev/fn, while the ppc32 one does a
> scan looking only for matching dev/fn on each level in order to be
> agnostic to busses being renumbered (which Linux does on some
> platforms).
>
> This removes both and instead moves the matching code to the PCI core
> itself. It's the most logical place to do it: when a pci_dev is created,
> we know the parent and thus can do a single level scan for the matching
> device_node (if any).

Some of this is reminiscent of the ACPI/PCI binding we do on x86/ia64,
e.g., acpi_get_pci_dev() and the stuff in drivers/acpi/glue.c.  Have
you looked at that to see if there's any hope of covering both OF and
ACPI with something more generic?

Bjorn
