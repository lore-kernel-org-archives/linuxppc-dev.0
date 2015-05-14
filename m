Return-Path: <robherring2@gmail.com>
Received: from mail-yk0-x235.google.com (mail-yk0-x235.google.com
 [IPv6:2607:f8b0:4002:c07::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0FB691A001B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 10:19:00 +1000 (AEST)
Received: by ykep21 with SMTP id p21so19465117yke.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 17:18:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1431560124.20218.91.camel@kernel.crashing.org>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-20-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqKEUevxSe0Q=pGdsWOiT+TW9iAnCsAWuuqOYj3ZPOG7dg@mail.gmail.com>
 <1430493730.7979.58.camel@kernel.crashing.org>
 <CAL_JsqLrBSB4y_0j+i=kXbDA08HO23JuYjJGHR9nhsPnMC_Zyg@mail.gmail.com>
 <1430521038.7979.70.camel@kernel.crashing.org>
 <A6DF99C6-7059-4670-86D0-6926861F0164@antoniou-consulting.com>
 <1430774063.7979.139.camel@kernel.crashing.org>
 <1431560124.20218.91.camel@kernel.crashing.org>
From: Rob Herring <robherring2@gmail.com>
Date: Wed, 13 May 2015 19:18:37 -0500
Message-ID: <CAL_JsqKqTa5eg3eOqx3bkeNdO_920WwDiRbQaxwWLEWpCypFmA@mail.gmail.com>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Pantelis Antoniou <panto@antoniou-consulting.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Grant Likely <grant.likely@linaro.org>,
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

On Wed, May 13, 2015 at 6:35 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2015-05-05 at 07:14 +1000, Benjamin Herrenschmidt wrote:
>> So the "trivial" way to do it (and the way we have implemented the FW
>> side so far) is to have the FW simply "flatten" the subtree below the
>> slot and pass it to Linux, with the intent of expanding it back below
>> the slot node.
>>
>> This is what Gavin proposed patches do.
>>
>> The overlay mechanism adds all sorts of features that we don't seen to
>> need and would make the above more complex.
>
> Guys, I never got a final answer from you on this. Are we ok with adding
> the way to just expand a subtree or are you insistent we need to use the
> overlap mechanism ?

I haven't decided really.

The main thing with the current patch is I don't really like the added
complexity to unflatten_dt_node. It is already a fairly complex
function. Perhaps removing of "hybrid" as discussed will help?

If there are things we can do to make overlays easier to use in your
use case, I'd like to hear ideas. I don't really buy that being more
complex than needed is an obstacle. That is very often the case to
have common, scale-able solutions. I want to see a simple case be
simple to support.

Rob
