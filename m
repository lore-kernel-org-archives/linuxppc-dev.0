Date: Tue, 13 Jul 2004 15:49:45 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040713134945.GA5104@suse.de>
References: <20040615161258.GA14528@smtp.west.cox.net> <20040615172511.GA21667@suse.de> <20040615174648.GC14528@smtp.west.cox.net> <20040703222918.GA10425@suse.de> <20040704072350.GA7060@suse.de> <20040705183219.GI2146@smtp.west.cox.net> <20040709013429.GN23135@smtp.west.cox.net> <20040712090618.GB32413@suse.de> <20040712151119.GL28002@smtp.west.cox.net> <20040712180321.GB16877@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20040712180321.GB16877@smtp.west.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Mon, Jul 12, Tom Rini wrote:

> +cflags-$(CONFIG_6xx)		+= -Wa,-maltivec

That breaks gas 2.14 with gcc 3.4 or gcc 3.5, it passes -mppc, -many to
as and leads to this error:

 /home/olaf/toolchain/inst/binutils-2.14-gcc-3.4.1/lib/gcc/powerpc-unknown-linux-gnu/3.4.1/../../../../powerpc-unknown-linux-gnu/bin/as -mppc -many -V -Qy -maltivec -o arch/ppc/kernel/.tmp_time.o time.s
GNU assembler version 2.14 (powerpc-unknown-linux-gnu) using BFD version 2.14 20030612
time.s: Assembler messages:
time.s:145: Error: Unrecognized opcode: `mftb'
time.s:341: Error: Unrecognized opcode: `mftb'
time.s:462: Error: Unrecognized opcode: `mftb'
time.s:644: Error: Unrecognized opcode: `mftb'
time.s:755: Error: Unrecognized opcode: `mftb'
time.s:964: Error: Unrecognized opcode: `mftbu'
time.s:965: Error: Unrecognized opcode: `mftb'
time.s:966: Error: Unrecognized opcode: `mftbu'

-many resets some as flags.
changing this to -Wa,-mppc,-maltivec should help, no idea if it breaks
other combinations.

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
