Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f110.google.com (mail-qy0-f110.google.com
	[209.85.221.110]) by ozlabs.org (Postfix) with ESMTP id 99D48DDF71
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 01:19:06 +1000 (EST)
Received: by qyk8 with SMTP id 8so1259535qyk.17
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Apr 2009 08:19:04 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <49DD8871.2030404@garzik.org>
References: <49DB6914.1030107@freescale.com> <49DD11D1.7060105@freescale.com>
	<49DD1375.8030400@kernel.org> <49DD1465.6070001@freescale.com>
	<49DD17C3.7040607@kernel.org>
	<ed82fe3e0904081515k6e53de00g7d5256f9b61a03da@mail.gmail.com>
	<1239234793.6214.5.camel@localhost>
	<E7CD85E9-BB6E-4598-A734-8D0E67090789@kernel.crashing.org>
	<1239251928.22777.2.camel@localhost> <49DD8871.2030404@garzik.org>
Date: Thu, 9 Apr 2009 10:19:04 -0500
Message-ID: <ed82fe3e0904090819r53d23391qdb18482d4d43fc83@mail.gmail.com>
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
From: Timur Tabi <timur@freescale.com>
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tejun Heo <tj@kernel.org>, Linux PPC Development <linuxppc-dev@ozlabs.org>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 9, 2009 at 12:32 AM, Jeff Garzik <jeff@garzik.org> wrote:
> 3) As a result, Timur's 'ahci' is no longer receiving interrupts. Presuma=
bly
> this means that BOTH of the following conditions are true
>
> =A0 =A0 =A0 =A0a) INTX is disabled
> =A0 =A0 =A0 =A0b) MSI is not available
>
> Today I am thinking we should either revert the libata commit
> (a5bfc4714b3f01365aef89a92673f2ceb1ccf246), or poke PCI to twiddle INTX f=
or
> us at pci_enable_device() time, perhaps.
>
> I lean towards the former, but maybe the platform folks prefer a third
> solution?

Well, I was hoping that the latest U-Boot would fix this problem, but
it doesn't.  Earlier U-Boot couldn't find my SATA drive, so I thought
that was a clue.  The latest U-Boot does find the SATA drive, but the
Linux driver still doesn't get interrupts.

--=20
Timur Tabi
Linux kernel developer at Freescale
