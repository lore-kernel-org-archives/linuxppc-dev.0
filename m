Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id A011AB6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 11:57:43 +1100 (EST)
Date: Thu, 16 Feb 2012 16:57:37 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Timur Tabi <b04825@freescale.com>
Subject: Re: [PATCH 1/1] fsldma: ignore end of segments interrupt
Message-ID: <20120217005736.GG9262@ovro.caltech.edu>
References: <1327611520-18256-1-git-send-email-iws@ovro.caltech.edu>
 <CAOZdJXVccE0GqZU2PvAz3RTh+X9ZYZr-9YufxS+mYWJkhSOGEQ@mail.gmail.com>
 <20120216190040.GA9262@ovro.caltech.edu>
 <4F3D5A28.4010905@freescale.com>
 <20120216194655.GD9262@ovro.caltech.edu>
 <4F3D5D84.2040609@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F3D5D84.2040609@freescale.com>
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

On Thu, Feb 16, 2012 at 01:48:20PM -0600, Timur Tabi wrote:
> Ira W. Snyder wrote:
> 
> > No. I don't have the ability to connect my P2020 up to an FPGA to
> > recreate the DMA workload that causes this on my 8349EA. I can run the
> > dmatest module, if you'd like.
> 
> I just want to make sure your patch doesn't break 85xx.
> 

I tried both with and without this patch on my P2020 COM Express board.
With both kernels, the board locks up after 20 minutes or so, no
messages to the serial console.

I wouldn't be surprised if there are some memory problems with this
board. In any case, I don't have any reason to believe that this patch
causes any trouble: the board dies without it.

However, the patch doesn't break DMA on 85xx. If I unload the dmatest
module after 10 minutes or so, it claims to have passed many thousands
of tests without problems.

My 8349EA test boards (15 of them) have been running their normal DMA
workload plus dmatest on the unused 4th channel, all without errors, for
several hours. ~2.5 million successful tests per board, as I write this.

Ira
