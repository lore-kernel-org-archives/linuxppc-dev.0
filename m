Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 59EDB2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jul 2013 06:14:02 +1000 (EST)
Received: from mail-vb0-f48.google.com (mail-vb0-f48.google.com
 [209.85.212.48])
 by muin.pair.com (Postfix) with ESMTPSA id 61A638FC0F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2013 16:14:00 -0400 (EDT)
Received: by mail-vb0-f48.google.com with SMTP id w15so3483424vbf.35
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2013 13:13:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAN8Q1EeKCTCB30N50iA8-QB=0aoNtS1U3nNLGVoz7sHG-Qg26A@mail.gmail.com>
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
 <1371945647.3944.106.camel@pasglop>
 <CAN8Q1EetHpVkWFmbDGCE-3J4H7oJm0zE66SAdJyvtDb7OBc-gg@mail.gmail.com>
 <1373492413.19894.29.camel@pasglop>
 <CAN8Q1EdVVw3ofg9O3o=WThsKpcfMBXe_C7JsSSx9DdRZULW17Q@mail.gmail.com>
 <CAN8Q1EeKCTCB30N50iA8-QB=0aoNtS1U3nNLGVoz7sHG-Qg26A@mail.gmail.com>
Date: Fri, 19 Jul 2013 15:13:59 -0500
Message-ID: <CAOZdJXVgZb+7RJ+sfGMHbJDyE+vAudMP1n4V0Wxt0w6UXjU5TA@mail.gmail.com>
Subject: Re: Inbound PCI and Memory Corruption
From: Timur Tabi <timur@tabi.org>
To: Peter LaDow <petela@gocougs.wsu.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 18, 2013 at 4:30 PM, Peter LaDow <petela@gocougs.wsu.edu> wrote:
>
> It does seem that for incoming PCI transactions the Freescale DMA
> engine is not used.  And in our device tree we have the DMA engine
> commented out.  That is, the "fsl,mpc8349-dma" and "fsl,elo-dma"
> compatible items are not present in the FDT.


This is the standard on-chip DMA engine used (primarily) as an
off-loaded memcpy.  I've never seen it used for anything related to
PCI.  You can remove the DMA nodes from the device tree and see if
that fixes anything.  If it does, then it might be the DMA offload
from the network layer that's causing the problems.
