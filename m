Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45D7D1A06C9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 21:38:14 +1100 (AEDT)
Message-ID: <1452681487.7404.6.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/eeh: Validate arch in eeh_add_device_early()
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 gwshan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org
Date: Wed, 13 Jan 2016 21:38:07 +1100
In-Reply-To: <1452395295-1759-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1452395295-1759-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
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

On Sun, 2016-01-10 at 01:08 -0200, Guilherme G. Piccoli wrote:

> Commit 89a51df5ab1d ("powerpc/eeh: Fix crash in eeh_add_device_early() on Cell")
> added a check on function eeh_add_device_early(): since in Cell arch eeh_ops
> is NULL, that code used to crash on Cell. The commit's approach was validate
> if EEH was available by checking the result of function eeh_enabled().
> 
> Since the function eeh_add_device_early() is used to perform EEH
> initialization in devices added later on the system, like in hotplug/DLPAR
> scenarios, we might reach a case in which no PCI devices are present on boot
> and so EEH is not initialized. Then, if a device is added via DLPAR for
> example, eeh_add_device_early() fails because eeh_enabled() is false.
> 
> We can hit a kernel oops on pSeries arch if eeh_add_device_early() fails:
> if we have no PCI devices on machine at boot time, and then we add a PCI device
> via DLPAR operation, the function query_ddw() triggers the oops on NULL pointer
> dereference in the line "cfg_addr = edev->config_addr;". It happens because
> config_addr in edev is NULL, since the function eeh_add_device_early() was not
> completed successfully.
> 
> This patch just changes the way the arch checking is done in function
> eeh_add_device_early(): we use no more eeh_enabled(), but instead we check the
> running architecture by using the macro machine_is(). If we are running on
> pSeries or PowerNV, the EEH mechanism can be enabled; otherwise, we bail out
> the function. This way, we don't enable EEH on Cell and we don't hit the oops
> on DLPAR either.

But eeh_enabled() is still false? That seems like it's liable to cause breakage
elsewhere.

Shouldn't the PCI hotplug code instead be taught to initialise EEH correctly
when the first device is added?

cheers
