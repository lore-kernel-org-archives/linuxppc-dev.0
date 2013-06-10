Return-Path: <glikely@secretlab.ca>
Received: from mail-ie0-x229.google.com (mail-ie0-x229.google.com
 [IPv6:2607:f8b0:4001:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 244662C02F8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 20:33:46 +1000 (EST)
Received: by mail-ie0-f169.google.com with SMTP id 10so2228892ied.28
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 03:33:40 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20130610090357.GQ18614@n2100.arm.linux.org.uk>
References: <1370825362-11145-1-git-send-email-grant.likely@linaro.org>
 <1370825362-11145-11-git-send-email-grant.likely@linaro.org>
 <20130610090357.GQ18614@n2100.arm.linux.org.uk>
From: Grant Likely <grant.likely@linaro.org>
Date: Mon, 10 Jun 2013 11:33:19 +0100
Message-ID: <CACxGe6tCfvbwxAmTn3EKXifg+GYnTDAQCXuEaEAoHD_QCzmQqw@mail.gmail.com>
Subject: Re: [RFC 10/10] irqchip: Make versatile fpga irq driver a generic chip
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 10, 2013 at 10:03 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 10, 2013 at 01:49:22AM +0100, Grant Likely wrote:
>> This is an RFC patch to convert the versatile FPGA irq controller driver
>> to use generic irq chip. It builds on the series that extends the
>> generic chip code to allow a linear irq domain to contain one or more
>> generic irq chips so that each interrupt controller doesn't need to hand
>> code the generic chip setup.
>
> NAK, this makes functional changes.  You assume that the validity mask is
> a set of zeros followed by a set of ones.  This is not always the case.
> The PIC on Integrator/CP only has bits 29-22 and 11-0 set because 21-12
> are not valid.

Actually, I don't (at least I don't intend to). It chooses the size of
the irq_domain based on fls(), but that is only because the size has
to allocates for both the holes and the active irqs. You'll notice
that gc->unused is set to ~valid, and the generic chip code will
refuse to map in interrupt that isn't supported. If you see something
different, please point out where because that would be a bug.

g.
