Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3BDDD2C0335
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 03:04:03 +1000 (EST)
Received: from mail114-db9 (localhost [127.0.0.1])	by
 mail114-db9-R.bigfish.com (Postfix) with ESMTP id AEB653A0206	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 17:03:57 +0000 (UTC)
Received: from DB9EHSMHS015.bigfish.com (unknown [10.174.16.243])	by
 mail114-db9.bigfish.com (Postfix) with ESMTP id 9D02D1400C7	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 17:03:56 +0000 (UTC)
Message-ID: <1380301430.24959.399.camel@snotra.buserror.net>
Subject: Re: [PATCH V4 3/3] powerpc/85xx: Add TWR-P1025 board support
From: Scott Wood <scottwood@freescale.com>
To: Xie Xiaobo-R63061 <r63061@freescale.com>
Date: Fri, 27 Sep 2013 12:03:50 -0500
In-Reply-To: <69EC9ED88E3CC04094A78F8074A7986D5FF91C@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1380019739-8196-1-git-send-email-X.Xie@freescale.com>
 <1380019739-8196-3-git-send-email-X.Xie@freescale.com>
 <1380064944.24959.143.camel@snotra.buserror.net>
 <69EC9ED88E3CC04094A78F8074A7986D5FF91C@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Johnston Michael-R49610 <r49610@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-25 at 04:50 -0500, Xie Xiaobo-R63061 wrote:
> > > +#if defined(CONFIG_SERIAL_QE)
> > > +			/* On P1025TWR board, the UCC7 acted as UART port.
> > > +			 * However, The UCC7's CTS pin is low level in default,
> > > +			 * it will impact the transmission in full duplex
> > > +			 * communication. So disable the Flow control pin PA18.
> > > +			 * The UCC7 UART just can use RXD and TXD pins.
> > > +			 */
> > > +			par_io_config_pin(0, 18, 0, 0, 0, 0); #endif
> > 
> > Any reason not to do this unconditionally?
> 
> This is a board issue, the code already have a condition - defined
> SERIAL_QE, and I will add a condition "if (machine_is(twr_p1025))".

My point was, is there any harm in doing this without regard to
CONFIG_SERIAL_QE?

-Scott
