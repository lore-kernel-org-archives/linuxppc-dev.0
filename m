Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 37A452C02A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 19:04:26 +1000 (EST)
Date: Mon, 10 Jun 2013 10:03:58 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Grant Likely <grant.likely@linaro.org>
Subject: Re: [RFC 10/10] irqchip: Make versatile fpga irq driver a generic chip
Message-ID: <20130610090357.GQ18614@n2100.arm.linux.org.uk>
References: <1370825362-11145-1-git-send-email-grant.likely@linaro.org>
 <1370825362-11145-11-git-send-email-grant.likely@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370825362-11145-11-git-send-email-grant.likely@linaro.org>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 10, 2013 at 01:49:22AM +0100, Grant Likely wrote:
> This is an RFC patch to convert the versatile FPGA irq controller driver
> to use generic irq chip. It builds on the series that extends the
> generic chip code to allow a linear irq domain to contain one or more
> generic irq chips so that each interrupt controller doesn't need to hand
> code the generic chip setup.

NAK, this makes functional changes.  You assume that the validity mask is
a set of zeros followed by a set of ones.  This is not always the case.
The PIC on Integrator/CP only has bits 29-22 and 11-0 set because 21-12
are not valid.
