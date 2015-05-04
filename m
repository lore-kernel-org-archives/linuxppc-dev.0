Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E5AD1A029E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 10:24:16 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 4 May 2015 10:24:14 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E098A2BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 10:24:12 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t440O4Hw35127408
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 May 2015 10:24:12 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t440Ndhc030828
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 May 2015 10:23:40 +1000
Date: Mon, 4 May 2015 10:23:14 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
Message-ID: <20150504002314.GA12518@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-20-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqKEUevxSe0Q=pGdsWOiT+TW9iAnCsAWuuqOYj3ZPOG7dg@mail.gmail.com>
 <1430493730.7979.58.camel@kernel.crashing.org>
 <CAL_JsqLrBSB4y_0j+i=kXbDA08HO23JuYjJGHR9nhsPnMC_Zyg@mail.gmail.com>
 <1430521038.7979.70.camel@kernel.crashing.org>
 <1430522976.7979.78.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430522976.7979.78.camel@kernel.crashing.org>
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

On Sat, May 02, 2015 at 09:29:36AM +1000, Benjamin Herrenschmidt wrote:
>On Sat, 2015-05-02 at 08:57 +1000, Benjamin Herrenschmidt wrote:
>
>> > Overlay = an FDT blob to graft into a live running system. Sounds like
>> > the same thing.
>> > 
>> > > As for the details of Gavin implementation, I haven't looked at it in
>> > > details yet so there might be issues there, however I don't know what
>> > > you mean by "overlays", any pointer ?
>> > 
>> > CONFIG_OF_OVERLAY
>> > 
>> > http://events.linuxfoundation.org/sites/events/files/slides/dynamic-dt-keynote-v3.pdf
>> 
>> Well, that looks horrendously complicated, poorly documented and totally
>> unused in-tree outside of the unittest stuff, yay ! It has all sort of
>> "features" that I don't really care about.
>
>Looking a bit more at it, I don't quite see how I can attach a subtree
>using that stuff.
>
>Instead, each node in the overlay seems to need extra nodes and
>properties to refer to the original.
>
>So the FW would essentially have to create something a lot more complex
>than just reflattening a bit of its internal tree. For each internal
>node, it will need to add all those __overlay__ nodes and properties.
>
>That is not going to fly for me at all. It's order of magnitudes more
>complex than the solution we are pursuing.
>
>So I think for our use case, we should continue in the direction of
>having a helper to unflatten a piece of FDT underneath an existing
>node. I don't like the "HYBRID" stuff though, we should not refer to
>the original FDT, we should just make them normal dynamic nodes.
>

The original FDT from firmware is copied over to the memory chunk
allocated from slab by kernel. So we refer to the copy of the FDT,
not original one. Yeah, "HYBRID" wouldn't be a good idea. If we
want make all device nodes and properties of the sub-tree "DYNAMIC",
the FDT hasn't to be copied over from skiboot to kernel, indicating
those dynamic device nodes and properties in the subtree can be
figured out directly from the FDT blob, which is owned by firmware.

Also, it just need small changes to code what we have. Not too much
changes needed.

Thanks,
Gavin
