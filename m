Return-Path: <grant.likely@secretlab.ca>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B2011B6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2012 20:08:12 +1100 (EST)
Received: by wibhn6 with SMTP id hn6so2133974wib.14
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2012 02:08:07 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: issues calling of_platform_bus_probe() twice
To: Tabi Timur-B04825 <B04825@freescale.com>
In-Reply-To: <4F649304.9010001@freescale.com>
References: <31B4E554-FA95-431D-B353-92680CD14A0A@kernel.crashing.org>
 <1331933034.3105.171.camel@pasglop> <20120317072717.738953E08CE@localhost>
 <4F649304.9010001@freescale.com>
Date: Sun, 18 Mar 2012 09:08:04 +0000
Message-Id: <20120318090804.C70493E060A@localhost>
Cc: "devicetree-discuss@lists.ozlabs.org Discuss"
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

On Sat, 17 Mar 2012 13:35:02 +0000, Tabi Timur-B04825 <B04825@freescale.com> wrote:
> Grant Likely wrote:
> >>> >  >  Are you aware of any reason that we can't call of_platform_bus_probe()
> >>> >  >  or multiple times.  Timur's run into an issue in which all devices
> >>> >  >  don't get registered properly if we call of_platform_bus_probe() times
> >>> >  >  with different of_device_id struct's.
> >> >
> >> >  Nothing comes to mind... Grant ?
> > Neither for me.  Should work.
> 
> I posted a work-around patch here:
> 
> http://patchwork.ozlabs.org/patch/128533/
> 
> Without this patch, drivers cannot probe on DMA *channels*, or any other 
> grandchildren of the root node.

That's because you're using it wrong.  of_platform_bus_probe() creates
platform devices at the starting level and every level below it as
described by the bus ids.  It is illegal to call of_platform_bus_probe()
twice at the same level in the DT.

g.
