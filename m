Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 38AD3B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2012 02:19:09 +1000 (EST)
Message-ID: <1336407543.2540.177.camel@pasglop>
Subject: Re: linux-next oops in windfarm startup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hughd@google.com>
Date: Tue, 08 May 2012 02:19:03 +1000
In-Reply-To: <alpine.LSU.2.00.1205070851020.1416@eggly.anvils>
References: <alpine.LSU.2.00.1205070851020.1416@eggly.anvils>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-05-07 at 08:57 -0700, Hugh Dickins wrote:
> Hi Ben,
> 
> 3.4.0-rc5-next-20120504 and 3.4.0-rc6-next-20120507
> crash while booting the PowerMac G5: I have to revert
> your commit e326b30fda9985a2e7fda6fb9212b86bf025c39
> powerpc/pmac: Convert windfarm_smu_sat to new i2c probing
> to get a working system.

Can you shoot me (privately) a tarball of /proc/device-tree on your
system ?

Cheers,
Ben.

> Actual oops message scrolled off screen, and I didn't note the registers.
> NIP [c000000000376964] of_get_next_child+0x68/0x70
> LR [c000000000376928] of_get_next_child+0x2c/0x70
> Call Trace:
> of_get_next_child
> wf_sat_probe
> i2c_device_probe
> driver_probe_device
> bus_for_each_drv
> device_attach
> i2c_new_device
> i2c_powermac_probe
> platform_drv_probe
> driver_probe_device
> __driver_attach
> bus_for_each_dev
> driver_attach
> bus_add_driver
> driver_register
> platform_driver_register
> i2c_powermac_driver_init
> do_one_initcall
> kernel_init
> kernel_thread
> Instruction dump:
> ebff0040 e87e8008 480b86e9 60000000 38210090 7fe3fb78 e8010010 eba1ffe8
> ebc1fff0 ebe1fff8 7c0803a6 4e800020 <ebfd0038> 4bffffd0 7c0802a6 fbe1fff8
> 
> Hugh
