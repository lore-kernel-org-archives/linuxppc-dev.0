Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.195])
	by ozlabs.org (Postfix) with ESMTP id 09E8867E41
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 11:16:02 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i30so18095wra
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 02 Aug 2005 18:16:00 -0700 (PDT)
Message-ID: <9b7ca65705080218153e286829@mail.gmail.com>
Date: Wed, 3 Aug 2005 10:15:58 +0900
From: Daniel Ann <ktdann@gmail.com>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <0901C40A-7BC0-4227-BEE2-195478DF0CD0@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <0901C40A-7BC0-4227-BEE2-195478DF0CD0@freescale.com>
Cc: linuxppc-embedded Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8245/1 UARTs and linux-2.6.13-rc5
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar,

Just on the subject, I'm finding that I have to define STD_COM_FLAGS
with ASYNC_SKIP_TEST to get my 8245 uart to display on console.
Purpose of ASYNC_SKIP_TEST is to skip below section of code found in
8250.c
[snip]
static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
[snip]
    if (!(up->port.flags & UPF_SKIP_TEST)) {
        serial_outp(up, UART_MCR, UART_MCR_LOOP | 0x0A);
        status1 =3D serial_inp(up, UART_MSR) & 0xF0;
        serial_outp(up, UART_MCR, save_mcr);
        if (status1 !=3D 0x90) {
            DEBUG_AUTOCONF("LOOP test failed (%02x) ",
                       status1);
            goto out;
        }
    }
[end]
If I dont skip, then kernel boots up fine, with all the kernel printk,
but from /sbin/init onwards, I get no display and looking at the uart
interrupt using debugger, I see that interrupt hasnt been enabled. But
if I skip, all works like a charm.

Any idea why ?


On 8/2/05, Kumar Gala <kumar.gala@freescale.com> wrote:
> For all people have issues with the UARTs on MPC8245/1.  In the
> 2.6.13 kernel we reworked the support for UARTs to be platform
> devices.  If you look at the 2.6.13-rc5 release you will see the
> changes that went in.  Additionally, the sandpoint reference platform
> code was updated to take advantage of the changes.
>=20
> Hopefully, these changes will make some of the issues you might be
> facing less of a problem.
>=20
> - kumar
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20


--=20
Daniel
