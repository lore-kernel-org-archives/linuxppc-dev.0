Return-Path: <linasvepstas@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 4569FDDF9D
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 01:05:33 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c38so1506039ana.39
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 08:05:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49DF967F.4000205@us.ibm.com>
References: <49DF967F.4000205@us.ibm.com>
Date: Tue, 14 Apr 2009 10:05:31 -0500
Message-ID: <3ae3aa420904140805u6eb24c4ekb910bcaabe21fa74@mail.gmail.com>
Subject: Re: [PATCH] Set error_state to pci_channel_io_normal in
	eeh_report_reset()
From: Linas Vepstas <linasvepstas@gmail.com>
To: Mike Mason <mmlnx@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

2009/4/10 Mike Mason <mmlnx@us.ibm.com>:
> While adding native EEH support to Emulex and Qlogic drivers, it was
> discovered that dev->error_state was set to pci_io_channel_normal too lat=
e
> in the recovery process. These drivers rely on error_state to determine i=
f
> they can access the device in their slot_reset callback, thus error_state
> needs to be set to pci_io_channel_norm in eeh_report_reset(). Below is a
> detailed explanation (courtesy of Richard Lary) as to why this is necessa=
ry.
>
> Background:
> PCI MMIO or DMA accesses to a frozen slot generate additional EEH errors.=
 If
> the number of additional EEH errors exceeds EEH_MAX_FAILS the adapter wil=
l
> be shutdown. To avoid triggering excessive EEH errors and an undesirable
> adapter shutdown, some drivers use the pci_channel_offline(dev) wrapper
> function to return a Boolean value based on the value of
> pci_dev->error_state to determine if PCI MMIO or DMA accesses are safe. I=
f
> the wrapper returns TRUE, drivers must not make PCI MMIO or DMA access to
> their hardware.
>
> The pci_dev structure member error_state reflects one of three values, 1)
> pci_channel_io_normal, 2) pci_channel_io_frozen, 3)
> pci_channel_io_perm_failure. Function pci_channel_offline(dev) returns TR=
UE
> if error_state is pci_channel_io_frozen or pci_channel_io_perm_failure.
>
> The EEH driver sets pci_dev->error_state to pci_channel_io_frozen at the
> point where the PCI slot is frozen. Currently, the EEH driver restores
> dev->error_state to pci_channel_io_normal in eeh_report_resume() before
> calling the driver's resume callback. However, when the EEH driver calls =
the
> driver's slot_reset callback() from eeh_report_reset(), it incorrectly
> indicates the error state is still pci_channel_io_frozen.
>
> Waiting until eeh_report_resume() to restore dev->error_state to
> pci_channel_io_normal is too late for Emulex and QLogic FC drivers and an=
y
> other drivers which are designed to use common code paths in these two
> cases: i) those called after the driver's slot_reset callback() and ii)
> those called after the PCI slot is frozen but before the driver's slot_re=
set
> callback is called. Case i) all driver paths executed to reinitialize the
> hardware after a reset and case ii) all code paths executed by driver ker=
nel
> threads that run asynchronous to the main driver thread, such as interrup=
t
> handlers and worker threads to process driver work queues.
>
> Emulex and QLogic FC drivers are designed with common code paths which
> require that pci_channel_offline(dev) reflect the true state of the
> hardware. The state transitions that the hardware takes from Normal
> Operations to Slot Frozen to Reset to Normal Operations are documented in
> the Power Architecture=E2=84=A2 Platform Requirements+ (PAPR+) in Table 7=
5. PE State
> Control.
>
> PAPR defines the following 3 states:
>
> 0 -- Not reset, Not EEH stopped, MMIO load/store allowed, DMA allowed
> (Normal Operations)
> 1 -- Reset, Not EEH stopped, MMIO load/store disabled, DMA disabled
> 2 -- Not reset, EEH stopped, MMIO load/store disabled, DMA disabled (Slot
> Frozen)
>
> An EEH error places the slot in state 2 (Frozen) and the adapter driver i=
s
> notified that an EEH error was detected. If the adapter driver returns
> PCI_ERS_RESULT_NEED_RESET, the EEH driver calls eeh_reset_device() to pla=
ce
> the slot into state 1 (Reset) and eeh_reset_device completes by placing t=
he
> slot into State 0 (Normal Operations). Upon return from eeh_reset_device(=
),
> the EEH driver calls eeh_report_reset, which then calls the adapter's
> slot_reset callback. At the time the adapter's slot_reset callback is
> called, the true state of the hardware is Normal Operations and should be
> accurately reflected by setting dev->error_state to pci_channel_io_normal=
.
>
> The current implementation of EEH driver does not do so and requires the
> following patch to correct this deficiency.
>
> Signed-off-by: Mike Mason <mmlnx@us.ibm.com>

Yes, the analysis sounds correct; this looks like the
right thing to do.

I'm rather surprised, as this is an "obvious" bug,
and should have been long gone.  I thought that
Emulex, QLogic  were not the only ones that were
using pci_channel_offline(dev) in this fashion.
I thought that the symbios scsi and the e1000 did,
too ... Hmm. Perhaps these used their own, private
flag for the same purpose, and reset it at the earlier,
correct time.

Thanks for the fix!

Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>
