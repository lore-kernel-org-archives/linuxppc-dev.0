Return-Path: <mmlnx@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 473B6DDFA1
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Apr 2009 04:57:09 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3AItcmx000585
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 12:55:38 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3AIv66P210704
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 12:57:06 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3AIv5ni029036
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 12:57:05 -0600
Message-ID: <49DF967F.4000205@us.ibm.com>
Date: Fri, 10 Apr 2009 11:57:03 -0700
From: Mike Mason <mmlnx@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, linasvepstas@gmail.com,
	paulus@samba.org
Subject: [PATCH] Set error_state to pci_channel_io_normal in eeh_report_reset()
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While adding native EEH support to Emulex and Qlogic drivers, it was 
discovered that dev->error_state was set to pci_io_channel_normal too 
late in the recovery process. These drivers rely on error_state to 
determine if they can access the device in their slot_reset callback, 
thus error_state needs to be set to pci_io_channel_norm in 
eeh_report_reset(). Below is a detailed explanation (courtesy of Richard 
Lary) as to why this is necessary.

Background:
PCI MMIO or DMA accesses to a frozen slot generate additional EEH 
errors. If the number of additional EEH errors exceeds EEH_MAX_FAILS the 
adapter will be shutdown. To avoid triggering excessive EEH errors and 
an undesirable adapter shutdown, some drivers use the 
pci_channel_offline(dev) wrapper function to return a Boolean value 
based on the value of pci_dev->error_state to determine if PCI MMIO or 
DMA accesses are safe. If the wrapper returns TRUE, drivers must not 
make PCI MMIO or DMA access to their hardware.

The pci_dev structure member error_state reflects one of three values, 
1) pci_channel_io_normal, 2) pci_channel_io_frozen, 3) 
pci_channel_io_perm_failure. Function pci_channel_offline(dev) returns 
TRUE if error_state is pci_channel_io_frozen or pci_channel_io_perm_failure.

The EEH driver sets pci_dev->error_state to pci_channel_io_frozen at the 
point where the PCI slot is frozen. Currently, the EEH driver restores 
dev->error_state to pci_channel_io_normal in eeh_report_resume() before 
calling the driver's resume callback. However, when the EEH driver calls 
the driver's slot_reset callback() from eeh_report_reset(), it 
incorrectly indicates the error state is still pci_channel_io_frozen.

Waiting until eeh_report_resume() to restore dev->error_state to 
pci_channel_io_normal is too late for Emulex and QLogic FC drivers and 
any other drivers which are designed to use common code paths in these 
two cases: i) those called after the driver's slot_reset callback() and 
ii) those called after the PCI slot is frozen but before the driver's 
slot_reset callback is called. Case i) all driver paths executed to 
reinitialize the hardware after a reset and case ii) all code paths 
executed by driver kernel threads that run asynchronous to the main 
driver thread, such as interrupt handlers and worker threads to process 
driver work queues.

Emulex and QLogic FC drivers are designed with common code paths which 
require that pci_channel_offline(dev) reflect the true state of the 
hardware. The state transitions that the hardware takes from Normal 
Operations to Slot Frozen to Reset to Normal Operations are documented 
in the Power Architecture™ Platform Requirements+ (PAPR+) in Table 75. 
PE State Control.

PAPR defines the following 3 states:

0 -- Not reset, Not EEH stopped, MMIO load/store allowed, DMA allowed 
(Normal Operations)
1 -- Reset, Not EEH stopped, MMIO load/store disabled, DMA disabled
2 -- Not reset, EEH stopped, MMIO load/store disabled, DMA disabled 
(Slot Frozen)

An EEH error places the slot in state 2 (Frozen) and the adapter driver 
is notified that an EEH error was detected. If the adapter driver 
returns PCI_ERS_RESULT_NEED_RESET, the EEH driver calls 
eeh_reset_device() to place the slot into state 1 (Reset) and 
eeh_reset_device completes by placing the slot into State 0 (Normal 
Operations). Upon return from eeh_reset_device(), the EEH driver calls 
eeh_report_reset, which then calls the adapter's slot_reset callback. At 
the time the adapter's slot_reset callback is called, the true state of 
the hardware is Normal Operations and should be accurately reflected by 
setting dev->error_state to pci_channel_io_normal.

The current implementation of EEH driver does not do so and requires the 
following patch to correct this deficiency.

Signed-off-by: Mike Mason <mmlnx@us.ibm.com>
diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c 
b/arch/powerpc/platforms/pseries/eeh_driver.c
index 380420f..9a2a6e3 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -182,6 +182,8 @@ static void eeh_report_reset(struct pci_dev *dev, 
void *userdata)
if (!driver)
return;

+ dev->error_state = pci_channel_io_normal;
+
eeh_enable_irq(dev);

if (!driver->err_handler ||
