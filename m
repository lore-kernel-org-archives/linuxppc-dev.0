Message-ID: <402F524C.3020009@jonmasters.org>
Date: Sun, 15 Feb 2004 11:04:44 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Mike Wellington <wellington@lucent.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ml300 boot loader question
References: <20040211214947.87373.qmail@web21110.mail.yahoo.com> <402CEC30.9060503@xilinx.com> <402E2841.9020700@jonmasters.org> <402EA47B.2010600@lucent.com>
In-Reply-To: <402EA47B.2010600@lucent.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Mike Wellington wrote:

| All I know is that Xilinx customer support told me that EDK 3.2 and
| EDK 6.1 are incompatible with each other.

Oh this I know.

Everything should in theory work but right now I am having to run my own
Linux port with cacheing disabled under 6.1 and am tracing some weird
alignment issues or somesuch other problem with certain accesses through
the memory controller to SDRAM. I will get it this week I hope.

Spent most of last week manually tracing the Linux startup process,
validating every TLB entry by hand[0] and patching instructions with
hexedit/gdb since hardware breakpoints still do not seem to be working
correctly through xmd in that you cannot con after stopping properly.

Sometimes I have seen potential cacheline corruption but I am not sure
where the problem is yet and whether it is hardware flakiness or
software not doing something it should be doing. However I have now
created a consistent crash scenario where a particular structure used by
the glibc rtld is being courrupted on the way up and am hopeful that I
can this week track down exactly what causes it to get fscked.

Jon.

[0] So I now understand the ppc405 TLB handling code far more than I did
even a week ago. I love doing this kind of thing sometimes.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
