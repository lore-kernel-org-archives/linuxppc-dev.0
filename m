Message-Id: <5.1.1.6.0.20030331142706.00a83268@192.168.2.1>
Date: Mon, 31 Mar 2003 15:01:34 +0200
To: Chris Zimman <chris@cryptoapps.com>
From: llandre <r&d@wawnet.biz>
Subject: Re: Script for BDI2000 for IBM 405EP Eval. Board
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030331010848.GA20162@mail.cryptoapps.com>
References: <5.1.1.6.0.20030330184543.00a832e0@dns.struinfo.it>
 <5.1.1.6.0.20030330184543.00a832e0@dns.struinfo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>According to what I see here, you never set up the SDRAM contoller via
>the BDI.  Without that, writing flash using WORKSPACE is pretty unlikely
>to work.
>
> > ; Setup SDRAM Controller
> > ;WDCR   16      0x00000080      ;Select SDTR1
> > ;WDCR   17      0x0086400D      ;SDTR1: SDRAM Timing Register
> > ;WDCR   16      0x00000040      ;Select MB0CF
> > ;WDCR   17      0x00046001      ;MB0CF: 16MB @ 0x00000000
> > ;WDCR   16      0x00000048      ;Select MB2CF
> > ;WDCR   17      0x01046001      ;MB2CF: 16MB @ 0x01000000
> > ;WDCR   16      0x00000030      ;Select RTR
> > ;WDCR   17      0x05F00000      ;RTR: Refresh Timing Register
> > ;WDCR   16      0x00000020      ;Select MCOPT1
> > ;WDCR   17      0x80800000      ;MCOPT1: Enable SDRAM Controller
> >
> > ; Setup MMU info
> > ;WM32    0x000000f4  0x00000000  ;invalidate kernel  page table base
> > ;WM32    0x000000f8  0x00000000  ;invalidate process page table base
> > ;WM32    0x000000f0  0xc00000f4  ;invalidate page table base
>
>In the interim, you can disable the SDRAM scratch workspace and
>you should hopefully be able to write to flash.
>
>At some point though, you're going to have the get the SDRAM setup for
>your board done.
>
>--Chris

First I disabled the scratch workspace and Flash programming was ok.
Then I enabled the workspace again, I set the SDRAM controller with the
same values computed by U-Boot algorithm but it did not work. The same
test  with the values computed by the IBM ROM monitor (Openbios) completed
the programming successfully.
After I fixed the U-Boot code in order to use these correct values but
unfortunately the weird crash still occurs. I'll keep working on it.

Thanks again for your help and best regards.



llandre


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
