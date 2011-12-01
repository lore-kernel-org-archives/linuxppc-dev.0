Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C688EB6F69
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 08:52:53 +1100 (EST)
Message-ID: <4ED7F72F.7050405@freescale.com>
Date: Thu, 1 Dec 2011 15:52:47 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] i2c-mpc: use the cell-index property to enumerate the
 I2C adapters
References: <1322760781-31226-1-git-send-email-timur@freescale.com>
 <4ED7CA64.2080503@freescale.com> <4ED7E975.6090704@freescale.com>
 <4ED7F1AE.70806@freescale.com> <4ED7F5AA.2040909@freescale.com>
In-Reply-To: <4ED7F5AA.2040909@freescale.com>
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

On 12/01/2011 03:46 PM, Timur Tabi wrote:
> Scott Wood wrote:
> 
>> How is this going to interact with other i2c buses (e.g. on a board
>> FPGA) that might have a conflicting static numbering scheme?  Have you
>> ensured that no dynamic bus registrations (e.g. an i2c bus on a PCI
>> device) can happen before the static SoC i2c buses are added?
> 
> Hmm.... You have a point there.
> 
>>> An alternative approach is to create a function like this:
>>>
>>> 	struct i2c_adapter *i2c_adapter_from_node(struct device_node *np);
>>>
>>> I could then just use adap->nr directly.
>>
>> If there isn't a way to get a "struct device" from "struct device_node",
>> we should add it. 
> 
> How do I do that?  Scan all the struct devices until I find one where dev->of_node == np?  That seems really inefficient.

Ideally we would have a field in struct device_node that points to
struct device.

-Scott
