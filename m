Return-Path: <jwilson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 24206DDE18
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Mar 2008 06:43:02 +1100 (EST)
Message-ID: <47C9B1D3.3020402@redhat.com>
Date: Sat, 01 Mar 2008 14:43:15 -0500
From: Jarod Wilson <jwilson@redhat.com>
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 1/3] firewire: fw-ohci: PPC PMac platform code
References: <tkrat.ac97915a5b51e35b@s5r6.in-berlin.de>
	<tkrat.7e8e04e66a38dcd6@s5r6.in-berlin.de>
In-Reply-To: <tkrat.7e8e04e66a38dcd6@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Richter wrote:
> Copied from ohci1394.c.  This code is necessary to prevent machine check
> exceptions when reloading or resuming the driver.
> 
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

I was able to reproduce the system exception on resume with a 3rd-gen 
Titanium PowerBook G4 667, and this patch does let the system resume 
successfully now.

Not quite clear if there was possibly an updated version coming using 
pci_enable_device() instead of the pair of pmac_call_feature() calls, 
but either way, this is a definite must-have, at least for older ppc 
macs -- my Aluminum PowerBook G4/1.67 suspends and resumes without this 
patch just fine.

Signed-off-by: Jarod Wilson <jwilson@redhat.com>

-- 
Jarod Wilson
jwilson@redhat.com
