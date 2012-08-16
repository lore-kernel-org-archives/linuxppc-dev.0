Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id 217422C0096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 23:16:22 +1000 (EST)
Message-ID: <502CF2A0.8080109@c-s.fr>
Date: Thu, 16 Aug 2012 15:16:16 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Powerpc 8xx CPM_UART delay in receive
References: <201208141426.q7EEQSPc003956@localhost.localdomain>
 <20120814155227.018988da@pyramind.ukuu.org.uk>
In-Reply-To: <20120814155227.018988da@pyramind.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 14/08/2012 16:52, Alan Cox a écrit :
> On Tue, 14 Aug 2012 16:26:28 +0200
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>
>> Hello,
>>
>> I'm not sure who to address this Patch to either
>>
>> It fixes a delay issue with CPM UART driver on Powerpc MPC8xx.
>> The problem is that with the actual code, the driver waits 32 IDLE patterns before returning the received data to the upper level. It means for instance about 1 second at 300 bauds.
>> This fix limits to one byte the waiting period.
> Take a look how the 8250 does it - I think you want to set the value
> based upon the data rate. Your patch will break it for everyone doing
> high seed I/O.
>
> Alan
>
I'm not sure I understand what you mean. As far as I can see 8250/16550 
is working a bit different, as it is based on a fifo and triggers an 
interrupt as soon as a given number of bytes is received. I also see 
that in case this amount is not reached, there is a receive-timeout 
which goes on after no byte is received for a duration of more than 4 bytes.

The PowerPC CPM is working differently. It doesn't use a fifo but 
buffers. Buffers are handed to the microprocessor only when they are 
full or after a timeout period which is adjustable. In the driver, the 
buffers are configured with a size of 32 bytes. And the timeout is set 
to the size of the buffer. That is this timeout that I'm reducing to 1 
byte in my proposed patch. I can't see what it would break for high 
speed I/O.

Christophe
