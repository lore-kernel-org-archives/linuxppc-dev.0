Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D8BA82C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2012 04:33:52 +1000 (EST)
Message-ID: <5033D488.5040404@freescale.com>
Date: Tue, 21 Aug 2012 13:33:44 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [PATCH V8] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1345457161-4731-1-git-send-email-B38951@freescale.com>
 <5032B455.3080607@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A56A61@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A56A61@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Bradley Hughes <bhughes@silicontkx.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/20/2012 10:26 PM, Jia Hongtao-B38951 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Tuesday, August 21, 2012 6:04 AM
>> To: Jia Hongtao-B38951
>> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Li Yang-
>> R58472; Bradley Hughes
>> Subject: Re: [PATCH V8] powerpc/fsl-pci: Unify pci/pcie initialization
>> code
>>
>> Another interesting case is stxssa8555.dts, which has an i8259 node but
>> no ISA node (are there any other instances of this?).  However, I can't
>> tell if stx_gp3.c is the platform file that goes with this device tree,
>> or if the platform code for stxssa8555 is out-of-tree (or some other file
>> that I'm not seeing).
> 
> MPC8541_CDS and MPC8555_CDS also has i8259 but no ISA node. stx_gp3 seems go
> with stxssa8555.dts but I'm not sure ether.
> 
> So you mean we have to look for i8259 too for determining primary.
> Take device tree as evidence we can tell that real primary ether has isa node
> or i8259 node. And if there is no isa we just arbitrarily designate one.
> 
> If this logic works well then ok.

Yes, but it should be board code that does this, as it's a workaround
for a broken device tree.

Maybe have a common helper function that finds a toplevel PCI bus that
contains a node matching a supplied of_match.  This could be used for
both the ISA lookup and the i8259 lookup, and any other weird thing some
board might have as long as it can be uniquely represented with of_match.

-Scott
