Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87A5EDDE38
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Mar 2008 10:49:01 +1100 (EST)
Subject: Re: [PATCH 1/3] firewire: fw-ohci: PPC PMac platform code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jarod Wilson <jwilson@redhat.com>
In-Reply-To: <47C9B1D3.3020402@redhat.com>
References: <tkrat.ac97915a5b51e35b@s5r6.in-berlin.de>
	<tkrat.7e8e04e66a38dcd6@s5r6.in-berlin.de>
	<47C9B1D3.3020402@redhat.com>
Content-Type: text/plain
Date: Sun, 02 Mar 2008 10:48:24 +1100
Message-Id: <1204415304.15052.464.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Richter <stefanr@s5r6.in-berlin.de>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-03-01 at 14:43 -0500, Jarod Wilson wrote:
> Stefan Richter wrote:
> > Copied from ohci1394.c.  This code is necessary to prevent machine check
> > exceptions when reloading or resuming the driver.
> > 
> > Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> 
> I was able to reproduce the system exception on resume with a 3rd-gen 
> Titanium PowerBook G4 667, and this patch does let the system resume 
> successfully now.
> 
> Not quite clear if there was possibly an updated version coming using 
> pci_enable_device() instead of the pair of pmac_call_feature() calls, 
> but either way, this is a definite must-have, at least for older ppc 
> macs -- my Aluminum PowerBook G4/1.67 suspends and resumes without this 
> patch just fine.

Let's go with Stefan patch for now. I'll find out what's up with
pci_enable_device() later.

Ben.
