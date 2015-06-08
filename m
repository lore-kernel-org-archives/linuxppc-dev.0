Return-Path: <glikely@secretlab.ca>
Received: from mail-ob0-f174.google.com (mail-ob0-f174.google.com
 [209.85.214.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 318481A035C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 07:34:36 +1000 (AEST)
Received: by obcej4 with SMTP id ej4so59788obc.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2015 14:34:33 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1433797073.4526.163.camel@kernel.crashing.org>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-20-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqKEUevxSe0Q=pGdsWOiT+TW9iAnCsAWuuqOYj3ZPOG7dg@mail.gmail.com>
 <1430493730.7979.58.camel@kernel.crashing.org>
 <CAL_JsqLrBSB4y_0j+i=kXbDA08HO23JuYjJGHR9nhsPnMC_Zyg@mail.gmail.com>
 <1430521038.7979.70.camel@kernel.crashing.org>
 <A6DF99C6-7059-4670-86D0-6926861F0164@antoniou-consulting.com>
 <1430774063.7979.139.camel@kernel.crashing.org>
 <1431560124.20218.91.camel@kernel.crashing.org>
 <CAL_JsqKqTa5eg3eOqx3bkeNdO_920WwDiRbQaxwWLEWpCypFmA@mail.gmail.com>
 <1431564871.4160.8.camel@kernel.crashing.org>
 <20150607075422.6ECE9C40A12@trevor.secretlab.ca>
 <1433797073.4526.163.camel@kernel.crashing.org>
From: Grant Likely <grant.likely@linaro.org>
Date: Mon, 8 Jun 2015 22:34:13 +0100
Message-ID: <CACxGe6uMijVvU_yK_Yk3GSABHjqxYAwY76WcOJcxAhoPcW02sQ@mail.gmail.com>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rob Herring <robherring2@gmail.com>,
 Pantelis Antoniou <panto@antoniou-consulting.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 8, 2015 at 9:57 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sun, 2015-06-07 at 08:54 +0100, Grant Likely wrote:
>> > IE. conceptually, what overlays do today is quite rooted around the idea
>> > of having a fixed "base" DT and some pre-compiled DTB overlays that
>> > get added/removed. The design completely ignore the idea of a FW that
>> > maintains a "live" tree which we want to keep in sync, which is what we
>> > want to do here, or what we could do with a "live" open firmware
>> > implementation.
>>
>> Right, which is exactly the reason for the changeset/overlay split.
>> Overlays assume a fixed base, and that overlays are kind of like plug-in
>> modules. changeset makes no such assumption.
>
> So you suggest we create a function that takes an fdt and an "anchor" as input,
> and expands that FDT below that anchor, but does so by using the changeset API
> under the hood ?
>
> Even that looks somewhat tricky (turn that bit of FDT into a pile of changeset
> actions), however, I can see how we could create a new function inside changeset
> to attach a subtree.
>
> Ie. of_attach_subtree() (which could have it's own reconfig action but we
> don't care that much yet), which takes an expanded subtree and an anchor, and
> calls of_attach_node() in effect for all nodes in there.
>
> We could then have a two pass mechanism in our hotplug code:
>
>  - Expand the bit of fdt into a separate tree
>  - Use of_attach_subtree to "add" that subtree to the main tree
>
> What do you think ?

I like that.

g.
