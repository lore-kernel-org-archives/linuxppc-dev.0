Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B6F30DDDEF
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Dec 2008 12:25:59 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix something
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18776.5641.616932.285903@cargo.ozlabs.ibm.com>
References: <18776.5641.616932.285903@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 29 Dec 2008 12:25:50 +1100
Message-Id: <1230513950.15389.33.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-12-29 at 11:12 +1100, Paul Mackerras wrote:
> X has been failing to start on my quad G5 powermac since commit
> 1fd0f52583a85b21a394201b007bc1ee104b235d ("powerpc: Fix domain numbers
> in /proc on 64-bit") went in.  The reason is that the change allows X
> to see the PCI-PCI bridge above the video card (previously it was
> obscured by the fact that there were two "00" directories in
> /proc/bus/pci), and the pciconfig_iobase system call on the bridge is
> failing because of a hack that we have to return information about the
> AGP bus when X asks about bus 0.  This machine doesn't have an AGP bus
> (it has PCI Express) and so the pciconfig_iobase call is returning -1,
> which ultimately causes X to fail to start.
> 
> This fixes it by checking that we have an AGP bridge before
> redirecting the pciconfig_iobase call to return information about the
> AGP bus.  With this, X starts successfully both on a quad G5 with
> PCI Express and on an older dual G5 with AGP.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

(With fixed subject of course :-)

Cheers,
Ben.
