Return-Path: <olaf@aepfle.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id 367B667B5B
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Dec 2006 05:48:21 +1100 (EST)
Date: Thu, 30 Nov 2006 19:47:48 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_sl82c105 can not reserve IO region
Message-ID: <20061130184748.GA24071@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
	<20061130171049.7b80a40c@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20061130171049.7b80a40c@localhost.localdomain>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 30, Alan wrote:

> I/O region #6.
> 
> pci_request_regions() and pci_request_selcted_regions() end up in a loop
> calling pci_request_region with the values 0 to 5. Never 6.

The printk in pci_request_region has 'bar + 1', so 6 should be possible
if i becomes 5.

I see the failure in 2.6.16 and 2.6.18 too, if that matters. Will look
at it tomorrow.
