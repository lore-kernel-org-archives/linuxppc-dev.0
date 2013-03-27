Return-Path: <bhelgaas@google.com>
Received: from mail-oa0-f45.google.com (mail-oa0-f45.google.com
 [209.85.219.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A66012C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 03:59:21 +1100 (EST)
Received: by mail-oa0-f45.google.com with SMTP id o6so9118551oag.32
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 09:59:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364397928.11644.41.camel@pasglop>
References: <1363757079-23550-1-git-send-email-lucaskt@linux.vnet.ibm.com>
 <1363757079-23550-2-git-send-email-lucaskt@linux.vnet.ibm.com>
 <CAErSpo4rc=8mYgwuTO6693QCQJ9nsPsxmh7YAwxMygiVrPQR0A@mail.gmail.com>
 <1364397928.11644.41.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 27 Mar 2013 10:58:55 -0600
Message-ID: <CAErSpo7XmNsE0CtudOUbFj+gg6ZbsegMO_yu8uCG0Ct_QeMMKQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] pci: added pcie_get_speed_cap_mask function
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Airlie <airlied@linux.ie>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 DRI mailing list <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Thadeu Cascardo <cascardo@linux.vnet.ibm.com>,
 Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 27, 2013 at 9:25 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2013-03-26 at 12:39 -0600, Bjorn Helgaas wrote:
>> But we also know pdev is a PCIe device, and I think a PCIe device on a
>> root bus must be a "Root Complex Integrated Endpoint" (PCIe spec sec
>> 1.3.2.3).  Such a device does not have a link at all, so there's no
>> point in fiddling with its link speed.
>
> This is where our IBM hypervisor makes things murky. It doesn't expose
> the PCIe parents (basically somewhat makes PCIe look like PCI except we
> still have the PCIe caps on the child devices, just no access to the
> parent device).

Interesting.  I wonder if we'll trip over this anywhere else, e.g.,
ASPM or other link-related things.  I guess we'll just have to see if
anything else breaks.

> It's garbage but can't be fixed (would break AIX :-)
>
> However we might be able to populate the bus->max_bus_speed from some
> architecture specific quirk and have radeon use that.

That sounds like a good solution to me.  It seems like it's really an
arch-specific deviation from the spec, so it'd be nice to have an
arch-specific solution for it.

Bjorn
