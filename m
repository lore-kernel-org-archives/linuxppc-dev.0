Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znd6j13lHzF1kQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 15:10:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org,
 torvalds@linux-foundation.org, ruscur@russell.cc, jjalvare@linux.vnet.ibm.com
Subject: Re: [PATCH] PCI/AER: Move pci_uevent_ers() out of pci.h
In-Reply-To: <20180222231236.GB14632@bhelgaas-glaptop.roam.corp.google.com>
References: <20180208122035.9305-1-mpe@ellerman.id.au>
 <dcfc6411-20cf-5b3f-20c5-14167de54700@linux.vnet.ibm.com>
 <20180222231236.GB14632@bhelgaas-glaptop.roam.corp.google.com>
Date: Fri, 23 Feb 2018 15:10:18 +1100
Message-ID: <87h8q8pcr9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Thu, Feb 08, 2018 at 09:05:45AM -0600, Bryant G. Ly wrote:
>> 
>> On 2/8/18 6:20 AM, Michael Ellerman wrote:
>> 
>> > There's no reason pci_uevent_ers() needs to be inline in pci.h, so
>> > move it out to a C file.
>> >
>> > Given it's used by AER the obvious location would be somewhere in
>> > drivers/pci/pcie/aer, but because it's also used by powerpc EEH code
>> > unfortunately that doesn't work in the case where EEH is enabled but
>> > PCIEPORTBUS is not.
>> >
>> > So for now put it in pci-driver.c, next to pci_uevent(), with an
>> > appropriate #ifdef so it's not built if AER and EEH are both disabled.
>> >
>> > While we're moving it also fix up the kernel doc comment for @pdev to
>> > be accurate.
>> >
>> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> > ---
>> >  drivers/pci/pci-driver.c | 36 ++++++++++++++++++++++++++++++++++++
>> >  include/linux/pci.h      | 38 +++-----------------------------------
>> >  2 files changed, 39 insertions(+), 35 deletions(-)
>> 
>> Looks good, thanks for fixing it!
>> 
>> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
>
> This would normally be a "Reviewed-by" unless you actually
> participated in developing the patch, and in that case, your
> "Signed-off-by" would normally be included in the original posting.
>
> What do you intend?  I'll be glad to add either.

I wrote the patch, so Bryant meant Reviewed-by or maybe Acked-by.

cheers
