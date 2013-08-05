Return-Path: <pladow@gmail.com>
Received: from mail-lb0-x22a.google.com (mail-lb0-x22a.google.com
 [IPv6:2a00:1450:4010:c04::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5E5DF2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 04:37:10 +1000 (EST)
Received: by mail-lb0-f170.google.com with SMTP id r10so2389113lbi.15
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Aug 2013 11:36:56 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
In-Reply-To: <20130805183209.06686380495@gemini.denx.de>
References: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
 <20130805183209.06686380495@gemini.denx.de>
Date: Mon, 5 Aug 2013 11:36:55 -0700
Message-ID: <CAN8Q1EfROUPBOFT1fT6Phd-KL7abu0SfCR1HdKrK_hwuL2oi2w@mail.gmail.com>
Subject: Re: Failure to detect PCI card
From: Peter LaDow <petela@gocougs.wsu.edu>
To: Wolfgang Denk <wd@denx.de>
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

On Mon, Aug 5, 2013 at 11:25 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Maybe this card needs bigger delay to respond after PCI reset. You can
> try to re-build U-Boot with defined CONFIG_PCI_BOOTDELAY. Use 1000
> for CONFIG_PCI_BOOTDELAY in the first step and if detection works,
> try to decrease this value.

I'll give this a try.  But a generic question.  Does the kernel depend
upon u-boot to initialize the PCI configuration?

And, I know this is a u-boot specific question, but will u-boot ignore
any PCI device it doesn't know about?  Thus I have to enable a
specific device in the u-boot configuration for u-boot to recognize it
(and from there, have the kernel recognize it)?

On Mon, Aug 5, 2013 at 11:32 AM, Wolfgang Denk <wd@denx.de> wrote:
> Is there any chance that this card has some BIOS (like most graphic
> adapters do) which needs to run to put the card into an operative
> state (like by initializing any DRAM memory on the card)?  OK, I would
> normally not expect such on a 10/100 PCI Ethernet network adapter, but
> I don't know this card at all...

Not that I'm aware of.  I suppose the EEPROM to read in the
configuration/MAC address?  But I wouldn't think an option ROM would
be present.

> Do you know if this card works in any other non-x86 system at all?

Don't have any other non-x86 systems to try out.  We have an
MPC8349E-mITX board, but the PCI slot doesn't detect anything at all
(not even our 82540EM based board).  And this card doesn't work there
either.

Thanks,
Pete
