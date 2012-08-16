Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id 692A72C007B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2012 00:36:02 +1000 (EST)
Message-ID: <502D054B.3010606@c-s.fr>
Date: Thu, 16 Aug 2012 16:35:55 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Powerpc 8xx CPM_UART delay in receive
References: <201208141426.q7EEQSPc003956@localhost.localdomain>
 <20120814155227.018988da@pyramind.ukuu.org.uk> <502CF2A0.8080109@c-s.fr>
 <20120816152918.5ed2649f@pyramind.ukuu.org.uk>
In-Reply-To: <20120816152918.5ed2649f@pyramind.ukuu.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
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

Le 16/08/2012 16:29, Alan Cox a écrit :
>> The PowerPC CPM is working differently. It doesn't use a fifo but
>> buffers. Buffers are handed to the microprocessor only when they are
>> full or after a timeout period which is adjustable. In the driver, the
> Which is different how - remembering we empty the FIFO on an IRQ
>
>> buffers are configured with a size of 32 bytes. And the timeout is set
>> to the size of the buffer. That is this timeout that I'm reducing to 1
>> byte in my proposed patch. I can't see what it would break for high
>> speed I/O.
> How can a timeout be measured in "bytes". Can we have a bit more clarity
> on how the hardware works and take it from there ?
>
> Alan
>
The reference manual of MPC885 says the following about the MAX_IDL 
parameter:

MAX_IDL: Maximum idle characters. When a character is received, the 
receiver begins counting idle characters. If MAX_IDL idle characters are 
received before the next data character, an idle timeout occurs and the 
buffer is closed,
generating a maskable interrupt request to the core to receive the data 
from the buffer. Thus, MAX_IDL offers a way to demarcate frames. To 
disable the feature, clear MAX_IDL. The bit length of an idle character 
is calculated as follows: 1 + data length (5–9) + 1 (if parity is used) 
+ number of stop bits (1–2). For 8 data bits, no parity, and 1 stop bit, 
the character length is 10 bits

If the UART is receiving data and gets an idle character (all ones), the 
channel begins counting consecutive idle characters received. If MAX_IDL 
is reached, the buffer is closed and an RX interrupt is generated if not 
masked. If no buffer is open, this event does not generate an interrupt 
or any status information. The internal idle counter (IDLC) is reset 
every time a character is received. To disable the idle sequence 
function, clear MAX_IDL


The datasheet of the 16550 UART says:

Besides, for FIFO mode operation a time out mechanism is implemented. 
Independently of the trigger level of the FIFO, an interrupt will be 
generated if there is at least one word in the FIFO and for a time 
equivalent to the transmission of four characters
- no new character has been received and
- the microprocessor has not read the RHR
To compute the time out, the current total number of bits (start, data, 
parity and stop(s)) is used, together with the current baud rate (i.e., 
it depends on the contents of the LCR, DLL, DLM and PSD registers).


Christophe
