Return-Path: <jblack547@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 50611DDDB6
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 03:18:30 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so161042yxb.39
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 08:18:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b77025b40901291527j74705c10y322e8bd8a0828600@mail.gmail.com>
References: <b77025b40901291441j7790f85ewd70ee81dc09ed55b@mail.gmail.com>
	<49823647.2010701@freescale.com>
	<b77025b40901291527j74705c10y322e8bd8a0828600@mail.gmail.com>
Date: Thu, 19 Feb 2009 09:18:28 -0700
Message-ID: <b77025b40902190818l57c81b25xa8c94ca10528f0ad@mail.gmail.com>
Subject: Re: mpc8270 and fs_enet
From: James Black <jblack547@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Turns out the problem was with the PSDMR register. We had a cas
latency of 3 and the memory stick required 2. Also, the MPTPR register
had a value of 0x1e00 and we changed it to 0x1f00. We use ECC memory
sticks.

Those 2 changes got rid of the error in the buffer descriptor
ready/empty bits. The interesting thing was that our SDRAM memory test
passes and there are no errors logged in the TESCR1, TESCR2 or the
SDSR registers.

Strange problem, and difficult to find. Thought I'd get this out for
future reference.

On Thu, Jan 29, 2009 at 4:27 PM, James Black <jblack547@gmail.com> wrote:
> I thought the same thing. So I verified the memory map. We did have a
> conflict with the SPI stomping the FCC temp so we moved that. An
> interesting note is that we drop packets from time to time on the MCC
> as well due to a similar ready bit problem. The CPM never clears the
> bit.
>
> ------------------------------------------------------------------
> IMMR memory map
> ------------------------------------------------------------------
>> FCC1      Parameters    0x8400        256
>> FCC1      Temp buffer   0x9000        128
>> SCC1      Parameters    0x8000        256
>> SCC2      Parameters    0x8100        256
>> SCC4      Parameters    0x8300        256
>> SMC1      Parameters    0x0000         64
>> SMC2      Parameters    0x0040         64
>> SCC1      Buff Desc     0x0080         64
>> SCC2      Buff Desc     0x00C0         64
>> SCC4      Buff Desc     0x0100         64
>> SPI       Param Pointer 0x89FC          2
>> SPI       Parameters    0x9000         76
>> MCC2      Global Param  0x8800        128
>> MCC2      HDLC Param    0x2000       8192
>> MCC2      Extra Param   0xB000       1024
>
>
>
> On Thu, Jan 29, 2009 at 4:05 PM, Scott Wood <scottwood@freescale.com> wrote:
>> James Black wrote:
>>>
>>> I've got an mpc8270 running the fs_enet v1.0 driver and we are having
>>> problems with randomly corrupted tx buffer descriptor ready bits. The
>>> CPM never clears the bit. This is a 2.6.19.2 kernel. We have the same
>>> kernel with the 8260_io driver (kernel is from the denx ELDK4.2)
>>> running on the mpc8250 that works perfect.
>>
>> Is it possible that some other CPM block is configured to use the same DPRAM
>> area that the descriptors are in?
>>
>> -Scott
>>
>
>
>
> --
> Jim Black
> Senior Software Engineer
> Aztek Networks, Inc.
> 2477 55th Street, Suite 202
> Boulder, CO 80301
> www.azteknetworks.com
>



-- 
Jim Black
Senior Software Engineer
Aztek Networks, Inc.
2477 55th Street, Suite 202
Boulder, CO 80301
www.azteknetworks.com
