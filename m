Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 1BB81B6F62
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 07:54:19 +1100 (EST)
Message-ID: <4ED7E975.6090704@freescale.com>
Date: Thu, 1 Dec 2011 14:54:13 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] i2c-mpc: use the cell-index property to enumerate the
 I2C adapters
References: <1322760781-31226-1-git-send-email-timur@freescale.com>
 <4ED7CA64.2080503@freescale.com>
In-Reply-To: <4ED7CA64.2080503@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On 12/01/2011 11:33 AM, Timur Tabi wrote:
>> An I2C device tree node can contain a 'cell-index' property that can be
>> used to enumerate the I2C devices.  If such a property exists, use it
>> to specify the I2C adapter number.
> 
> Didn't we decide a long time ago that this was a bad idea?

I don't see what's wrong with it.

>> This feature is necessary for the Freescale PowerPC audio drivers (e.g.
>> on the P1022DS).  The "machine driver" needs to know the adapter number
>> for each I2C adapter, but it only has access to the device tree.
>> Previously, the I2C nodes always appeared in cell-index order, so the
>> dynamic numbering coincided with the cell-index property.  With commit
>> ab827d97 ("powerpc/85xx: Rework P1022DS device tree"), the I2C nodes are
>> unintentionally reversed in the device tree, and so the machine driver
>> guesses the wrong I2C adapter number.
> 
> What specifically do you need this number for?  What does it represent?

Well, I thought the above paragraph explained it pretty well.

Audio drivers come in sets of four -- machine, ssi, dma, and codec.  The machine driver needs to know which ssi is connected to which codec and which DMA channel(s) it needs to use.  So I extract all this information from the device tree.  

The individual drivers, however, register only with their own subsystem.  So the codec driver, for example, doesn't know anything about device trees -- it just registers as an i2c driver.  That means that the machine driver has to guess what name the codec driver will use when it registers.  In this case, that's the i2c device name, which include the I2C adapter number (adap->nr).  That means that given a device tree node, I need to know what the actual bus number is.

An alternative approach is to create a function like this:

	struct i2c_adapter *i2c_adapter_from_node(struct device_node *np);

I could then just use adap->nr directly.

-- 
Timur Tabi
Linux kernel developer at Freescale
