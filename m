Return-Path: <shawnxjin@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.194])
	by ozlabs.org (Postfix) with ESMTP id D1E3967A6B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Apr 2005 09:09:10 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id 40so389892rnz
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Apr 2005 16:09:08 -0700 (PDT)
Message-ID: <c3d0340b0504151609397d73f7@mail.gmail.com>
Date: Fri, 15 Apr 2005 16:09:08 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20050415221235.GA29802@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c3d0340b05041514362746169a@mail.gmail.com>
	<20050415221235.GA29802@gate.ebshome.net>
Subject: Re: Interrupt prioritization on linux for ppc440
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/15/05, Eugene Surovegin <ebs@ebshome.net> wrote:
> On Fri, Apr 15, 2005 at 02:36:51PM -0700, Shawn Jin wrote:
> >
> > The home-made interrupt controller PIC supports interrupt priorities
> > and critical/non-critical interrupts. I found that the current kernel
> > doesn't support interrupt priorities.
>=20
> Yes, we don't have IRQ priorities on 4xx. Theoretically, they can be
> emulated in get_irq, but I really don't think it's worth it.

Hmmm...that's one way I thought of to implement IRQ priority. Why
isn't it worth it? ppc4xx_pic gets the first irq from the least
significant bit by calling ffs(). So theoretically and maybe
practically some external interrupts will keep UART's interrupt from
being served.

> > Is this observation true? Is
> > there any existing patch to support that?
>=20
> I'm not aware of such patch existence.

By googling the Internet I found this patch for i386 architecture
http://home.t-online.de/home/Bernhard_Kuhn/rtirq/20040304/rtirq.html.
This mustn't have been caught sight of by linux mainstream.

Anybody knows if RTAI or RTLinux supports IRQ priorities?

> > I noticed that the implementation of ppc4xx_pic.c disables all
> > critical interrupts during initialization. To support critical
> > interrupts, is it so simple that we change the handler of critical
> > exception from CriticalInput to do_IRQ in head_44x.S?
>=20
> No, it's not that simple. Linux doesn't support a notion of critical
> IRQs versus normal ones. Until there is an infrastructure for this, it
> doesn't make any sense to implement 4xx support.

What kind of infrastructure can you think of to support this? ppc440
at least provides some interrupt processing registers (CSSR0/1) to
differentiate critical and non-critical interrupts.

Another confusion about 440GP/GX UIC is the registers VCR (Vector
Configuration Reg) and VR (Vector Reg). They seem to be totally
useless on linux. The interrupt vector is already in the table of
irq_desc[]. Why does the controller have to generate the address?

Thanks for the inputs. Welcome more.

Regards,
-Shawn.
