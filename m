Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 752071A02EB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 14:51:35 +1000 (AEST)
Message-ID: <1430715075.7979.115.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Mon, 04 May 2015 14:51:15 +1000
In-Reply-To: <20150504013012.GA15561@gwshan>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-20-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqKEUevxSe0Q=pGdsWOiT+TW9iAnCsAWuuqOYj3ZPOG7dg@mail.gmail.com>
 <1430493730.7979.58.camel@kernel.crashing.org>
 <CAL_JsqLrBSB4y_0j+i=kXbDA08HO23JuYjJGHR9nhsPnMC_Zyg@mail.gmail.com>
 <1430521038.7979.70.camel@kernel.crashing.org>
 <1430522976.7979.78.camel@kernel.crashing.org>
 <1430534906.7979.85.camel@kernel.crashing.org>
 <20150504013012.GA15561@gwshan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-05-04 at 11:30 +1000, Gavin Shan wrote:
> Thanks, Ben. If we really need utilize overlay to support our case,
> we need some one to parse the input (device-tree changes) from
> firmware
> and create "overlay" device node and "target" node as I mentioned
> above.
> It's not simpler than the way we had to support our case. I'm not sure
> if we really need utilize overlay for our case.

No, if we decide to go down that path, then the FW needs to create
the overlay.

This could be done by having some kind of versioning to all nodes and
properties using a global generation count.

Ie, if we "know" what we passed to Linux, we can generate an overlay
that contains everything that changed since then using the version
numbers.

However, we should probably encode the version in the tree itself and
have specific APIs to retrieve "from" a given version to properly deal
with kexec'ing a kernel since in that case, the new kernel will have
something that isn't version 0 but version N where N is the latest
applied overlay.

Also I don't know how removing nodes works with overlay. IE the overlay
system is designed around the idea of removing the overlay to retrieve
the original tree.

In our case, our overlays are meant to be fully committed, and I don't
know whether there's a way to keep track. On unplug, we will just remove
all the nodes below the slot.

Cheers,
Ben.
