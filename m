Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1E481A0121
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 21:13:49 +1000 (EST)
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com
 [209.85.213.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6E9AC1400DE
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2014 21:13:48 +1000 (EST)
Received: by mail-ig0-f176.google.com with SMTP id hn18so9480335igb.3
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2014 04:13:46 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1409277356.9191.4.camel@concordia>
References: <1409215247-10195-1-git-send-email-mpe@ellerman.id.au>
 <CAL_Jsq+DSC4DW-ULuFfUjowsCOXbRnXvYSQcLY4inuBuztuh7A@mail.gmail.com>
 <1409277356.9191.4.camel@concordia>
From: Grant Likely <grant.likely@linaro.org>
Date: Fri, 29 Aug 2014 12:13:26 +0100
Message-ID: <CACxGe6u7xK13UEgjM_BWtmXoskgVtJbVSB_wR2LUnAFgfybGSw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Check flat device tree version at boot
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Rob Herring <robh+dt@kernel.org>,
 Rob Herring <robherring2@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29 Aug 2014 02:56, "Michael Ellerman" <mpe@ellerman.id.au> wrote:
>
> On Thu, 2014-08-28 at 09:27 -0500, Rob Herring wrote:
> > On Thu, Aug 28, 2014 at 3:40 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > > In commit e6a6928c3ea1 "of/fdt: Convert FDT functions to use libfdt",
> > > the kernel stopped supporting old flat device tree formats. The minimum
> > > supported version is now 0x10.
> >
> > Ugg. Is that something which needs to be supported? Supporting it at
> > this point would mean adding support to libfdt.
>
> Well it would have been nice to keep supporting v2, dropping it broke
> kexec-tools for example. But it's done now, so we'll just deal with the
> fallout.

Umm, so we broke userspace? That's not okay. At the very least we
should investigate how much work is needed to bring v2 support into
libfdt, or up-rev the flat tree at runtime before we parse it.

We should be able to update it in-line. IIRC, the main difference
between v2 and v0x10 is that only the leaf node name is encoded into
the node instead of the full name. We can loop over the tree and
truncate all the names while filling the unused bytes with FDT NOP
tags. Should be simple. Something like the following:

fixup_old_device_tree(blob)
{
       for (offset = fdt_next_node(blob, -1, &depth);
             offset >= 0 && depth >= 0 && !rc;
             offset = fdt_next_node(blob, offset, &depth)) {
                char *pathp = fdt_get_name(blob, offset, NULL);
                if (*pathp == '/') {
                        char *leaf = kbasename(pathp);
                        int len = strlen(pathp);
                        int newlen = strlen(leaf);
                        strcpy(pathp, leaf); /* copying in place, need
to check make sure this code is safe */
                        node->size = newlen /* fixme - this is just
pseudocode */
                        newlen = FDT_TAGALIGN(newlen);
                        while (newlen < len) {
                                *(pathp + newlen) = FDT_NOP;
                                newlen = FDT_TAGALIGN(newlen+1);
                        }
                }
       }

}

There's probable some more elegance that can be put into the above
block, but you get the idea. That could be run in-place without
copying the tree to another location, and it could possibly be done in
the boot wrapper. Then we'd also be able to get rid of the v2
compatibility code elsewhere in drivers/of/fdt.c because it would
already be taken care of.

g.
