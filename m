In-Reply-To: <6505FDD3-DC31-11D8-A541-000393DBC2E8@freescale.com>
References: <40F57D15.8030700@pi.be> <69A5B0EA-D669-11D8-A9B5-000393DBC2E8@freescale.com> <40F8138F.8090004@pi.be> <6505FDD3-DC31-11D8-A541-000393DBC2E8@freescale.com>
Mime-Version: 1.0 (Apple Message framework v618)
Message-Id: <A6FC1F7E-DCA9-11D8-9237-000A95A4DC02@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] align.c
Date: Fri, 23 Jul 2004 15:10:21 +0200
To: Kumar Gala <kumar.gala@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Can you explain to me why/when stswi/lswi would get alignment
> exceptions.  I think I'm missing something :)  The reason I ask is we
> are working on some emulation handlers but are not doing anything with
> regards to alignment for e500.

CPU dependent; one example is stswi to cache-inhibited memory, on
some CPUs; another is trying to execute any string insn while in
little-endian mode, on some other CPUs.

On the 601, which is what Stef is using, a word-aligned string insn
that crosses a 256MB boundary causes an alignement exception (as
does *any* insn that does this); and a not-word-aligned string insn
that crosses a 4kB boundary, does, too.


Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
