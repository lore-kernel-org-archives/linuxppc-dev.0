Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6611DDDF20
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 00:26:57 +1000 (EST)
Date: Thu, 5 Jul 2007 09:37:42 -0500
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH v2] pcmcia: CompactFlash driver for PA Semi Electra boards
Message-ID: <20070705143742.GB14343@lixom.net>
References: <20070625171221.GA6684@lixom.net>
	<3d37f1da59dc2a063a06bbd6092ed96a@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3d37f1da59dc2a063a06bbd6092ed96a@bga.com>
From: olof@lixom.net (Olof Johansson)
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 27, 2007 at 06:20:38AM -0500, Milton Miller wrote:

> If CONFIG_PCMCIA=m then your notifier is not registered.  The modprobe 
> of your of_driver loads ds.ko, registers the bus, then registers your 
> driver.  When the socket driver tries to dma, the BUG in dma_64 for no 
> archdata.dma_ops triggers.
> 
> It seems like we need
> 
> (1) a notifier that a bus is registered, run before allowing any 
> devices, so that platforms can register bus notifiers by bus name 
> before the devices and drivers are registered.
> 
> (2) a powerpc64 generic pcmcia bus notifier that copys the dma ops from 
> the parent socket.
> 
> (3) something to set the dma_ops to direct_dma_ops on the of device.
> 
> If we don't want (3) to be in the driver (as Christoph previosly 
> mentioned), then it needs to be a seperate bus that reuses the of 
> matching.  This would be similar to how ibmebus is setup.   If I 
> remember the discussion, ibmebus is to provide the alternate dma ops 
> and steals match etc code from the of_platform bus type.
> 
> 
> Oh, is this why you have depends on PCMCIA=y ?

Yes.


-Olof
