Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id DEB3EDDE05
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 16:21:55 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so250038anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 21:21:53 -0800 (PST)
Message-ID: <fa686aa40801312121k7fb3c80bu813f31f82a801d33@mail.gmail.com>
Date: Thu, 31 Jan 2008 22:21:53 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: hwicap driver
In-Reply-To: <20080201010256.22BCCBE006A@mail38-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1201805233-15112-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080201010256.22BCCBE006A@mail38-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/31/08, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
> This includes code for new fifo-based xps_hwicap in addition to the
> older opb_hwicap, which has a significantly different interface.  The
> common code between the two drivers is largely shared.
>
> Significant differences exists between this driver and what is
> supported in the EDK drivers.  In particular, most of the
> architecture-specific code for reconfiguring individual FPGA resources
> has been removed.  This functionality is likely better provided in a
> user-space support library.  In addition, read and write access is
> supported.  In addition, although the xps_hwicap cores support
> interrupt-driver mode, this driver only supports polled operation, in
> order to make the code simpler, and since the interrupt processing
> overhead is likely to slow down the throughput under Linux.
>
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
>
> Fixed to add spinlocks, and a few style issues.

You're probably better off using a semaphore, or more specifically a
MUTEX, to protect the whole fop instead of a spin lock and the flags.
The semantics are simpler if do it with a mutex and the function can
sleep while holding it.

Cheers,
g.
