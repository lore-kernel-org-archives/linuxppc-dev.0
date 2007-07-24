Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 95162DDE40
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 18:04:46 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/6 v2] 85xxCDS: Misc 8548 PCI Corrections.
Date: Tue, 24 Jul 2007 09:07:40 +0200
References: <46A10578.6030609@mvista.com> <46A4ED9E.6010307@mvista.com>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E957AB6@zch01exm23.fsl.freescale.net>
In-Reply-To: <7EA18FDD2DC2154AA3BD6D2F22A62A0E957AB6@zch01exm23.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707240907.40392.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 24 July 2007, Zang Roy-r61911 wrote:
> > From: Randy Vinson [mailto:rvinson@mvista.com] 
> > I don't think you can have 2 primary bridges.
>
> Why?
> They belong to two separate pci domain.

PCI host bridge == PCI domain

A PHB canhave multiple buses, but only one PHB can be
the primary one, which is defined as being the one
that can hold ISA device. The problem is that ISA does
not support multiple domains, so all devices with
well-known ISA I/O port addresses have to be on the
same PHB.

	Arnd <><
