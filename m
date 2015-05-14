Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C15F41A045F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 10:10:17 +1000 (AEST)
Message-ID: <1431645953.4160.82.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Date: Fri, 15 May 2015 09:25:53 +1000
In-Reply-To: <A748C569-24CF-41B9-BA91-822A67132DA9@antoniou-consulting.com>
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
 <53EAE361-0015-4702-97C6-9F67B87963C2@antoniou-consulting.com>
 <1431585994.4160.32.camel@kernel.crashing.org>
 <3988EABE-3DE9-4E1C-9778-22E35138E359@antoniou-consulting.com>
 <1431587657.4160.37.camel@kernel.crashing.org>
 <75F026CA-5AC1-4106-B2F0-AB0D006DEF5A@antoniou-consulting.com>
 <1431588358.4160.42.camel@kernel.crashing.org>
 <D7FC0542-DD1A-42 8F-8E75-81620C6D83DC@antoniou-consulting.com>
 <1431589652.4160.49.camel@kernel.crashing.org>
 <A748C569-24CF-41B9-BA91-822A67132DA9@antoniou-consulting.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Grant Likely <grant.likely@linaro.org>,
 Rob Herring <robherring2@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-05-14 at 14:02 +0300, Pantelis Antoniou wrote:
> Hi Ben,
> 
> > On May 14, 2015, at 10:47 , Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> 
> [snip]
> 
> So I spend some time thinking about your use case and I think it boils down
> to this:
> 
> I have a live tree in the firmware, I have made changes and I need to reflect
> those changes to the live tree in the kernel.
> 
> Sounds like ‘how do I generate a patch for getting those two in sync'. No?

More or less.

> I can see where this might be useful for others as all.
> 
> I think we really need to create a liblivedt like we have libfdt since
> we have a number of projects going about using/manipulating DT at runtime.
> 
> 1. The linux kernel, with it’s own live tree implementation.
> 2. The device tree compiler (it has a live tree) custom implemented.
> 3. Your weird and wonderful (or wacky) firmware.
> 4. u-boot does use DT now, but it does with libfdt. I believe this is suboptimal.
> 5. barebox does DT as well.
> 
> Most of what we want to do with DT can be abstracted in a library I think that
> all of those projects can use.
> 
> What are your thoughts?

Well, we have at least two implementations, the kernel one and the one
in our OPAL firmware:

https://github.com/open-power/skiboot/blob/master/include/device.h
https://github.com/open-power/skiboot/blob/master/core/device.c

The latter uses some nice Rusty tricks (tm) for multiple argument
functions.

It would make sense to do a library somewhere yes. However, I need to
cut my firmware API pretty much today so I think for now I'll stick
to something Ad-Hoc for the PCI hotplug code that just passes the
bit of FDT with the new devices and leave the "grand project" of live
sync of the tree for later.

There are other implementations of live DT in various Open Firmware
variants out there, most are in Forth which I suggest you don't bother
with unless you enjoy pain, but I think at least one of these is
actually in C.

Cheers,
Ben.
