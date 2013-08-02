Return-Path: <pladow@gmail.com>
Received: from mail-la0-x22a.google.com (mail-la0-x22a.google.com
 [IPv6:2a00:1450:4010:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3A8B92C007E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 01:02:03 +1000 (EST)
Received: by mail-la0-f42.google.com with SMTP id mf11so520757lab.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Aug 2013 08:01:57 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
In-Reply-To: <CAN8Q1EeAaL-WnRPh77CNQBw3mH+Q2ejFhLKzBMimWu1w37bgcg@mail.gmail.com>
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
 <1371945647.3944.106.camel@pasglop>
 <CAN8Q1EetHpVkWFmbDGCE-3J4H7oJm0zE66SAdJyvtDb7OBc-gg@mail.gmail.com>
 <1373492413.19894.29.camel@pasglop>
 <CAN8Q1EdVVw3ofg9O3o=WThsKpcfMBXe_C7JsSSx9DdRZULW17Q@mail.gmail.com>
 <CAN8Q1EeKCTCB30N50iA8-QB=0aoNtS1U3nNLGVoz7sHG-Qg26A@mail.gmail.com>
 <20130719134615.GR7080@book.gsilab.sittig.org>
 <CAN8Q1EeRWOD1ktGztsaY91VwDYTJmAgwo6XR2baQNb_f7p=FLA@mail.gmail.com>
 <1374640044.3916.109.camel@pasglop>
 <CAN8Q1EdAA6ZfYSdTJ6ieZxjuqTF7Cr9Bt6fo2qejbtXoZ=ce6g@mail.gmail.com>
 <1374703722.6142.5.camel@pasglop>
 <CAN8Q1EeAaL-WnRPh77CNQBw3mH+Q2ejFhLKzBMimWu1w37bgcg@mail.gmail.com>
Date: Fri, 2 Aug 2013 08:01:57 -0700
Message-ID: <CAN8Q1EfqHNC3bK6kn36vraLovFa-CMFzhVhidKnnCqZ=DciNEg@mail.gmail.com>
Subject: Re: Inbound PCI and Memory Corruption
From: Peter LaDow <petela@gocougs.wsu.edu>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 24, 2013 at 11:13 PM, Peter LaDow <petela@gocougs.wsu.edu> wrote:
> There are other items, such as drivers for our custom hardware modules
> implemented on the FPGA.  Perhaps I'll pull our drivers and run a
> stock kernel.  Maybe a stock 83xx configuration (such as the
> MPC8349E-MITX).  If we have problems even on a stock configuration...

Well, that didn't work either.  Unfortunately, the PCI slot on our
MPC8349E-MITX eval kit doesn't work.  It doesn't matter what card I
plug into that slot neither uboot, nor the kernel, recognize anything.

But I did have one thought.  Is it possible that somehow the
configured incoming PCI regions are marked as pre-fetchable, and the
e1000 is prefetching the descriptors?  Then at some later point the
kernel changes things with the e1000 unaware?

Thanks,
Pete
