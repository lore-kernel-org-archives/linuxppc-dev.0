Return-Path: <grant.likely@secretlab.ca>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9F096B6FBC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 05:22:13 +1100 (EST)
Received: by werg1 with SMTP id g1so5652954wer.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2012 11:22:10 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: issues calling of_platform_bus_probe() twice
To: Tabi Timur-B04825 <B04825@freescale.com>
In-Reply-To: <4F6609DE.2050001@freescale.com>
References: <31B4E554-FA95-431D-B353-92680CD14A0A@kernel.crashing.org>
 <1331933034.3105.171.camel@pasglop> <20120317072717.738953E08CE@localhost>
 <4F649304.9010001@freescale.com> <20120318090804.C70493E060A@localhost>
 <4F6609DE.2050001@freescale.com>
Date: Sun, 18 Mar 2012 18:22:07 +0000
Message-Id: <20120318182207.627573E07BF@localhost>
Cc: "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>,
 "devicetree-discuss@lists.ozlabs.org Discuss"
 <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 18 Mar 2012 16:14:23 +0000, Tabi Timur-B04825 <B04825@freescale.com> wrote:
> Grant Likely wrote:
> > That's because you're using it wrong.  of_platform_bus_probe() creates
> > platform devices at the starting level and every level below it as
> > described by the bus ids.  It is illegal to call of_platform_bus_probe()
> > twice at the same level in the DT.
> 
> Well, *I* am not using it wrong.  Notice that my patch fixes (or works 
> around) the commit that *did* do it wrong:
> 
> http://patchwork.ozlabs.org/patch/126289/

Fair enough; I just wanted to point out that there it can only dig as
deep into the tree as is specified by the bus ids.  The exact problem
wasn't calling the function twice, but rather trying to call the
function twice from the same level of the tree.

BTW, I also recommend moving to of_platform_populate() for new code.
I think the behaviour is more consistent for fdt platforms and it
is more convenient for devices that are children of the root.

g.
