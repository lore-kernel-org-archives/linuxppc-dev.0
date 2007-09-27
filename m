Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2343BDDE2D
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 05:25:55 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8RJPqsO004876
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 15:25:52 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8RJPqLP655320
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 15:25:52 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8RJPq4D018662
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 15:25:52 -0400
Date: Thu, 27 Sep 2007 14:25:51 -0500
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: 2.6.23-rc8 dies somewhere during boot!?
Message-ID: <20070927192551.GK7970@austin.ibm.com>
References: <20070927191233.201980@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070927191233.201980@gmx.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 27, 2007 at 09:12:33PM +0200, Gerhard Pircher wrote:
> Hi,
> 
> I'm working on a 2.6.23 kernel for the AmigaOne.

[...]

> <6>PCI: Probing PCI hardware.
> <7>PCI: Scanning bus 0...
> ...00:00:07.0.
> <7>PCI: Calling quirk...
> ...CI: Found 0000:00:07.2 [1106/303...


Any chance that this thing has an e100 ethernet card in it? 
If so, edit drivers/pci/quirks.c and ifdef out the readb()
in the e100_quirk routine.

We're debating the proper fix on the pci mailing list now.

--linas
