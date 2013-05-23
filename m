Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (scrye.com [75.148.32.185])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 50C3B2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 May 2013 01:11:03 +1000 (EST)
To: Xie Shaohui-B21989 <B21989@freescale.com>
Subject: Re: SATA hang on 8315E triggered by heavy flash write?
From: Anthony Foiani <tkil@scrye.com>
References: <1369172643.1374.15@scott-Lenovo-G560>
 <gppwj3ayu.fsf@dworkin.scrye.com>
 <ED492CCEAF882048BC2237DE806547C90B1DFA93@039-SN2MPN1-013.039d.mgd.msft.net>
 <g8v362qg8.fsf@dworkin.scrye.com>
 <ED492CCEAF882048BC2237DE806547C90B1E0FFA@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Thu, 23 May 2013 09:10:57 -0600
In-Reply-To: <ED492CCEAF882048BC2237DE806547C90B1E0FFA@039-SN2MPN1-013.039d.mgd.msft.net>
 (Xie Shaohui-B's message of "Thu\, 23 May 2013 06\:04\:15 +0000")
Message-ID: <g4ndt3f5q.fsf@dworkin.scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: Anthony Foiani <tkil@scrye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shaohui --

Xie Shaohui-B21989 <B21989@freescale.com> writes:

> Thanks for the confirmation. 

You're very welcome.

> So it seems the NOR write break the signal Integrity of SATA.
> I don't have schematic and board right now, could you please measure
> signals related to NOR write to see if anything abnormal? Is the board
> use FPGA or CPLD to control signal?

I'll have to pass these questions on to my hardware vendor; I'm not
equipped to do this level of hardware debugging (neither hardware nor
knowledge!).

> If stop NOR write, could the SATA recover and work?

Earlier in my development, I was seeing this error and it would
recover:

  ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
  ata2: PHY RDY changed
  ata2: hard resetting link
  ata2: Signature Update detected @ 0 msecs
  ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
  ata2.00: configured for UDMA/133
  ata2: EH complete

At the current time, however, it seems that it does not recover.

I don't know whether this is due to the speed limiting code, or if
it's because we are doing more disk accesses (when the actual product
is up and running).

I can re-do the tests with the speed limit disabled, but I won't be
able to get to that for a few hours yet.  You can read about the speed
limit issues in this thread:

  http://article.gmane.org/gmane.linux.ports.ppc.embedded/50652

And my final patch (yes, a year later):

  http://article.gmane.org/gmane.linux.ports.ppc.embedded/58969

Please don't laugh too hard when you read it.  :)

Thanks again for your help.  I'll try to get the results of testing
w/o speed limit to you within a day or two.

Best regards,
Anthony Foiani
