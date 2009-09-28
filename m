Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id AA843B7C0D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Sep 2009 09:24:57 +1000 (EST)
Date: Mon, 28 Sep 2009 19:24:54 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: warning: allocated section `.data_nosave'  not in segment
Message-ID: <20090928192454.4dc937c9@lappy.seanm.ca>
In-Reply-To: <903BCD86-DE53-48AB-89CF-78248D7F6115@kernel.crashing.org>
References: <20090925165411.6c584401@lappy.seanm.ca>
	<20090928013654.466c9b72@opus.seanm.ca>
	<20090928115316.7e0b7db9@lappy.seanm.ca>
	<903BCD86-DE53-48AB-89CF-78248D7F6115@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here is the ld -M output for the "bad" compile:

.data_nosave    0xc0376790      0x870 load address 0x00376790
                0xc0377000                . = ALIGN (0x1000)
 *fill*         0xc0376790      0x870 00
                0xc0377000                __nosave_begin = .
 *(.data.nosave)
                0xc0377000                . = ALIGN (0x1000)
                0xc0377000                __nosave_end = .
                0xc0377000                . = ALIGN (0x1000)
                0xc0377000                _edata = .
                0xc0377000                PROVIDE (edata, .)
                0xc0377000                . = ALIGN (0x0)
                0xc0377000                __bss_start = .
                0xc0377000                . = ALIGN (0x0)

.sbss           0xc0377000      0xad0 load address 0x00377000

Here is the ld -M output for a "good" compile (i.e. align before
the .data_nosave:

                0xc0377000                . = ALIGN (0x1000)

.data_nosave    0xc0377000        0x0 load address 0x00377000
                0xc0377000                __nosave_begin = .
 *(.data.nosave)
                0xc0377000                . = ALIGN (0x1000)
                0xc0377000                __nosave_end = .
                0xc0377000                . = ALIGN (0x1000)
                0xc0377000                _edata = .
                0xc0377000                PROVIDE (edata, .)
                0xc0377000                . = ALIGN (0x0)
                0xc0377000                __bss_start = .
                0xc0377000                . = ALIGN (0x0)

.sbss           0xc0377000      0xad0 load address 0x00377000

It looks like putting the align before the .data.nosave puts all the
labels at the same address. Putting it *after* allows the .data_nosave
to be in a different page than the labels.

I can provide more info if needed. But it looks like everything is
nicely aligned, until the data_nosave, which needs the alignment. The
section before it is one of the few with stuff in it.

Cheers,
   Sean 
