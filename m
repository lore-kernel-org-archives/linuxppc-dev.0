Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z76HW0ryyzDqks
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Dec 2017 11:03:18 +1100 (AEDT)
Message-ID: <1514505758.2743.101.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 2/7] powerpc/kernel: Add uevents in EEH error/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Juan Alvarez
 <jjalvare@linux.vnet.ibm.com>
Cc: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au, seroyer@linux.vnet.ibm.com,
 alex.williamson@redhat.com, aik@ozlabs.ru, ruscur@russell.cc,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bodong@mellanox.com, eli@mellanox.com, saeedm@mellanox.com,
 Keith Busch <keith.busch@intel.com>, Gabriele Paoloni
 <gabriele.paoloni@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Date: Fri, 29 Dec 2017 11:02:38 +1100
In-Reply-To: <20171228232253.GC19819@bhelgaas-glaptop.roam.corp.google.com>
References: <20171218223808.83928-1-bryantly@linux.vnet.ibm.com>
 <20171218223808.83928-3-bryantly@linux.vnet.ibm.com>
 <20171219045009.GC14941@bhelgaas-glaptop.roam.corp.google.com>
 <1513664878.2743.8.camel@kernel.crashing.org>
 <952dac4e-cf22-ed68-1a29-58ac7ed3515a@linux.vnet.ibm.com>
 <20171228232253.GC19819@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-12-28 at 17:22 -0600, Bjorn Helgaas wrote:
> Both paths end up calling the pci_error_handlers.error_detected()
> hook.
> 
> Drivers are not supposed to care what arch they're running on.  If the
> driver supplies an .error_detected() entry point, it's up to the PCI
> core and powerpc code to use it consistently across arches.  That
> means the same uevents (if any) should be emitted from both paths.
> 
> The best way would be to unify the call of .error_detected() so the
> AER path and the powerpc path do it via the same function.  The AER
> report_error_detected() and the powerpc eeh_report_error() do look
> fairly similar, so this seems possible in principle, but I'm not
> holding my breath.

Factoring these callers into a common function that can then do the
uevent for errors makes a lot of sense.

The "resume" path might be trickier, but even then, rather than calling
directly the driver op, it would be easy to have a little wrapper that
does it, which can then also do the uevent.

Ben.
