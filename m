Message-Id: <4.3.2.20001221073632.00bb81f0@falcon.si.com>
Date: Thu, 21 Dec 2000 07:48:19 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Software Emulation error
In-Reply-To: <3A41690B.E5BCB90D@nexus-tech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Scrogged memory, bad code.  You are trying to execute a floating point
instruction and your processor doesn't support floating point (or it is
disabled).  Memories like to go to 0xFFs and that is a floating point
instruction.  Most floating point instructions are 0xFE and the 'D'
field supplies the remaining '1' bit.  I don't see any valid
instructions for 0xFFFFFFDA (they all have a reserved field of '0's in
them), but the op-code causes a floating point trap if you don't have
floating point available/enabled.

I assume memcp/44 is line 44 in memcp.  I would check the parameters to
the memcp() call to make sure you aren't copying garbage over
yourself.  If you can look at the assembly code and registers, make
sure the destination wasn't 0x398c8d84 (next instruction pointer - 4).

How was my guess?  Did I win $1,000,000 :-)?  It would be easier if you
tell us the processor and more about your system.

gvb


At 09:20 PM 12/20/00 -0500, Kyle Harris wrote:

>Hi,
>
>I've encountered the following error several times while running various
>programs. This one comes from a process attempting to call the times()
>function.
>
>Software Emulation memcp/44 NIP: 18424a0 *NIP: 0x398c8d88 code: ffffffda
>Illegal Instruction
>
>Can anyone give me a clue as to why this happens?
>
>Thanks, Kyle.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
