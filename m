Return-Path: <bhelgaas@google.com>
Received: from mail-ob0-x22a.google.com (mail-ob0-x22a.google.com
 [IPv6:2607:f8b0:4003:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7F80F2C0111
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Apr 2013 02:13:13 +1000 (EST)
Received: by mail-ob0-f170.google.com with SMTP id uy19so2411954obc.15
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Apr 2013 09:13:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365235201.31207.9.camel@pasglop>
References: <201304042158.r34LwEOV010607@d03av02.boulder.ibm.com>
 <CAErSpo5ReUcSPvyBs_u0HLh=90anEREZn4p6EUX4yO52bDBaeg@mail.gmail.com>
 <1365235201.31207.9.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 6 Apr 2013 10:12:48 -0600
Message-ID: <CAErSpo4oaG8-rPVXt=Qb3m3VT6DdkX15Gz8gqPenQTtsLnaM7w@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc: Enable boot_vga sysfs attribute for graphics
 adapters on Power
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 klebers@linux.vnet.ibm.com, sparclinux@vger.kernel.org,
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

On Sat, Apr 6, 2013 at 2:00 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2013-04-05 at 14:11 -0600, Bjorn Helgaas wrote:
>>
>> I think sparc has the same issue in its own copy of
>> of_create_pci_dev().
>>
>> Of course, both of_create_pci_dev() implementations are basically
>> copies of the generic pci_setup_device() that most arches use.  That's
>> the reason why I wish sparc and powerpc had used config space
>> accessors that hid the OF mangling internally so they could use the
>> generic pci_setup_device() instead of cloning it.
>
> I disagree :-) I want the config space accessors to actually do the
> config space access (it might be necessary for some reasons, if anything
> for diagnostic). Also one of the reasons we create devices that way
> originally iirc, is that on older pre-PCIe setups, we could have cases
> of a bridge showing up at function N > 0 without anything at function
> 0.
>
> We are also not allowed to mess with bridge BARs on old EADS bridges,
> and similar issues where the hypervisor can get upset.
>
> A "filtering" config space code would be a lot messier than just
> creating them like we do.

Yeah, maybe so.  I guess it's just hard for me to let go of ideas
until I've tried myself and failed :)

Anyway, I hope putting a little more into alloc_pci_dev() will resolve
this particular issue.

Bjorn
