Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (unknown [75.148.32.185])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 93E2D2C01FC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 May 2013 01:49:39 +1000 (EST)
To: Xie Shaohui-B21989 <B21989@freescale.com>
Subject: Re: SATA hang on 8315E triggered by heavy flash write?
From: Anthony Foiani <tkil@scrye.com>
References: <1369172643.1374.15@scott-Lenovo-G560>
 <gppwj3ayu.fsf@dworkin.scrye.com>
 <ED492CCEAF882048BC2237DE806547C90B1DFA93@039-SN2MPN1-013.039d.mgd.msft.net>
 <g8v362qg8.fsf@dworkin.scrye.com>
 <ED492CCEAF882048BC2237DE806547C90B1E0FFA@039-SN2MPN1-013.039d.mgd.msft.net>
 <g4ndt3f5q.fsf@dworkin.scrye.com>
Date: Thu, 23 May 2013 09:49:34 -0600
In-Reply-To: <g4ndt3f5q.fsf@dworkin.scrye.com> (Anthony Foiani's message of
 "Thu\, 23 May 2013 09\:10\:57 -0600")
Message-ID: <gwqqp1ysx.fsf@dworkin.scrye.com>
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

Apologies, a minor clarification is needed:

Anthony Foiani <tkil@scrye.com> writes:

> Shaohui --
>
> Xie Shaohui-B21989 <B21989@freescale.com> writes:
>
>> If stop NOR write, could the SATA recover and work?
>
> Earlier in my development, I was seeing this error and it would
> recover:
>
>   ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
>   ata2: PHY RDY changed
>   ata2: hard resetting link
>   ata2: Signature Update detected @ 0 msecs
>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>   ata2.00: configured for UDMA/133
>   ata2: EH complete

In this case, it would recover *even as the NOR write continued*.

Here's an example where it froze and recovered twice.  The application
starts about 12s after the kernel, so 945s for the kernel should be
933s for the application.

Also, note that this case already has the speed limit code included
(see message at 945.928702), so I don't think I need to do a separate
test.

  [console]
  [  945.902543] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
  [  945.909584] ata2: PHY RDY changed
  [  945.913048] ata2: hard resetting link
  [  945.928702] ata2: setting speed (in hard reset)
  [  945.939864] ata2: Signature Update detected @ 0 msecs
  [  946.115888] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
  [  946.128548] ata2.00: configured for UDMA/133
  [  946.133021] ata2: EH complete
  [  952.537180] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
  [  952.544208] ata2: PHY RDY changed
  [  952.547626] ata2: hard resetting link
  [  952.558319] ata2: setting speed (in hard reset)
  [  953.076730] ata2: Signature Update detected @ 508 msecs
  [  953.251866] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
  [  953.259389] ata2.00: configured for UDMA/133
  [  953.263892] ata2: EH complete

  [application]
  +924.152278 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x100000 from buf[0x0]; attempt 1/3
  +925.599739 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x110000 from buf[0x10000]; attempt 1/3
  +927.018239 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x120000 from buf[0x20000]; attempt 1/3
  +928.414069 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x130000 from buf[0x30000]; attempt 1/3
  +929.872850 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x140000 from buf[0x40000]; attempt 1/3
  +931.341634 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x150000 from buf[0x50000]; attempt 1/3
  +932.724024 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x160000 from buf[0x60000]; attempt 1/3
  [first freeze is about here]
  +934.146203 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x170000 from buf[0x70000]; attempt 1/3
  +935.569069 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x180000 from buf[0x80000]; attempt 1/3
  +936.875275 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x190000 from buf[0x90000]; attempt 1/3
  +938.205302 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x1a0000 from buf[0xa0000]; attempt 1/3
  +939.519662 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x1b0000 from buf[0xb0000]; attempt 1/3
  +940.873656 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x1c0000 from buf[0xc0000]; attempt 1/3
  [second freeze is about here]
  +942.230740 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x1d0000 from buf[0xd0000]; attempt 1/3
  +943.641994 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x1e0000 from buf[0xe0000]; attempt 1/3
  +944.938454 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x1f0000 from buf[0xf0000]; attempt 1/3
  +946.236491 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x200000 from buf[0x100000]; attempt 1/3
  +947.607673 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x210000 from buf[0x110000]; attempt 1/3
  +948.919213 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x220000 from buf[0x120000]; attempt 1/3
  +950.151386 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x230000 from buf[0x130000]; attempt 1/3
  +951.502522 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x240000 from buf[0x140000]; attempt 1/3
  +952.851177 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x250000 from buf[0x150000]; attempt 1/3
  +954.082897 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x260000 from buf[0x160000]; attempt 1/3
  +955.315338 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x270000 from buf[0x170000]; attempt 1/3
  +956.559639 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x280000 from buf[0x180000]; attempt 1/3
  +957.845503 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x290000 from buf[0x190000]; attempt 1/3
  +959.100007 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x2a0000 from buf[0x1a0000]; attempt 1/3
  +960.347982 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x2b0000 from buf[0x1b0000]; attempt 1/3
  +961.545344 sw-upd.0 [29]: fm: nor0: write: writing 0x10000 @0x2c0000 from buf[0x1c0000]; attempt 1/3

Best regards,
Anthony Foiani
