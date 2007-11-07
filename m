Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 87C57DDE41
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 08:30:13 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA7LToqq017158
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2007 16:29:50 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA7LToUl124934
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2007 16:29:50 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA7LTnQs014498
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2007 16:29:50 -0500
Date: Wed, 7 Nov 2007 15:29:49 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Read back MSI message in rtas_setup_msi_irqs() so restore
	works
Message-ID: <20071107212949.GI4239@austin.ibm.com>
References: <5f47235ce3542c80e043f7f183400ab3d576f1dd.1193113342.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5f47235ce3542c80e043f7f183400ab3d576f1dd.1193113342.git.michael@ellerman.id.au>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, mcarlson@broadcom.com, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, mchan@broadcom.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 23, 2007 at 02:23:44PM +1000, Michael Ellerman wrote:
> There are plans afoot to use pci_restore_msi_state() to restore MSI
> state after a device reset. In order for this to work for the RTAS MSI
> backend, we need to read back the MSI message from config space after
> it has been setup by firmware.
> 
> This should be sufficient for restoring the MSI state after a device
> reset, however we will need to revisit this for suspend to disk if that
> is ever implemented on pseries.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> 
> Linas, can you test this on your setup with your EEH stuff? I haven't got
> any MSI supporting hardware/firmware combination.

Acked-by: Linas Vepstas <linas@austin.ibm.com>

I *finally* was able to get onto some hardware long enough to run this.
And that took a lot of work. Sigh. Yes, this is exactly what I'd wanted.

--linas
