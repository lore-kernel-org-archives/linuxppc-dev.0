Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A85C72C0416
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 10:00:58 +1000 (EST)
Message-ID: <1371945647.3944.106.camel@pasglop>
Subject: Re: Inbound PCI and Memory Corruption
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter LaDow <petela@gocougs.wsu.edu>
Date: Sun, 23 Jun 2013 10:00:47 +1000
In-Reply-To: <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-06-21 at 10:14 -0700, Peter LaDow wrote:
> After a (finally!) successful search of the list archive, I did find
> this:
> 
> http://web.archiveorange.com/archive/v/9IQA26gPvdf4foaTcmCV
> 
> Which seems very related to my problem.  However, the patch that is
> ultimately referenced is in place in 3.0.80 (see
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2006-February/021267.html).
> 
> Hmmm...  perhaps our FDT is bad?

Afaik e300 is slightly out of order, maybe it's missing a memory barrier
somewhere.... One thing to try is to add some to the dma_map/unmap ops.

Also audit the driver to ensure that it properly uses barriers when
populating descriptors (and maybe compare to a more recent version of
the driver upstream).

Ben.
