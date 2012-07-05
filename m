Return-Path: <kay@vrfy.org>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
 [209.85.213.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 765B92C01EA
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Jul 2012 21:47:49 +1000 (EST)
Received: by yhfq11 with SMTP id q11so8266540yhf.15
 for <linuxppc-dev@ozlabs.org>; Thu, 05 Jul 2012 04:47:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <16043.1341483625@neuling.org>
References: <1340651142.7037.2.camel@gandalf.stny.rr.com>
 <20120625150722.8cd4f45d.akpm@linux-foundation.org>
 <20120625235531.GB3652@kroah.com>
 <CA+55aFwczZTA=JUahoj_Sw1fQssDwoM2LGJ6g5nPvehTLxnSpg@mail.gmail.com>
 <20120626002307.GA4389@kroah.com>
 <CA+55aFxhYRqcU2EUmcsuLrhgo4FEO6-b+mB57wB3JRiXEp3ZrA@mail.gmail.com>
 <CAPXgP10cPFSmZ5yr6Z4wVtDa+x2J1yQDF57NJXtxjUuxMHm=Lw@mail.gmail.com>
 <CA+55aFzkX=jCC1O6+2oz8meswOqZQ+Q8Ao60q8eAS1G3AuEStQ@mail.gmail.com>
 <1340726856.977.6.camel@mop> <22482.1341471787@neuling.org>
 <CAPXgP11=o5WB4WejaQCSCL-+5e4sL7tfVz_r3Khyrq3SyrMvsA@mail.gmail.com>
 <CAPXgP13u769nSvUdS1iqiVCsxG5nsQd7bNT1=-eNw156U-kPkQ@mail.gmail.com>
 <16043.1341483625@neuling.org>
From: Kay Sievers <kay@vrfy.org>
Date: Thu, 5 Jul 2012 13:47:26 +0200
Message-ID: <CAPXgP11+j+fDexHHmAZbBBidtrydrpWeh3DGWOhkuoybNj9skA@mail.gmail.com>
Subject: Re: [PATCH v3] printk: Have printk() never buffer its data
To: Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@us.ibm.com>, linuxppc-dev@ozlabs.org,
 Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
 Wu Fengguang <fengguang.wu@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 5, 2012 at 12:20 PM, Michael Neuling <mikey@neuling.org> wrote:

> I can only make 2) happen on SMP.  It's when the second CPU is coming up
> and it's printing something.  The first CPU isn't printing anything at
> this stage (there is no garbled console here) so I don't think it's a
> race.  I see it consistently in show_regs().  Every printk without a
> newline.  ie I get this:
> ---
> NIP: c000000000048164 LR: c000000000048160 CTR: 0000000000000000
> REGS: c00000007e59fb50 TRAP: 0700   Tainted: G        W     (3.5.0-rc5-mikey)
> MSR: 9000000000021032
> <
> SF
> ,HV
> ,ME
> ,IR
> ,DR
> ,RI
>>
>   CR: 28000042  XER: 22000000
> SOFTE: 0
> CFAR: c0000000007402f8
> TASK = c00000007e56bb40[0] 'swapper/1' THREAD: c00000007e59c000
>  CPU: 1
> ---
>
> It's consistent for printks without newlines in show_regs().  MSR
> through to XER should all be on the same line.

I see. Something to fix then, I'll have a look.

Does this happen only very early during bootup, or also later when the
box fully initialized?

The output of 'dmesg' later looks always correct, right?

Thanks,
Kay
