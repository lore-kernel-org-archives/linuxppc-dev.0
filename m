Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DBB41B7B64
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Dec 2009 09:54:29 +1100 (EST)
Subject: Re: [PATCH] cardbus: Add a fixup hook and fix powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
In-Reply-To: <20091216140128.16afbeb7@jbarnes-piketon>
References: <1260341533.16132.20.camel@pasglop>
	<20091216140128.16afbeb7@jbarnes-piketon>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Dec 2009 09:54:23 +1100
Message-ID: <1261004063.20129.113.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linux-pci@vger.kernel.org,
	blofeldus@yahoo.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-12-16 at 14:01 -0800, Jesse Barnes wrote:

> > Olof, once that's in you should be able to remove the hack you have in
> > the PA-Semi code to work around this.
> > 
> 
> Oops, looks like this fails for the modular case?  I get an unresolved
> symbol error when building this with my default config...
> 
> Care to resend with the fix against my for-linus branch?

Care to send a log ? I fail to see where the problem is since the patch
has:

--- linux-work.orig/drivers/pci/pci.c   2009-12-09 17:33:24.000000000 +1100
+++ linux-work/drivers/pci/pci.c        2009-12-09 17:34:16.000000000 +1100
@@ -2723,6 +2723,11 @@ int __attribute__ ((weak)) pci_ext_cfg_a
        return 1;
 }
 
+void __weak pci_fixup_cardbus(struct pci_bus *bus)
+{
+}
+EXPORT_SYMBOL(pci_fixup_cardbus);

Or is that broken in some way ?

I'm starting to regret trying to use weak stuff :-) I may turn it into a good
old:

#ifndef pcibios_fixup_cardbus
static inline void pcibios_fixup_cardbus(struct pci_bus *bus) { }
#define pcibios_fixup_cardbus
#endif

In a header and have ppc define it.

(And call it pcibios_ instead of pci_ which matches better what other arch
fixups are called :-)

Cheers,
Ben.
