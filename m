Return-Path: <pladow@gmail.com>
Received: from mail-lb0-x22c.google.com (mail-lb0-x22c.google.com
 [IPv6:2a00:1450:4010:c04::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB7CE2C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 16:13:45 +1000 (EST)
Received: by mail-lb0-f172.google.com with SMTP id a16so1210778lbj.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 23:13:40 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
In-Reply-To: <1374703722.6142.5.camel@pasglop>
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
Date: Wed, 24 Jul 2013 23:13:40 -0700
Message-ID: <CAN8Q1EeAaL-WnRPh77CNQBw3mH+Q2ejFhLKzBMimWu1w37bgcg@mail.gmail.com>
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

On Wed, Jul 24, 2013 at 3:08 PM, Benjamin Herrenschmidt
<benh@au1.ibm.com> wrote:
> No, they resolve to the same thing under the hood. Did you do other
> changes ? Could it be another unrelated kernel bug causing something
> like use-after-free of network buffer or similar oddity unrelated to the
> network driver ?

There are other items, such as drivers for our custom hardware modules
implemented on the FPGA.  Perhaps I'll pull our drivers and run a
stock kernel.  Maybe a stock 83xx configuration (such as the
MPC8349E-MITX).  If we have problems even on a stock configuration...

> Have you tried with different kernel versions ?

Funny you mention it.  I just tried 3.10.2 today and we still get the
same memory corruption.  I was hoping that perhaps something had
changed between 3.0 and 3.10 that might clear up the problem, and then
I could bisect to find where it failed.  But unfortunately, 3.10.2
exhibits the same issue.

So clearly this isn't an issue specific to the kernel version.  Though
the e1000 driver looks largely unchanged in 3.10.  So if the problem
is driver related, it would still be there.

Thanks,
Pete
