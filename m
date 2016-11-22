Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN61J1W9RzDvs6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:34:44 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAM0XeV3071263
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 19:34:42 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26v5j4yeyr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 19:34:42 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Mon, 21 Nov 2016 17:34:41 -0700
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [PATCH 1/2] PCI: Add pci_set_vpd_timeout() to set VPD access
 timeout
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <20161121220523.GB4832@bhelgaas-glaptop.roam.corp.google.com>
Date: Mon, 21 Nov 2016 18:34:36 -0600
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Uma Krishnan <ukrishn@linux.vnet.ibm.com>
References: <1479762225-51440-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1479762589-51557-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <20161121220523.GB4832@bhelgaas-glaptop.roam.corp.google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Message-Id: <1FAD9F59-9D03-4032-BCCD-20F45135F211@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bjorn,

> On Nov 21, 2016, at 4:05 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
> Hi Matthew,
>=20
> On Mon, Nov 21, 2016 at 03:09:49PM -0600, Matthew R. Ochs wrote:
>> The PCI core uses a fixed 50ms timeout when waiting for VPD accesses =
to
>> complete. When an access does not complete within this period, a =
warning
>> is logged and an error returned to the caller.
>>=20
>> While this default timeout is valid for most hardware, some devices =
can
>> experience longer access delays under certain circumstances. For =
example,
>> one of the IBM CXL Flash devices can take up to ~120ms in a =
worst-case
>> scenario. These types of devices can benefit from an extended timeout =
that
>> is specific to their hardware constraints.
>>=20
>> To support per-device VPD access timeouts, pci_set_vpd_timeout() is =
added
>> as an exported service. PCI devices will continue to default with the =
50ms
>> timeout and use a per-device timeout when a driver calls this new =
service.
>=20
> Can you include a pointer to something in the spec that's behind the
> default 50ms timeout, or did somebody just pull that number out of the
> air?

AFAIK the PCI spec is silent on VPD access timeouts.

The current 50ms timeout can be traced to Commit 1120f8b8169f ("PCI: =
handle
long delays in VPD access") where the timeout was increased to =
accommodate
specific hardware. Prior to that the wait timeout was dependent upon a =
read or
write with the write waiting up to a maximum of 10ms.

> I'm wondering how we know 50ms or 120ms or 250ms or whatever is the
> right number.  What bad things would happen if we just increased the
> timeout from 50 to 125ms for *all* devices?

You're asking the right questions. The timeout chosen for the CXL flash =
device
was derived through instrumentation, and this was only after witnessing =
VPD
timeout messages in the kernel log at random times.

I originally thought about proposing a blanket increase, but figured the =
scope
might be too broad. There are 2 downsides I see with simply replacing =
50ms
to a larger value:

 - Raising the timeout bar [potentially] raises the total time it takes =
to complete
a VPD access. One would hope that scenarios where every access times out
are very rare and that the max limits are only rarely encountered.

 - It's difficult to settle on a single 'catch all' value. What might be =
fine for h/w
A may end up not working for h/w B (as is the case here). That said, =
given that
50ms has served as the value for roughly nine years I think this point =
doesn't
carry much weight.

>=20
> I don't really want to end up with a bunch of device-specific quirks
> here.  If we have a quirk to work around one defective device, that's
> one thing.  If the spec allows a huge variation in VPD access time,
> that might be something we want to handle=20

I agree 100% and would be more than happy with submitting a patch that
simply increases the value.

-matt
