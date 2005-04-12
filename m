Return-Path: <marcin.dawidowicz@kontron.pl>
Received: from postoffice.rnd.kontron.pl (unknown [217.153.29.44])
	by ozlabs.org (Postfix) with ESMTP id 2D5ED67A33
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 21:05:12 +1000 (EST)
Received: from linux.site (unknown [192.168.3.180])
	by postoffice.rnd.kontron.pl (Postfix) with ESMTP id C1DF82DB2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 12:36:06 +0200 (CEST)
From: Marcin Dawidowicz <marcin.dawidowicz@kontron.pl>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 12 Apr 2005 12:36:18 +0200
References: <200504121214.28076.Schramel.Linux@go.bartec.de>
In-Reply-To: <200504121214.28076.Schramel.Linux@go.bartec.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504121236.19326.marcin.dawidowicz@kontron.pl>
Subject: Re: IDE and PCI
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
On Tuesday 12 of April 2005 12:14, Marco Schramel wrote:
> Hi
>
> we runs a 2.4.25 on a custum board (MPC8270). We use compact flash over
> UPM. All runs fine. But if i config in the pci bus the i/o accesses on
> compact flash will fail. The kernel booting fails and it hangs up. At the
> same time i can read out the cf registers with bdi.
> It crashes on the first INB() call in ide_probe.c.   "stat =
> hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);". Without pci it works fine.

Propably isa_io_base is set to beginning of PCI IO area when PCI is enabled. 
So all io accesses are mapped in different location. In this case you may 
need to add additional offset to default io port addresses for compact flash 
access.

Best regards,
Marcin
