Return-Path: <gerickson@nuovations.com>
Received: from relay03.pair.com (relay03.pair.com [209.68.5.17])
	by ozlabs.org (Postfix) with SMTP id F21FEDEFA9
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 04:13:17 +1000 (EST)
Date: Tue, 01 Jul 2008 11:13:08 -0700
Subject: Re: [PATCH v2] Parameterize EMAC Multicast Match Handling
From: Grant Erickson <gerickson@nuovations.com>
To: Stefan Roese <sr@denx.de>,
	<benh@kernel.crashing.org>
Message-ID: <C48FC1C4.10254%gerickson@nuovations.com>
In-Reply-To: <200807010837.45282.sr@denx.de>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 6/30/08 11:37 PM, Stefan Roese wrote:
> On Tuesday 01 July 2008, Benjamin Herrenschmidt wrote:
>>> Stefan and/or Ben:
>>> 
>>> Any thoughts on this?
>> 
>> I was hesitating a bit... do we really need to be -that- flexible ?
>> 
>> That is, either that or use some new compatible entry to detect the new
>> reg layout and whack that as a feature bit instead ? The advantage
>> of the later is that we have the possibility of doing conditional
>> compile for kernels that support only a given processor or set of
>> processors (not that we have implemented much of it, but it just
>> becomes Kconfig mumbo jumbo and a little bit of defines in the .h
>> by turning the feature test into a compile-time 0 or 1.
>> 
>> But this isn't a hot path and not a lot of code so maybe not worth
>> bothering... however, it does add 3 properties to the DT and I know
>> embedded people (especially Xilinx) are a bit concerned about the size
>> of the DT when they try to fit it in block RAM...
> 
> Yes, this was my feeling too. Not the size of the dtb but more the increased
> complexity of the EMAC device node. I would prefer Ben's idea with this new
> compatible entry too.

In terms of the device tree expression, you would both favor something akin
to the following?

-              compatible = "ibm,emac-405exr", "ibm,emac4";
+              compatible = "ibm,emac-405exr", "ibm,emac4", "ibm,emac4sync";

Regards,

Grant
