Message-ID: <3F71DEBA.6000702@embeddededge.com>
Date: Wed, 24 Sep 2003 14:13:14 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: nebuphilips@eudoramail.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 64-bit Data Flash Access Problem [MPC8245]
References: <PBEHCIIEFPBFGFAA@whowhere.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Augustine Nebu Philips wrote:

> I am not very clear as to:
>
> (a) How do we perform writes to send out data out on
>     all 64-bits of the bus..?
> (b) How would we ideally access 64-bit data through 32-    bit reads..?
> (c) Or must we *have* 64- bit read/write
>     instructions..?

This has been discussed before and you can probably find more details
in the mailing list archives.  There are two approaches.  One is to use
floating point registers, another is to use cache line operations.  Floating
point isn't enabled in the kernel, so you will have to make some modifications
to context switching if you choose that mode (not my recommendation).  You
can use the cache line instructions to zero/load/store cache lines that
represent I/O to the flash parts.  The best solution is to not use 64-bit
wide flash arrays....

If you write a user space application and mmap() the flash, which is a
common method, either solution is available to you.


good luck.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
