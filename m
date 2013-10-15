Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CCBDE2C0185
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 00:26:02 +1100 (EST)
Date: Tue, 15 Oct 2013 15:16:06 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] powerpc/qe_lib: Share the qe_lib for the others
 architecture
Message-ID: <20131015131606.GA2700@book.gsilab.sittig.org>
References: <1381750622-1150-1-git-send-email-X.Xie@freescale.com>
 <8559CF98-88E4-4271-A873-1409359EFE5C@kernel.crashing.org>
 <3F4D4A39-3063-45F5-8B0E-3CD5F36B4035@kernel.crashing.org>
 <20131014200952.GA20517@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131014200952.GA20517@kroah.com>
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Xie Xiaobo <X.Xie@freescale.com>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 14, 2013 at 13:09 -0700, Greg Kroah-Hartman wrote:
> 
> On Mon, Oct 14, 2013 at 02:40:44PM -0500, Kumar Gala wrote:
> > 
> > Greg,
> > 
> > Wondering your thoughts on drivers/qe vs something like
> > drivers/soc/fsl/qe.  The QuiccEngine (qe) is a communication core on
> > some of the Freescale networking SoCs that provides the ability to do
> > various networking/communication functionality.  "Channels" on the QE
> > can be used for various different things from ethernet, ATM, UART, or
> > other functions.
> 
> What makes the code "QE" specific?  Are these devices that live on the
> QE "bus", or are they controlling the QE controller?

You may think of the QUICC as a "programmable bitbang machine" if
you like.  The very same component runs arbitrary and rather
different protocols depending on how you setup its parameters.

There have been serial controllers capable of different protocols
like UART or SPI or I2S, but all of them are "serial
communication".  There have been memory controllers which could
bitbang different protocols (NAND, NOR/SRAM, DRAM), but all of
them are "memory".

The QUICC is just a little more versatile, and appears to cover
cases which reside in different Linux kernel subsystems (like:
it's neither serial nor network exclusively, but can be either
and potentially more).

IIUC the question which Kumar Gala was asking is where to put
code for the component which is neither a strict subset of any
subsystem.  Please correct me if I'm wrong.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
