Return-Path: <pladow@gmail.com>
Received: from mail-lb0-x230.google.com (mail-lb0-x230.google.com
 [IPv6:2a00:1450:4010:c04::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E5D852C0353
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 07:00:12 +1000 (EST)
Received: by mail-lb0-f176.google.com with SMTP id z5so6954076lbh.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 14:00:06 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
In-Reply-To: <1373492413.19894.29.camel@pasglop>
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
 <1371945647.3944.106.camel@pasglop>
 <CAN8Q1EetHpVkWFmbDGCE-3J4H7oJm0zE66SAdJyvtDb7OBc-gg@mail.gmail.com>
 <1373492413.19894.29.camel@pasglop>
Date: Thu, 11 Jul 2013 14:00:06 -0700
Message-ID: <CAN8Q1EdVVw3ofg9O3o=WThsKpcfMBXe_C7JsSSx9DdRZULW17Q@mail.gmail.com>
Subject: Re: Inbound PCI and Memory Corruption
From: Peter LaDow <petela@gocougs.wsu.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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

On Wed, Jul 10, 2013 at 2:40 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Did you get any traces that show the flow that happens around a case of
> corruption ?

Well, I captured a lot of data, both logging kernel output and
capturing PCI traffic.  I've put the full console log output on
pastebin at http://pastebin.com/ZFYbneNR

The initial corruption is a starting address of 0xe94f17f8. Looking at
the dumped data:

Slab corruption: fib6_nodes start=e94f17f8, len=32
Redzone: 0x9f911029d74e35b/0xd4bed90f1c6f0806.
Last user: [<06040001>](0x6040001)
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b ff ff ff ff ff ff
Prev obj: start=e94f17c0, len=32
Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
Last user: [<  (null)>](0x0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5
Next obj: start=e94f1830, len=32
Redzone: 0xd4bed90f1c6f0aca/0xafba11029d74e35b.
Last user: [<  (null)>](0x0)
000: 0d 5b 00 00 00 00 00 00 0a ca 0d 01 00 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 bd 3e

The first corrupted byte is at address 0xe94f1802.  Looking at the
dump of all the DMA mappings this range is never mapped.  Nor is there
a single PCI write to this mapped address either.  However, I did find
some correlation to a PCI write to a near address.  From the PCI
capture:

Command | Address  |  Data     | /BE
Mem Wr  | 294F1810 |           |
        |          | FFFF0000  | 0011
        |          | FFFFFFFF  | 0000
        |          | 0FD9BED4  | 0000
        |          | 06086F1C  | 0000
        |          | 00080100  | 0000
        |          | 01000406  | 0000
        |          | 0FD9BED4  | 0000
        |          | CA0A6F1C  | 0000
        |          | 00005B0D  | 0000
        |          | 00000000  | 0000
        |          | 010DCA0A  | 0000
        |          | 00000000  | 0000
        |          | 00000000  | 0000
        |          | 00000000  | 0000
        |          | 00000000  | 0000
        |          | 3EBD0000  | 1100

The data in this write looks very much like the pattern in the
detected slab corruption.  Looking at the PCI trace, it doesn't appear
to be the incoming PCI data (unless the PCI Inbound Address
Translation registers are misconfigured).  Yet clearly these are
corrupted with ethernet traffic.

Thanks,
Pete
