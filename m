Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller
	support	for	ARCH=powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <45470006.1020004@bplan-gmbh.de>
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
	<1162268830.25682.271.camel@localhost.localdomain>
	<4546F68C.6070900@bplan-gmbh.de>
	<1162279296.25682.297.camel@localhost.localdomain>
	<45470006.1020004@bplan-gmbh.de>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 18:58:38 +1100
Message-Id: <1162281518.25682.305.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, sha@pengutronix.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-10-31 at 08:49 +0100, Nicolas DET wrote:

> In this case: shouldn't the platform init correctly setup the hw instead 
> of the Firmware?

No. The device-tree contains the polarity information, it gets passed to
the PIC driver via set_irq_type() anyway so there is no need in theory
to have the HW initialized by the firmware if that is implemented. In
the case where it's not, however, you indeed need to make sure the
firmware have programmed the same settings in the HW as are exposed in
the device-tree.

Ben.
