Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46D81DDED7
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 22:05:34 +1100 (EST)
Subject: RE: [patch][5/5] powerpc: Add the general support for Embedded
	Floating-Point instructions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhu Ebony-r57400 <ebony.zhu@freescale.com>
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E816A47@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E816A47@zch01exm20.fsl.freescale.net>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 22:05:41 +1100
Message-Id: <1168599942.5011.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Why do we need a separate ret_from_except_spe_full?
> 
> I'm not sure if the kernel will return from exception in a multi-thread
> way, but the truth is if restoring EVRs in exsiting ret_from_except_full,
> some non-SPE exception will try to retore EVR. At that time, the
> MSR[SPE] may not be enabled, which will cause error.

Hrm... you can restore them before returning from the exception if you
are careful about doing that with preempt/irqs off I suppose.

Ben.
