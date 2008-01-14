Return-Path: <dhbaird@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 9E418DDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Jan 2008 16:12:39 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3564158wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Jan 2008 21:12:38 -0800 (PST)
Message-ID: <440abda90801132112y76f2899by4ef582c9b58fd6b6@mail.gmail.com>
Date: Sun, 13 Jan 2008 22:12:38 -0700
From: "David Baird" <dhbaird@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Problem booting Linux 2.6 on Virtex-4
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm having trouble with getting Linux to boot farther than early_init.
 Things start to go obviously wrong after early_init calls memset to
clear the .bss section.  The first symptom I noticed was that the
stack (which currently contains the link register) was getting zeroed
by memset.  This doesn't make any sense because the stack does not
intersect the .bss section;  I confirmed that the do not intersect by
using JTAG+xmd to read the registers and also by inserting print
statements.

So, I experimented further and discovered that different memory
regions seem to be aliased on to each other every 2*32*256 bytes.

e.g.:

    char * ptr = 0;
    unsigned long addr = 0xc0001234; // pick some address
    int n = 1; // pick some integer

    // Now write values to two different addresses:
    ptr[addr] = 42;
    ptr[addr + n*2*32*256] = 24;
    volatile asm ("nop");

    // Now mysteriously, ptr[addr] == 24

The reason I have written 32*256 is because that corresponds to the
number of bytes per cache line times the number of cache lines ...
because I was suspicious this might be related to caching.  However,
with experimentation, I found that the aliasing does not occur every
32*256 bytes, but rather every 32*512 bytes (hence 2*32*256).
Anyways, I looked in embed_config (and confirmed by dumping zImage.elf
with objdump) that the cache is being invalidated with "dccci".
"dccci" is being called, as expected, and therefore everything looks
good in the code.

I am completely perplexed.  The cache appears to be initialized
properly.  I don't have any trouble in real mode.  But as soon the
kernel switches into virtual mode (in head_4xx.S), then this memory
aliasing problem happens.  I wrote a completely standalone assembler
script that initializes the cache, TLBs, and virtual mode in the same
way as embed_config and head_4xx.S and so I am able to reproduce the
problem outside of the kernel.  I can attach that code if someone
thinks it will be useful - just let me know.

Does anyone have an idea about what might be going wrong?  I can send
more information or test anything that you want me to.

-David
