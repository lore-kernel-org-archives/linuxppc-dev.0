Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8F9C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:47:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7541520878
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qgywn17x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7541520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q4ST3Z2czDqXq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 01:47:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="Qgywn17x"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q4QW4v0xzDqQ8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 01:45:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C3RrKkduP/ZQYdHLSpyXjVwKEYDOsArF9sXCLnbktrQ=; b=Qgywn17xyP8xqpjBHNd7JVoAUF
 bPoDXitaGdh/Y2vB/YBsUWwqfLjRid+Vt2PQdXPQwbaz36ViUD8bWYa9EPrgrmtH514LPe1qqOctf
 RKnBMXf3asE/yJ+N6cZmwBCf+qIujKiKK47XIeWyG3ogewlmiZVzRJm/YAARmdrYEHw+Iz2R9FeaY
 Wp5zcUsI/aGNd0VGLgVYi1tDv5cTbPU/3NI1QuQtkgE3ZQmxA/YcHyoZgsawCz1P85/ofjS1Cc2pc
 T7rjkExMalbvKg0UBYi5D/9nkbS6i1RWQLj0GXf9EnqJicy+t4r8HgtjlMS1mFCtSdxT2r5iWAQZ8
 xhSxDmPw==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJK59-00036U-Ei; Wed, 24 Apr 2019 15:45:11 +0000
Date: Wed, 24 Apr 2019 12:45:05 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 31/63] Documentation: PCI: convert
 pci-error-recovery.txt to reST
Message-ID: <20190424124505.0efbc466@coco.lan>
In-Reply-To: <20190423162932.21428-32-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-32-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: fenghua.yu@intel.com, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Wed, 24 Apr 2019 00:29:00 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/PCI/index.rst                   |   1 +
>  ...or-recovery.txt => pci-error-recovery.rst} | 178 +++++++++---------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 94 insertions(+), 87 deletions(-)
>  rename Documentation/PCI/{pci-error-recovery.txt => pci-error-recovery.rst} (80%)
> 
> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> index c877a369481d..5ee4dba07116 100644
> --- a/Documentation/PCI/index.rst
> +++ b/Documentation/PCI/index.rst
> @@ -13,3 +13,4 @@ Linux PCI Bus Subsystem
>     pci-iov-howto
>     MSI-HOWTO
>     acpi-info
> +   pci-error-recovery
> diff --git a/Documentation/PCI/pci-error-recovery.txt b/Documentation/PCI/pci-error-recovery.rst
> similarity index 80%
> rename from Documentation/PCI/pci-error-recovery.txt
> rename to Documentation/PCI/pci-error-recovery.rst
> index 0b6bb3ef449e..533ec4035bf5 100644
> --- a/Documentation/PCI/pci-error-recovery.txt
> +++ b/Documentation/PCI/pci-error-recovery.rst
> @@ -1,12 +1,13 @@
> +.. SPDX-License-Identifier: GPL-2.0
>  
> -                       PCI Error Recovery
> -                       ------------------
> -                        February 2, 2006
> +==================
> +PCI Error Recovery
> +==================
>  
> -                 Current document maintainer:
> -             Linas Vepstas <linasvepstas@gmail.com>
> -          updated by Richard Lary <rlary@us.ibm.com>
> -       and Mike Mason <mmlnx@us.ibm.com> on 27-Jul-2009

Just wondering: wouldn't be good to preserve the date here?

> +
> +:Authors: - Linas Vepstas <linasvepstas@gmail.com>
> +          - Richard Lary <rlary@us.ibm.com>
> +          - Mike Mason <mmlnx@us.ibm.com>
>  
>  
>  Many PCI bus controllers are able to detect a variety of hardware
> @@ -63,7 +64,8 @@ mechanisms for dealing with SCSI bus errors and SCSI bus resets.
>  
>  
>  Detailed Design
> ----------------
> +===============
> +
>  Design and implementation details below, based on a chain of
>  public email discussions with Ben Herrenschmidt, circa 5 April 2005.
>  
> @@ -73,30 +75,33 @@ pci_driver. A driver that fails to provide the structure is "non-aware",
>  and the actual recovery steps taken are platform dependent.  The
>  arch/powerpc implementation will simulate a PCI hotplug remove/add.
>  
> -This structure has the form:
> -struct pci_error_handlers
> -{
> -	int (*error_detected)(struct pci_dev *dev, enum pci_channel_state);
> -	int (*mmio_enabled)(struct pci_dev *dev);
> -	int (*slot_reset)(struct pci_dev *dev);
> -	void (*resume)(struct pci_dev *dev);
> -};
> -
> -The possible channel states are:
> -enum pci_channel_state {
> -	pci_channel_io_normal,  /* I/O channel is in normal state */
> -	pci_channel_io_frozen,  /* I/O to channel is blocked */
> -	pci_channel_io_perm_failure, /* PCI card is dead */
> -};
> -
> -Possible return values are:
> -enum pci_ers_result {
> -	PCI_ERS_RESULT_NONE,        /* no result/none/not supported in device driver */
> -	PCI_ERS_RESULT_CAN_RECOVER, /* Device driver can recover without slot reset */
> -	PCI_ERS_RESULT_NEED_RESET,  /* Device driver wants slot to be reset. */
> -	PCI_ERS_RESULT_DISCONNECT,  /* Device has completely failed, is unrecoverable */
> -	PCI_ERS_RESULT_RECOVERED,   /* Device driver is fully recovered and operational */
> -};
> +This structure has the form::
> +
> +	struct pci_error_handlers
> +	{
> +		int (*error_detected)(struct pci_dev *dev, enum pci_channel_state);
> +		int (*mmio_enabled)(struct pci_dev *dev);
> +		int (*slot_reset)(struct pci_dev *dev);
> +		void (*resume)(struct pci_dev *dev);
> +	};
> +
> +The possible channel states are::
> +
> +	enum pci_channel_state {
> +		pci_channel_io_normal,  /* I/O channel is in normal state */
> +		pci_channel_io_frozen,  /* I/O to channel is blocked */
> +		pci_channel_io_perm_failure, /* PCI card is dead */
> +	};
> +
> +Possible return values are::
> +
> +	enum pci_ers_result {
> +		PCI_ERS_RESULT_NONE,        /* no result/none/not supported in device driver */
> +		PCI_ERS_RESULT_CAN_RECOVER, /* Device driver can recover without slot reset */
> +		PCI_ERS_RESULT_NEED_RESET,  /* Device driver wants slot to be reset. */
> +		PCI_ERS_RESULT_DISCONNECT,  /* Device has completely failed, is unrecoverable */
> +		PCI_ERS_RESULT_RECOVERED,   /* Device driver is fully recovered and operational */
> +	};
>  
>  A driver does not have to implement all of these callbacks; however,
>  if it implements any, it must implement error_detected(). If a callback
> @@ -134,16 +139,17 @@ shouldn't do any new IOs. Called in task context. This is sort of a
>  
>  All drivers participating in this system must implement this call.
>  The driver must return one of the following result codes:
> -		- PCI_ERS_RESULT_CAN_RECOVER:
> -		  Driver returns this if it thinks it might be able to recover
> -		  the HW by just banging IOs or if it wants to be given
> -		  a chance to extract some diagnostic information (see
> -		  mmio_enable, below).
> -		- PCI_ERS_RESULT_NEED_RESET:
> -		  Driver returns this if it can't recover without a
> -		  slot reset.
> -		- PCI_ERS_RESULT_DISCONNECT:
> -		  Driver returns this if it doesn't want to recover at all.
> +
> +  - PCI_ERS_RESULT_CAN_RECOVER:
> +    Driver returns this if it thinks it might be able to recover
> +    the HW by just banging IOs or if it wants to be given
> +    a chance to extract some diagnostic information (see
> +    mmio_enable, below).
> +  - PCI_ERS_RESULT_NEED_RESET:
> +    Driver returns this if it can't recover without a
> +    slot reset.
> +  - PCI_ERS_RESULT_DISCONNECT:
> +    Driver returns this if it doesn't want to recover at all.

This would look better on both text and html if you format it as:

       - PCI_ERS_RESULT_CAN_RECOVER:
                  Driver returns this if it thinks it might be able to recover
                  the HW by just banging IOs or if it wants to be given
                  a chance to extract some diagnostic information (see
                  mmio_enable, below).
       - PCI_ERS_RESULT_NEED_RESET:
                  Driver returns this if it can't recover without a
                  slot reset.
       - PCI_ERS_RESULT_DISCONNECT:
                  Driver returns this if it doesn't want to recover at all.


>  
>  The next step taken will depend on the result codes returned by the
>  drivers.
> @@ -177,7 +183,7 @@ is STEP 6 (Permanent Failure).
>  >>> get the device working again.  
>  
>  STEP 2: MMIO Enabled
> --------------------
> +--------------------
>  The platform re-enables MMIO to the device (but typically not the
>  DMA), and then calls the mmio_enabled() callback on all affected
>  device drivers.
> @@ -203,23 +209,23 @@ instead will have gone directly to STEP 3 (Link Reset) or STEP 4 (Slot Reset)
>  >>> into one of the next states, that is, link reset or slot reset.  


It sounds you forgot to reformat the note with ">>>", e. g.
something like:

.. note::

    The current powerpc implementation assumes that a device driver will
    *not* schedule or semaphore in this routine; the current powerpc
    implementation uses one kernel thread to notify all devices;
    thus, if one device sleeps/schedules, all devices are affected.
    Doing better requires complex multi-threaded logic in the error
    recovery implementation (e.g. waiting for all notification threads
    to "join" before proceeding with recovery.)  This seems excessively
    complex and not worth implementing.

    The current powerpc implementation doesn't much care if the device
    attempts I/O at this point, or not.  I/O's will fail, returning
    a value of 0xff on read, and writes will be dropped. If more than
    EEH_MAX_FAILS I/O's are attempted to a frozen adapter, EEH
    assumes that the device driver has gone into an infinite loop
    and prints an error to syslog.  A reboot is then required to
    get the device working again.


>  
>  The driver should return one of the following result codes:
> -		- PCI_ERS_RESULT_RECOVERED
> -		  Driver returns this if it thinks the device is fully
> -		  functional and thinks it is ready to start
> -		  normal driver operations again. There is no
> -		  guarantee that the driver will actually be
> -		  allowed to proceed, as another driver on the
> -		  same segment might have failed and thus triggered a
> -		  slot reset on platforms that support it.
> -
> -		- PCI_ERS_RESULT_NEED_RESET
> -		  Driver returns this if it thinks the device is not
> -		  recoverable in its current state and it needs a slot
> -		  reset to proceed.
> -
> -		- PCI_ERS_RESULT_DISCONNECT
> -		  Same as above. Total failure, no recovery even after
> -		  reset driver dead. (To be defined more precisely)
> +  - PCI_ERS_RESULT_RECOVERED
> +    Driver returns this if it thinks the device is fully
> +    functional and thinks it is ready to start
> +    normal driver operations again. There is no
> +    guarantee that the driver will actually be
> +    allowed to proceed, as another driver on the
> +    same segment might have failed and thus triggered a
> +    slot reset on platforms that support it.
> +
> +  - PCI_ERS_RESULT_NEED_RESET
> +    Driver returns this if it thinks the device is not
> +    recoverable in its current state and it needs a slot
> +    reset to proceed.
> +
> +  - PCI_ERS_RESULT_DISCONNECT
> +    Same as above. Total failure, no recovery even after
> +    reset driver dead. (To be defined more precisely)

Same as above, this would look a way better if you format it as:

	- PCI_ERS_RESULT_RECOVERED
		  Driver returns this if it thinks the device is fully
		  functional and thinks it is ready to start
		  normal driver operations again. There is no
		  guarantee that the driver will actually be
		  allowed to proceed, as another driver on the
		  same segment might have failed and thus triggered a
		  slot reset on platforms that support it.

	- PCI_ERS_RESULT_NEED_RESET
		  Driver returns this if it thinks the device is not
		  recoverable in its current state and it needs a slot
		  reset to proceed.

	- PCI_ERS_RESULT_DISCONNECT
		  Same as above. Total failure, no recovery even after
		  reset driver dead. (To be defined more precisely)

>  The next step taken depends on the results returned by the drivers.
>  If all drivers returned PCI_ERS_RESULT_RECOVERED, then the platform
> @@ -293,24 +299,24 @@ device will be considered "dead" in this case.
>  Drivers for multi-function cards will need to coordinate among
>  themselves as to which driver instance will perform any "one-shot"
>  or global device initialization. For example, the Symbios sym53cxx2
> -driver performs device init only from PCI function 0:
> +driver performs device init only from PCI function 0::
>  
> -+       if (PCI_FUNC(pdev->devfn) == 0)
> -+               sym_reset_scsi_bus(np, 0);
> +	+       if (PCI_FUNC(pdev->devfn) == 0)
> +	+               sym_reset_scsi_bus(np, 0);
>  
> -	Result codes:
> -		- PCI_ERS_RESULT_DISCONNECT
> -		Same as above.
> +Result codes:
> +	- PCI_ERS_RESULT_DISCONNECT
> +	  Same as above.
>  
>  Drivers for PCI Express cards that require a fundamental reset must
>  set the needs_freset bit in the pci_dev structure in their probe function.
>  For example, the QLogic qla2xxx driver sets the needs_freset bit for certain
> -PCI card types:
> +PCI card types::
>  
> -+	/* Set EEH reset type to fundamental if required by hba  */
> -+	if (IS_QLA24XX(ha) || IS_QLA25XX(ha) || IS_QLA81XX(ha))
> -+		pdev->needs_freset = 1;
> -+
> +	+	/* Set EEH reset type to fundamental if required by hba  */
> +	+	if (IS_QLA24XX(ha) || IS_QLA25XX(ha) || IS_QLA81XX(ha))
> +	+		pdev->needs_freset = 1;
> +	+
>  
>  Platform proceeds either to STEP 5 (Resume Operations) or STEP 6 (Permanent
>  Failure).

Again, you forgot to convert one note there, just after the above
lines:

.. note::

    The current powerpc implementation does not try a power-cycle
    reset if the driver returned PCI_ERS_RESULT_DISCONNECT.
    However, it probably should.


> @@ -370,23 +376,23 @@ The current policy is to turn this into a platform policy.
>  That is, the recovery API only requires that:
>  
>   - There is no guarantee that interrupt delivery can proceed from any
> -device on the segment starting from the error detection and until the
> -slot_reset callback is called, at which point interrupts are expected
> -to be fully operational.
> +   device on the segment starting from the error detection and until the
> +   slot_reset callback is called, at which point interrupts are expected
> +   to be fully operational.
>  
>   - There is no guarantee that interrupt delivery is stopped, that is,
> -a driver that gets an interrupt after detecting an error, or that detects
> -an error within the interrupt handler such that it prevents proper
> -ack'ing of the interrupt (and thus removal of the source) should just
> -return IRQ_NOTHANDLED. It's up to the platform to deal with that
> -condition, typically by masking the IRQ source during the duration of
> -the error handling. It is expected that the platform "knows" which
> -interrupts are routed to error-management capable slots and can deal
> -with temporarily disabling that IRQ number during error processing (this
> -isn't terribly complex). That means some IRQ latency for other devices
> -sharing the interrupt, but there is simply no other way. High end
> -platforms aren't supposed to share interrupts between many devices
> -anyway :)
> +   a driver that gets an interrupt after detecting an error, or that detects
> +   an error within the interrupt handler such that it prevents proper
> +   ack'ing of the interrupt (and thus removal of the source) should just
> +   return IRQ_NOTHANDLED. It's up to the platform to deal with that
> +   condition, typically by masking the IRQ source during the duration of
> +   the error handling. It is expected that the platform "knows" which
> +   interrupts are routed to error-management capable slots and can deal
> +   with temporarily disabling that IRQ number during error processing (this
> +   isn't terribly complex). That means some IRQ latency for other devices
> +   sharing the interrupt, but there is simply no other way. High end
> +   platforms aren't supposed to share interrupts between many devices
> +   anyway :)
>  
>  >>> Implementation details for the powerpc platform are discussed in
>  >>> the file Documentation/powerpc/eeh-pci-error-recovery.txt  

Another note to be converted:

.. note::

    Implementation details for the powerpc platform are discussed in
    the file Documentation/powerpc/eeh-pci-error-recovery.txt  

    As of this writing, there is a growing list of device drivers with
    patches implementing error recovery. Not all of these patches are in
    mainline yet. These may be used as "examples"::

      drivers/scsi/ipr
      drivers/scsi/sym53c8xx_2
...
      drivers/net/qlge



> diff --git a/MAINTAINERS b/MAINTAINERS
> index 87f930bf32ad..403178958b05 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11965,7 +11965,7 @@ M:	Sam Bobroff <sbobroff@linux.ibm.com>
>  M:	Oliver O'Halloran <oohall@gmail.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
> -F:	Documentation/PCI/pci-error-recovery.txt
> +F:	Documentation/PCI/pci-error-recovery.rst
>  F:	drivers/pci/pcie/aer.c
>  F:	drivers/pci/pcie/dpc.c
>  F:	drivers/pci/pcie/err.c



Thanks,
Mauro
