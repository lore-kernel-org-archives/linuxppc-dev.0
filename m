Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id EF1381007D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 06:00:44 +1100 (EST)
Date: Thu, 16 Feb 2012 11:00:41 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 1/1] fsldma: ignore end of segments interrupt
Message-ID: <20120216190040.GA9262@ovro.caltech.edu>
References: <1327611520-18256-1-git-send-email-iws@ovro.caltech.edu>
 <CAOZdJXVccE0GqZU2PvAz3RTh+X9ZYZr-9YufxS+mYWJkhSOGEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOZdJXVccE0GqZU2PvAz3RTh+X9ZYZr-9YufxS+mYWJkhSOGEQ@mail.gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 16, 2012 at 05:50:47PM +0000, Tabi Timur-B04825 wrote:
> On Thu, Jan 26, 2012 at 2:58 PM, Ira W. Snyder <iws@ovro.caltech.edu> wrote:
> > The mpc8349ea has been observed to generate spurious end of segments
> > interrupts despite the fact that they are not enabled by this driver.
> > Check for them and ignore them to avoid a kernel error message.
> 
> When this happens, are there any other status bits set?  It seems
> weird that there are spurious interrupts from an internal block,
> especially since it's the same block on all 83xx parts.
> 
> I wonder if the EOSI bit just happens to be set when the interrupt
> occurs for some other reason.
> 

I'm not sure. The fsldma irq handler only prints bits it did not handle.
There are several other bits in the driver which should never be seen,
but they are handled by the irq handler anyway. This is just a remnant
from the original Freescale code.

I have a set of 15 test boards that I can use to figure out which other
bits are set when this happens, if it is important.

I put a variation of this patch (missing the "skip tasklet if not idle"
logic) into my production boards roughly a month ago. I've gotten the
"controller not idle" error message 748 times, as compared to the
"unhandled sr 0x00000002" message 3449 times.

This leads me to believe that this occurs mostly (but not always)
concurrent with the end-of-chain interrupt.

In the last month, the "unhandled sr" error has occurred on 92 out of
120 boards in production use. The statistics are included below. On some
boards, it is much more frequent than on others. All boards have roughly
the same workload.

Another interesting tidbit from my logs: this only occurs on DMA channel
2 (the are numbered starting at 0, it is the 3rd channel). Here is an
example log message:

[3484053.821689] of:fsl-elo-dma e00082a8.dma: chan2: irq: unhandled sr 0x00000002

Thanks,
Ira

     15 serial-number-5
      1 serial-number-16
      8 serial-number-18
     16 serial-number-19
      3 serial-number-20
     21 serial-number-21
      1 serial-number-24
      1 serial-number-26
      3 serial-number-27
      2 serial-number-28
     16 serial-number-29
      4 serial-number-30
      1 serial-number-31
      4 serial-number-32
      5 serial-number-33
      1 serial-number-34
      6 serial-number-35
     18 serial-number-36
      1 serial-number-39
      1 serial-number-40
      2 serial-number-41
     10 serial-number-42
     11 serial-number-43
     32 serial-number-45
      6 serial-number-46
      4 serial-number-47
      1 serial-number-49
      6 serial-number-50
      2 serial-number-51
      4 serial-number-53
      1 serial-number-55
      1 serial-number-57
     15 serial-number-58
      1 serial-number-60
      1 serial-number-62
      1 serial-number-66
      8 serial-number-67
      2 serial-number-75
      1 serial-number-76
     11 serial-number-79
      4 serial-number-80
      8 serial-number-81
      1 serial-number-82
     11 serial-number-84
      2 serial-number-92
     20 serial-number-93
     30 serial-number-94
     19 serial-number-95
     32 serial-number-96
     73 serial-number-97
     18 serial-number-99
     57 serial-number-100
     41 serial-number-101
     28 serial-number-102
      8 serial-number-103
    132 serial-number-107
     60 serial-number-108
     55 serial-number-109
     97 serial-number-110
     18 serial-number-111
     45 serial-number-113
      6 serial-number-114
    123 serial-number-115
     27 serial-number-117
     29 serial-number-118
     12 serial-number-119
     47 serial-number-120
     74 serial-number-121
      8 serial-number-124
    128 serial-number-125
    326 serial-number-128
     84 serial-number-129
     36 serial-number-130
      2 serial-number-131
     75 serial-number-133
     64 serial-number-135
    686 serial-number-137
     97 serial-number-139
     28 serial-number-140
     82 serial-number-141
     36 serial-number-144
     31 serial-number-145
     47 serial-number-147
     60 serial-number-150
     22 serial-number-152
     36 serial-number-154
     57 serial-number-156
     68 serial-number-158
     54 serial-number-159
     37 serial-number-160
     46 serial-number-161
     14 serial-number-162
