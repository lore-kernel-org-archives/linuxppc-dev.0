Date: Tue, 06 Apr 2004 12:52:20 -0400
From: Jeff Tucker <jeff@jltnet.com>
To: u-boot-users@lists.sourceforge.net,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [U-Boot-Users] Need help booting linux on IBM 405EP eval board
Message-ID: <67947102.1081255940@[192.168.0.230]>
In-Reply-To: <20040405222200.F0C05C109A@atlas.denx.de>
References: <20040405222200.F0C05C109A@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--On Tuesday, April 06, 2004 12:21 AM +0200 Wolfgang Denk <wd@denx.de>
wrote:

> In message <13615528.1081174833@[192.168.0.230]> you wrote:
>>
>> In fact, there are messages there which probably point to the root
>> cause.  I've got a lot of messages like this, I'll just type in the
>> first couple:
>>
>> ack overflow in process c0162030, r1=c0162450
>> <2>Kernel stack overlow in process c0162030, r1=c01622b0
>> <4>Data machine check in kernel mode
>> and lots more stuff like that but I presume the first messages are
>> earliest  and are the root cause.
>
> Actually these are not the first messages; the  ring  buffer  wrapped
> around. Try resetting the board faster, and/or increasing the log_buf
> size in your kernel configuration.
>

Thanks. I did increase the ring buffer and, in fact, modified the kernel so
it would simply lock up when the ring buffer filled up so I could make sure
to see the first messages. Strangely, the messages in the buffer are
incomplete and there are gaps in between them. This makes me think that the
SDRAM isn't working right.

To test that, I've tried the simple memory test which works in U-Boot. I've
also loaded the kernel image two different places in SDRAM and used the
memory compare to see if they're the same. Both of these work. The IBM
bootloader's memory test, which is a little more exhaustive, also works so
I don't think the hardware itself is bad.

In doing more debugging, I discovered the early boot serial messages I
could enable. The kernel is running until the first call to pte_alloc, then
it dies. This is deep within the virtual memory manager and is voodoo I
don't understand. Since the kernel works with the other bootloader, though,
I think that the code is probably fine. This, too, would make me think that
U-Boot isn't setting up the SDRAM correctly. I'm going to compare its setup
to what the IBM bootloader does.

Thanks
Jeff


--
Jeff Tucker
jeff@jltnet.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
