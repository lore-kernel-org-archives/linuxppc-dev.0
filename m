Return-Path: <pladow@gmail.com>
Received: from mail-lb0-x234.google.com (mail-lb0-x234.google.com
 [IPv6:2a00:1450:4010:c04::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 186342C007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 09:07:37 +1000 (EST)
Received: by mail-lb0-f180.google.com with SMTP id a16so2544006lbj.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Aug 2013 16:07:32 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
In-Reply-To: <52000ACA.1010606@ovro.caltech.edu>
References: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
 <20130805202559.0086e806@crub>
 <CAN8Q1EfoLTDr-x0r82Ezpqak+R=QuL1o37_OVU3Q0=8zFfDMqA@mail.gmail.com>
 <52000ACA.1010606@ovro.caltech.edu>
Date: Mon, 5 Aug 2013 16:07:32 -0700
Message-ID: <CAN8Q1EecMBWb_wKVOGnBJ=CHZ9zQQDKjwN5ZD4DkP30+QRerPA@mail.gmail.com>
Subject: Re: Failure to detect PCI card
From: Peter LaDow <petela@gocougs.wsu.edu>
To: David Hawkins <dwh@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 5, 2013 at 1:27 PM, David Hawkins <dwh@ovro.caltech.edu> wrote:
> 2. Have you probed the PCI bus using a bus analyzer or scope?

Ok.  I managed to find someone with a bus extender, and have connected
both our analyzer and card.

With a working card (the 82540EM based card), I see configuration
reads on 0x00040000, 0x00080000, and 0x00100000 succeed.  The 4 and 8
correspond to the IDSEL's for our on-board ethernet (also 82540 based)
and our FPGA, respectively (these configuration addresses match the
IDSEL on our schematic, and these accesses are present when no card is
plugged into the expansion slot).  The 0x10 corresponds with the 82540
based network card.  All the vendor/device id's make sense.

However, replacing the 82540 based card with either a 3com 3C905TXM or
the Netgear FA331, there is no response on the 0x10 IDSEL line.  Thus
it appears these cards are NOT responding to configuration reads.  I
think I have to break out the scope and probe around for the 5V/3V.  I
wouldn't think that the supplies are the issue since these are
universal cards, and as I understand it either 3V3 _or_ 5V can be
present, so these should work fine.  Yet they aren't responding to PCI
configuration cycles.

I'll have to do more digging.

Thanks,
Pete
