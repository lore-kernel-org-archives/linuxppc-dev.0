Return-Path: <thlin@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 70844B7120
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Jan 2011 09:44:35 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p05MURuV016038
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jan 2011 15:30:27 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p05MiTKe132556
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jan 2011 15:44:29 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p05MiSd5026027
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jan 2011 15:44:28 -0700
Subject: [PATCH v2 0/3] powerpc: Add IO event interrupt support
From: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 05 Jan 2011 16:44:27 -0600
Message-ID: <1294267467.24377.27.camel@flin.austin.ibm.com>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This series of patches adds support for handling IO Event interrupts which
come through at the /event-sources/ibm,io-events device tree node.

Change log from v1:
- Restructure the patch into 3 patches.
  = Move non-IBM specific v6 extended log definition to rtas.h.
  = Move IBM specific v6 extended log definition to pseries_event_log.h
    and code to pseries_event_log.c.
- Add CONFIG_PSERIES_EVENT_LOG to pseries Kconfig
- Add CONFIG_IO_EVENT_IRQ to pseries Kconfig

io_events.h:
- Change C++ comments to C format.
- Add definitions for all known type, sub-types, and scopes.
- Change data type of rpc_data from u32 to u8 as the size of rpc_data is
  specified in rpc_field_len in bytes.
- Set maximum length for rpc_data.
- Change ioei_register_isr() and ioei_unregister_isr() declearation to match
  the change in io_events.c file

io_events.c:
- Use pseries_/PSERIES_ prefix for global symbols.
- Change to use list_head for ioei_consumer list.
- Remove scope from handler registeration.
- Change device_initcall() to machine_device_initcall()
- ioei_register_handler():
  = Return -ENODEV if IOEI not supported on the machine.
  = Change use spin_lock() to use spin_lock_irq().
- ioei_unregister_handler():
  = Change use spin_lock() to use spin_lock_irq().
- ioei_call_consumers():
  = Change spin_lock_irqsave() to spin_lock() because we are called from
    an interrupt handler.
  = Return IRQ_HANDLED/IRQ_NONE if interrupt is handled/not handled.
  = Print an error message if no one claims the interrupt.
- io_event_interrupt():
  = Change to use rtas_data_buf and RTAS_DATA_BUF_SIZE for rtas_call().
  = Loop calling rtas_call() to pull in multiple events in one interrupt.
  = Split IO event section searching code into ioei_get_event().
- init_ioei_IRQ()
  = Check rtas_token() return code.


Signed-off-by: Mark Nelson <markn@au1.ibm.com>
Signed-off-by: Tseng-Hui (Frank) Lin <tsenglin@us.ibm.com>
---
