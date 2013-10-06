Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A2FEF2C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Oct 2013 21:01:38 +1100 (EST)
Date: Sun, 6 Oct 2013 12:01:23 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v2 0/5] MPC512x DMA slave s/g support, OF DMA lookup
Message-ID: <20131006100123.GM14747@book.gsilab.sittig.org>
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
 <1373803321-11628-1-git-send-email-gsi@denx.de>
 <CAF0T0X6NE=wFYMzVEm4F9CQWXN-Bu201Z8duEH9kevOhB53jCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAF0T0X6NE=wFYMzVEm4F9CQWXN-Bu201Z8duEH9kevOhB53jCg@mail.gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, devicetree-discuss@lists.ozlabs.org,
 Dan Williams <djbw@fb.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 03, 2013 at 18:00 +0400, Alexander Popov wrote:
> 
> v2013/7/14 Gerhard Sittig <gsi@denx.de>:
> > this series
> > - introduces slave s/g support (that's support for DMA transfers which
> >   involve peripherals in contrast to mem-to-mem transfers)
> > - adds device tree based lookup support for DMA channels
> > - combines floating patches and related feedback which already covered
> >   several aspects of what the suggested LPB driver needs, to demonstrate
> >   how integration might be done
> > - carries Q&D SD card support to enable another DMA client during test,
> >   while this patch needs to get dropped upon pickup
> >
> > changes since v1:
> > - re-order mpc8308 related code paths for improved readability, no
> >   change in behaviour, introduction of symbolic channel names here
> >   already
> > - squash 'execute() start condition' and 'terminate all' into the
> >   introduction of 'slave s/g prep' and 'device control' support; refuse
> >   s/g lists with more than one item since slave support is operational
> >   yet proper s/g support is missing (can get addressed later)
> > - always start transfers from software on MPC8308 as there are no
> >   external request lines for peripheral flow control
> > - drop dt-bindings header file and symbolic channel names in OF nodes
> 
> Changes since v2 (RFC v3 was badly formed, excuse me for that):
> Part 1/5:
> - use #define instead of enum since individual channels don't require
> special handling.
> Part 2/5:
> - add a flag "will_access_peripheral" to DMA transfer descriptor
>   according recommendations of Gerhard Sittig.
>   This flag is set in mpc_dma_prep_memcpy() and mpc_dma_prep_slave_sg()
>   and is evaluated in mpc_dma_execute() to choose a type of start for
> the transfer.
> - prevent descriptors of transfers which involve peripherals from
> being chained together;
>   each of such transfers needs hardware initiated start.
> - add locking while working with struct mpc_dma_chan
>   according recommendations of Lars-Peter Clausen.
> - remove default nbytes value. Client kernel modules must set
>   src_maxburst and dst_maxburst fields of struct dma_slave_config (dmaengine.h).
> Part 6/8:
>   unchanged.
> Part 7/8:
>   unchanged.
> Part 8/8:
>   unchanged.
> 
> These changes are tested on MPC5125
> - with SCLPC driver (transfers between dev and mem work fine).
> - with dmatest module (all 64 DMA channels can perform mem-to-mem transfers
>   which can be chained in one DMA transaction).
> 
> > known issues:
> > - it's yet to get confirmed whether MPC8308 can use slave support or
> >   whether the DMA controller's driver shall actively reject it, the
> >   information that's available so far suggests that peripheral transfers
> >   to IP bus attached I/O is useful and shall not get blocked right away


I'm not certain whether keeping the "cover letter" in threaded
form is appropriate.  But speaking about non-existent parts
(6-8/8), not saying what the current version is, missing stats
certainly isn't right.

Your submission style adds more work to doing review and
providing feedback than what's necessary.  You assume that others
would keep the history for you, or would do the archeology and
collect individual pieces from the past, to recover what you fail
to send out.

The messages show up in an unexpected order here (3, 4, 5, 0
first on one thread, 1, 2 then in another thread, with some 2800
messages between them) and carry conflicting subjects or version
numbers.  Formatting was broken in transport, patches won't apply.

Please do consider checking what you send out, and how you can
improve the reception's side of the process.  Try to help those
people you want to receive help from.  Try to support both kinds
of review for people coming new to the subject as well as those
who have seen a former version.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
