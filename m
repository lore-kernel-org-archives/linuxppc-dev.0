Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znd5r5CNmzF1jd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 15:09:36 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org,
 torvalds@linux-foundation.org, ruscur@russell.cc, bryantly@linux.vnet.ibm.com,
 jjalvare@linux.vnet.ibm.com
Subject: Re: [PATCH] PCI/AER: Move pci_uevent_ers() out of pci.h
In-Reply-To: <20180222231251.GC14632@bhelgaas-glaptop.roam.corp.google.com>
References: <20180208122035.9305-1-mpe@ellerman.id.au>
 <20180222231251.GC14632@bhelgaas-glaptop.roam.corp.google.com>
Date: Fri, 23 Feb 2018 15:09:32 +1100
Message-ID: <87k1v4pcsj.fsf@concordia.ellerman.id.au>
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
> On Thu, Feb 08, 2018 at 11:20:35PM +1100, Michael Ellerman wrote:
>> There's no reason pci_uevent_ers() needs to be inline in pci.h, so
>> move it out to a C file.
>> 
>> Given it's used by AER the obvious location would be somewhere in
>> drivers/pci/pcie/aer, but because it's also used by powerpc EEH code
>> unfortunately that doesn't work in the case where EEH is enabled but
>> PCIEPORTBUS is not.
>> 
>> So for now put it in pci-driver.c, next to pci_uevent(), with an
>> appropriate #ifdef so it's not built if AER and EEH are both disabled.
>> 
>> While we're moving it also fix up the kernel doc comment for @pdev to
>> be accurate.
>> 
>> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Applied to pci/aer for v4.17, thanks!

Thanks.

cheers
