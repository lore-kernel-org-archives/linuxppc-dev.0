Return-Path: <thlin@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A16C7B6FE3
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2011 07:29:35 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p2EKA9B5013656
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2011 16:10:09 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 41F3938C803E
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2011 16:29:27 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2EKTU7S224056
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2011 16:29:30 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2EKTUeU018420
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2011 17:29:30 -0300
Subject: [PATCH v3 0/3] powerpc: Add IO event interrupt support
From: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 14 Mar 2011 15:29:29 -0500
Message-ID: <1300134569.803.13.camel@flin.austin.ibm.com>
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

Change log from V2:

- rename RTAS general extended event log version 6 structure from
  rtas_error_log_v6ext to rtas_ext_event_log_v6.
- Re-implement interrupt call list with atomic notifier.

platforms/pseries/io_event_irq.c:
- Move IO Event data copy to ioei_interrupt(). Rename ioei_get_event()
  to ioei_find_event().
- Remove unused ioei_call_handlers(), pseries_ioei_register_handler(),
  pseries_ioei_unregister_handler() as the functions are replaced by
  notifier.

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
