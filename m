Return-Path: <amodra@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7Z0b4QYXzDqWf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 09:50:23 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id i6so25840414pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Aug 2016 16:50:23 -0700 (PDT)
Date: Tue, 9 Aug 2016 09:20:16 +0930
From: Alan Modra <amodra@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Nicolas Pitre <nico@linaro.org>, linux-kbuild@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead
 code/data elimination
Message-ID: <20160808235016.GD20904@bubble.grove.modra.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <12986071.MeSB5hmlsH@wuerfel>
 <20160807234947.GV20904@bubble.grove.modra.org>
 <1882847.dG563Vieov@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1882847.dG563Vieov@wuerfel>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 08, 2016 at 05:14:27PM +0200, Arnd Bergmann wrote:
> I have reverted that patch now, so ARM uses ".fixup" again like every
> other architecture does, and now "*(.fixup) *(.text .text.*)" works
> correctly, while ""*(.fixup) *(.text .fixup .text.*)" also fails
> the same way that I saw before:

That is really odd.  The linker isn't supposed to treat those script
snippets differently.  First match for .fixup wins.

$ cat > fixup1.s <<\EOF
 .global _start
 .text
_start:
 .dc.a .L2
.L1:
 .section ".fixup","ax",%progbits
.L2:
 .dc.a .L1
EOF
$ cat > fixup2.s <<\EOF
 .section ".text.xyz","ax",%progbits
 .dc.a .L2
.L1:

 .section ".fixup","ax",%progbits
.L2:
 .dc.a .L1
EOF
$ cat > fixup.lnk <<\EOF
SECTIONS {
  .text : { *(.fixup) *(.text .fixup .text.*) }
}
EOF
$ as -o fixup1.o fixup1.s 
$ as -o fixup2.o fixup2.s 
$ ld -o fixup -T fixup.lnk -Map fixup.map fixup1.o fixup2.o
$ cat fixup.map

Memory Configuration

Name             Origin             Length             Attributes
*default*        0x0000000000000000 0xffffffffffffffff

Linker script and memory map


.text           0x0000000000000000       0x10
 *(.fixup)
 .fixup         0x0000000000000000        0x4 fixup1.o
 .fixup         0x0000000000000004        0x4 fixup2.o
 *(.text .fixup .text.*)
 .text          0x0000000000000008        0x4 fixup1.o
                0x0000000000000008                _start
 .text          0x000000000000000c        0x0 fixup2.o
 .text.xyz      0x000000000000000c        0x4 fixup2.o
[snip]

-- 
Alan Modra
Australia Development Lab, IBM
