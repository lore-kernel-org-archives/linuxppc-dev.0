Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id DE572DE5E6
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 00:26:56 +1000 (EST)
Received: by gxk14 with SMTP id 14so1905270gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 07:26:54 -0700 (PDT)
Message-ID: <fa686aa40808250726q69a40f9crd814ce52685c071b@mail.gmail.com>
Date: Mon, 25 Aug 2008 08:26:54 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: temerkhanov@cifronik.ru
Subject: Re: [PATCH] [RFC] Fix level IRQ handling on Xilinx INTC with
	ARCH=powerpc
In-Reply-To: <200808251656.00247.temerkhanov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200808251656.00247.temerkhanov@yandex.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 25, 2008 at 6:55 AM, Sergey Temerkhanov
<temerkhanov@yandex.ru> wrote:
> This fixes the missing acknowledge at the end of handle_level_irq().
>
> It adds a field flags to struct irq_chip. If IRQ_CHIP_UNMASK_ACK is set in
> this field, acknowledge is performed before unmasking.

Can this fix be handled in the XINTC controller driver itself?  This
patch unconditionally adds what is essentially a device specific fixup
to *every* Linux platform.  I cannot see that flying very far.

g.
