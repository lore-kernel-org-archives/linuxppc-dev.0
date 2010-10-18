Return-Path: <tmarri@apm.com>
Received: from exprod5og106.obsmtp.com (exprod5og106.obsmtp.com [64.18.0.182])
	by ozlabs.org (Postfix) with SMTP id D5586B7103
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Oct 2010 05:07:48 +1100 (EST)
Received: by qwe5 with SMTP id 5so850658qwe.20
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Oct 2010 11:07:45 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <6cfa2d1c7ecd946ea4acbd3077defa92@mail.gmail.com>
	<1287102354.4194.15.camel@concordia>
In-Reply-To: <1287102354.4194.15.camel@concordia>
MIME-Version: 1.0
Date: Mon, 18 Oct 2010 11:04:46 -0700
Message-ID: <34601e6c4411f49f4107413b69a25db3@mail.gmail.com>
Subject: RE: msi_bitmap.c question
To: michael@ellerman.id.au
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >
> > I am trying to resubmit a patch for MSI support for ppc4xx devices.
> > One of the review feedback was not to use the bit map as it is only
> > for the devices which don=92t have hard wired mapping between interrupt
> > controller interrupts and MSI number. For example intr-ctrl0
> interrupt
> > 20 goes to MSI-0, interrupt 21 goes to MSI-1 ..etc. But when I
> checked
> > freescale SoCs and cell SoCs they have interrupts hard wired to MSI
> > interrupts.
> >
> >
> >
> > Why do they have to use the bitmap and create irqhost, even though
> > they are one-to-one mapped between interrupt controller numbers and
> > MSI ?
>
> I'm not quite sure I understand your question.
>
> The MSI bitmap and the irq_host are two different things.
>
> The MSI bitmap is basically an allocator for hardware numbers that can
> be used for MSI. On some interrupt controllers that might be any
> interrupt that's not used, on others there are restrictions on which
> numbers can be used for MSI, it depends. So it's possible you don't
> need to use that code, but I don't know how your hardware works.
>
> The irq_host is the struct that controls mapping hardware irq numbers
> into linux irq numbers. The cell MSI code has no restrictions on what
> the MSI value is, so it just uses the Linux irq number directly using
> irq_create_direct_mapping().
>

Mike, thanks. Could please you clarify your statement
" The cell MSI code has no restrictions on what  the MSI value is ".
If MSIs are one to one mapped to system interrupt controller
Interrupts, why do we need to create new irq_host? Isn't passing
Interrupt controllers irq_host instance not enough ?

Also when is cascade is needed?

Regards,
Marri
