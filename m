Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4A773DDF02
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 07:53:22 +1100 (EST)
Subject: Re: [PROBLEM] Soft lockup on Linux 2.6.27, 2 patches, Cell/PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.64.0810151355470.1133@vixen.sonytel.be>
References: <48F17DE6.106@gmail.com>
	<Pine.LNX.4.64.0810130945260.17287@vixen.sonytel.be>
	<Pine.LNX.4.64.0810141130340.16020@vixen.sonytel.be>
	<1224046194.8157.428.camel@pasglop>
	<Pine.LNX.4.64.0810151050330.1133@vixen.sonytel.be>
	<1224062907.8157.446.camel@pasglop>
	<Pine.LNX.4.64.0810151135330.1133@vixen.sonytel.be>
	<1224070653.8157.452.camel@pasglop>
	<Pine.LNX.4.64.0810151343480.1133@vixen.sonytel.be>
	<1224071392.8157.455.camel@pasglop>
	<Pine.LNX.4.64.0810151355470.1133@vixen.sonytel.be>
Content-Type: text/plain
Date: Thu, 16 Oct 2008 07:53:09 +1100
Message-Id: <1224103989.8157.469.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Aaron Tokhy <atokhy@gmail.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-15 at 14:05 +0200, Geert Uytterhoeven wrote:
> I guess it's auto-enabled when the decrementer interrupt handler exits?
> So shouldn't there be a `bl trace_hardirqs_on' somewhere?

The interrupts are restored to their previous state on exit of
interrupts via the TRACE_AND_RESTORE_IRQ() macro which is called
from entry_64.S in the main restore path and in head_64.S in the
fast path and hashing faults.

Cheers,
Ben.
