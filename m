Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id B9735DE06A
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 21:20:42 +1000 (EST)
In-Reply-To: <20070625171221.GA6684@lixom.net>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3d37f1da59dc2a063a06bbd6092ed96a@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH v2] pcmcia: CompactFlash driver for PA Semi Electra boards
Date: Wed, 27 Jun 2007 06:20:38 -0500
To: Olof Johansson <olof@lixom.net>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Mon, Jun 25, 2007 at 08:39:09PM +0100, Christoph Hellwig wrote:
>> On Mon, Jun 25, 2007 at 12:12:21PM -0500, Olof Johansson wrote:
>>> Driver for the CompactFlash slot on the PA Semi Electra eval board. 
>>> It's
>>> a simple device sitting on localbus, with interrupts and 
>>> detect/voltage
>>> control over GPIO.
>>>
>>> The driver is implemented as an of_platform driver, and adds localbus
>>> as a bus being probed by the of_platform framework.
>>
>> Looks good to me. The only odd thing is the inconsistant use of
>> #ifdef CONFIG_PCMCIA in setup.c.
>
> The ifdef is needed since for CONFIG_PCMCIA=n builds, the bus notifier
> isn't available. I wanted to do the bus notifier registration 
> explicitly
> before the of_platform bus probe to avoid later surprises due to 
> reordered
> initcalls in case it was split up in it's own initcall.

If CONFIG_PCMCIA=m then your notifier is not registered.  The modprobe 
of your of_driver loads ds.ko, registers the bus, then registers your 
driver.  When the socket driver tries to dma, the BUG in dma_64 for no 
archdata.dma_ops triggers.

It seems like we need

(1) a notifier that a bus is registered, run before allowing any 
devices, so that platforms can register bus notifiers by bus name 
before the devices and drivers are registered.

(2) a powerpc64 generic pcmcia bus notifier that copys the dma ops from 
the parent socket.

(3) something to set the dma_ops to direct_dma_ops on the of device.

If we don't want (3) to be in the driver (as Christoph previosly 
mentioned), then it needs to be a seperate bus that reuses the of 
matching.  This would be similar to how ibmebus is setup.   If I 
remember the discussion, ibmebus is to provide the alternate dma ops 
and steals match etc code from the of_platform bus type.


Oh, is this why you have depends on PCMCIA=y ?


> I could add the code under ifdef as well, but it didn't seem too
> critical. Once the second major board comes along I'll probably move it
> out to a per-board file, there's no real need for it just yet.

milton
