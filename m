Message-ID: <3C0B8C8F.FE0A85F1@lvl7.com>
Date: Mon, 03 Dec 2001 09:30:39 -0500
From: "John W. Linville" <linville@lvl7.com>
MIME-Version: 1.0
To: "Gessner, Matt" <mattg@aiinet.com>
Cc: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Question about zvmlinux.embedded org.
References: <638AA0336D7ED411928700D0B7B0D75BB323AC@mail2.aiinet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt,

I've seen this problem myself.  The easiest "solution" is to find a way
to force your boot code to load the zImage to a different (i.e. higher)
address, say 0x00200000.  When the mini boot loader relocates itself, it
leaves the contents of the image section in place, so then the .bss and
the image sections don't overlap.

At one time I experimented with some makefile changes that 1) determined
the size of the .bss segment; 2) generated an "all zeroes" file of the
same size; and 3) added that file as a "pad" segment to the zImage file
BEFORE the image section was added.  Then, you could load the zImage
directly to it's execution address (i.e. 0x00180000).  As I recall, that
worked fairly well.  But, that was at a different employer so I don't
have any patches to offer you today...sorry. :-)

Good luck!

John

"Gessner, Matt" wrote:

> Anyway, If you'll notice where .bss is being loaded, at 0x187000
> and the location where image will be loaded (0x180000 - 0x10000 + 0x170000)
> you'll notice that .bss overlaps image.

--
John W. Linville
LVL7 Systems, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
