Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18476.685.486338.465621@cargo.ozlabs.ibm.com>
Date: Thu, 15 May 2008 19:30:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Liu Dave" <DaveLiu@freescale.com>
Subject: RE: [PATCH] Defer processing of interrupts when the CPU wakes from
	sleepmode
In-Reply-To: <58A20A281BAF1047B4EAE68DE5C0BDC2F168CF@zch01exm21.fsl.freescale.net>
References: <18474.27384.524310.787499@cargo.ozlabs.ibm.com>
	<58A20A281BAF1047B4EAE68DE5C0BDC2F168CF@zch01exm21.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Liu Dave writes:

> Thanks Paul for this patch. The patch looks like very nice.
> But the users have to be aware of the LINK register (LR) not corrupted.

Yes, if you set the _TLF_SLEEPING bit, you need to know what it
does. :)

> So, does power management patch from Scott Wood need to respin?

No, because Scott's original patch did that too.

> BTW, why the fast_exception_return does *not* need clear the reservation
> with stwcx.?

Because we haven't done anything that could have left a dangling
reservation set.

Paul.
