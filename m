Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ED6E82C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2012 04:24:41 +1000 (EST)
Message-ID: <5033D25E.5000703@freescale.com>
Date: Tue, 21 Aug 2012 13:24:30 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH V8] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1345457161-4731-1-git-send-email-B38951@freescale.com>
 <5032B455.3080607@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A56A61@039-SN1MPN1-002.039d.mgd.msft.net>
 <94F013E7935FF44C83EBE7784D62AD3F093BD870@039-SN2MPN1-023.039d.mgd.msft.net>,
 <5033C250.2000904@freescale.com>
 <C22578AD-1B40-4F3A-AB3B-4ECABE218815@freescale.com>
In-Reply-To: <C22578AD-1B40-4F3A-AB3B-4ECABE218815@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Bradley Hughes <bhughes@silicontkx.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/21/2012 01:09 PM, Li Yang-R58472 wrote:
> 
> 
> On Aug 22, 2012, at 1:16, "Wood Scott-B07421" <B07421@freescale.com> wrote:
> 
>> On 08/21/2012 01:49 AM, Li Yang-R58472 wrote:
>>> If there is i8259 node in the device tree, it should be suggesting
>>> that there is a PCI to ISA bridge but not explicitly described in the
>>> device tree.  Then we need to fix the device tree to add the ISA
>>> nodes.
>>
>> No, we need to work with existing device trees.  Just because they're
>> hosted in the kernel tree doesn't mean they can be treated as an
>> internal kernel implementation detail.  They are stable API with
>> external entities such as bootloaders and hypervisors, get forked for
>> custom boards, etc.
> 
> You are right that device tree binding is a stable API but not a poorly written dts instance.
>
> We are not changing any binding definition.  It is just adding the
> somehow missed node that should be there in some poorly written dts
> in the first place according to current binding.  Is it making any
> sense to have ISA devices directly under pci bus?

I agree in general, but in this case it's easy enough to work with
existing trees, and the workaround is localized to platform code for the
boards with the problem.  Adding this workaround doesn't prevent adding
an isa node to the device tree.

>> Boards with this problem should set fsl_pci_primary in platform code
>> based on whatever criteria is relevant.
> 
> I don't know how legitimate it is to use a new kernel but not the
> device tree from that source. 

It's legitimate, if a bit risky because we have a history of not getting
device trees right the first time (but it should still be a goal).
Conisder that significant parts of the device tree often come from
firmware rather than the .dts.  As I've said a few times in the past, I
think the device trees should be kept in the U-Boot tree rather than
Linux (only those that are meant to be used with U-Boot, of course).
It's a U-Boot internal implementation issue what comes from the .dts and
what gets fixed up or generated at runtime.

-Scott
