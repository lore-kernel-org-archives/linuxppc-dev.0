Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-02.edutel.nl (edu-smtp-02.edutel.nl [88.159.1.176])
	by ozlabs.org (Postfix) with ESMTP id 4E2F6B70A5
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Dec 2010 07:43:41 +1100 (EST)
Message-ID: <4CF6B151.9020503@neli.hopto.org>
Date: Wed, 01 Dec 2010 21:34:25 +0100
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [MPC52xx]Latency issue with DMA on FEC
References: <AE90C24D6B3A694183C094C60CF0A2F6D8ABDB@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8ABDB@saturn3.aculab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	Jean-Michel Hautbois <jhautbois@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-rt-users@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Laight wrote:
> The in_le32() not only contains the unwanted 'sync', but also
> a 'twi' (trap immediate - NFI exactly what this does) and 'isync'.
> The 'isync' is particularly horrid and unnecessary (aborts
> the instruction queue and refeches the opcode bytes).

I've also wondered why some time ago, and this is what I could find: 
it's a special sequence that is detected by the bus error handler 
(machine check exception happens on I/O error i.e. aborted pci 
transaction or some such), so that it can 'recover' by continuing at the 
next instruction (and setting an error variable).

Perhaps there is no other way to recover reliably from bus errors?

Micha
