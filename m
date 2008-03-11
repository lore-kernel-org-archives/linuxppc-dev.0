Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CB28ADE06E
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 09:03:28 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2BM3OYt012673
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 18:03:24 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2BM3OGi089428
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 16:03:24 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2BM3NLp015143
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 16:03:23 -0600
Date: Tue, 11 Mar 2008 17:02:55 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: John.Linn@xilinx.com
Subject: Re: of_serial vs legacy serial support with powerpc arch on 405
Message-ID: <20080311170255.4866e51a@zod.rchland.ibm.com>
In-Reply-To: <20080311150430.153AD3D8066@mail134-sin.bigfish.com>
References: <20080311150430.153AD3D8066@mail134-sin.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 11 Mar 2008 09:04:27 -0600
"John Linn" <John.Linn@xilinx.com> wrote:

> I've searched and found some threads, but it's still not clear to me.
> I'm working on 405 with powerpc and trying to get UART550 working.

Walnut works.  So do Halakeau and Kilauea.  Is your serial port
significantly different from those?

> I know that I need speed, freq, and reg-shift properties in the device
> tree and I have found patches for of_serial.c.

Patches for of_serial.c for what?
 
> I still don't understand when to use of_serial.c (SERIAL_OF_PLATFORM) vs
> the legacy support for serial ports.  Is there any docs that I'm not
> finding that I should read?

There are no docs.  At one time, of_serial was declared as the one true
serial driver, but these days either will do.  The benefit of
legacy_serial is that output is enabled earlier in the boot.

> I don't see a way to configure in the legacy support, but I'm using
> SERIAL_OF and having problems. I don't see the console getting enabled
> even though it found the serial port driver.

You need to have CONFIG_PPC_UDBG_16550 set to bring in legacy_serial.

josh
