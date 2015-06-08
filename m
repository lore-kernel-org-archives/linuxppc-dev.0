Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 86A4E1A01C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 06:58:21 +1000 (AEST)
Message-ID: <1433797073.4526.163.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, Pantelis Antoniou
 <panto@antoniou-consulting.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Date: Tue, 09 Jun 2015 06:57:53 +1000
In-Reply-To: <20150607075422.6ECE9C40A12@trevor.secretlab.ca>
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
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-06-07 at 08:54 +0100, Grant Likely wrote:
> > IE. conceptually, what overlays do today is quite rooted around the idea
> > of having a fixed "base" DT and some pre-compiled DTB overlays that
> > get added/removed. The design completely ignore the idea of a FW that
> > maintains a "live" tree which we want to keep in sync, which is what we
> > want to do here, or what we could do with a "live" open firmware
> > implementation.
> 
> Right, which is exactly the reason for the changeset/overlay split.
> Overlays assume a fixed base, and that overlays are kind of like plug-in
> modules. changeset makes no such assumption.

So you suggest we create a function that takes an fdt and an "anchor" as input,
and expands that FDT below that anchor, but does so by using the changeset API
under the hood ?

Even that looks somewhat tricky (turn that bit of FDT into a pile of changeset
actions), however, I can see how we could create a new function inside changeset
to attach a subtree.

Ie. of_attach_subtree() (which could have it's own reconfig action but we
don't care that much yet), which takes an expanded subtree and an anchor, and
calls of_attach_node() in effect for all nodes in there.

We could then have a two pass mechanism in our hotplug code:

 - Expand the bit of fdt into a separate tree
 - Use of_attach_subtree to "add" that subtree to the main tree

What do you think ?

Ben.
