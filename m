Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 943E61A0452
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:58:07 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 16:58:06 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 494122BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:58:04 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5A6ufIJ57475294
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:56:49 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5A6uFH7011789
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:56:16 +1000
Date: Wed, 10 Jun 2015 16:55:51 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Rob Herring <robherring2@gmail.com>,
 Pantelis Antoniou <panto@antoniou-consulting.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
Message-ID: <20150610065551.GE10935@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <CAL_JsqLrBSB4y_0j+i=kXbDA08HO23JuYjJGHR9nhsPnMC_Zyg@mail.gmail.com>
 <1430521038.7979.70.camel@kernel.crashing.org>
 <A6DF99C6-7059-4670-86D0-6926861F0164@antoniou-consulting.com>
 <1430774063.7979.139.camel@kernel.crashing.org>
 <1431560124.20218.91.camel@kernel.crashing.org>
 <CAL_JsqKqTa5eg3eOqx3bkeNdO_920WwDiRbQaxwWLEWpCypFmA@mail.gmail.com>
 <1431564871.4160.8.camel@kernel.crashing.org>
 <20150607075422.6ECE9C40A12@trevor.secretlab.ca>
 <1433797073.4526.163.camel@kernel.crashing.org>
 <CACxGe6uMijVvU_yK_Yk3GSABHjqxYAwY76WcOJcxAhoPcW02sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACxGe6uMijVvU_yK_Yk3GSABHjqxYAwY76WcOJcxAhoPcW02sQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 08, 2015 at 10:34:13PM +0100, Grant Likely wrote:
>On Mon, Jun 8, 2015 at 9:57 PM, Benjamin Herrenschmidt
><benh@kernel.crashing.org> wrote:
>> On Sun, 2015-06-07 at 08:54 +0100, Grant Likely wrote:
>>> > IE. conceptually, what overlays do today is quite rooted around the idea
>>> > of having a fixed "base" DT and some pre-compiled DTB overlays that
>>> > get added/removed. The design completely ignore the idea of a FW that
>>> > maintains a "live" tree which we want to keep in sync, which is what we
>>> > want to do here, or what we could do with a "live" open firmware
>>> > implementation.
>>>
>>> Right, which is exactly the reason for the changeset/overlay split.
>>> Overlays assume a fixed base, and that overlays are kind of like plug-in
>>> modules. changeset makes no such assumption.
>>
>> So you suggest we create a function that takes an fdt and an "anchor" as input,
>> and expands that FDT below that anchor, but does so by using the changeset API
>> under the hood ?
>>
>> Even that looks somewhat tricky (turn that bit of FDT into a pile of changeset
>> actions), however, I can see how we could create a new function inside changeset
>> to attach a subtree.
>>
>> Ie. of_attach_subtree() (which could have it's own reconfig action but we
>> don't care that much yet), which takes an expanded subtree and an anchor, and
>> calls of_attach_node() in effect for all nodes in there.
>>
>> We could then have a two pass mechanism in our hotplug code:
>>
>>  - Expand the bit of fdt into a separate tree
>>  - Use of_attach_subtree to "add" that subtree to the main tree
>>
>> What do you think ?
>
>I like that.
>

Thanks, Grant and Ben. Currently, I'm collecting more feedbacks for v5. So
it's something I will address in v6.

Thanks,
Gavin

>g.
>
