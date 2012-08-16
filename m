Return-Path: <alan@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by ozlabs.org (Postfix) with ESMTP id 004252C007C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2012 01:04:10 +1000 (EST)
Date: Thu, 16 Aug 2012 16:21:36 +0100
From: Alan Cox <alan@linux.intel.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] Powerpc 8xx CPM_UART delay in receive
Message-ID: <20120816162136.059b64b4@bob.linux.org.uk>
In-Reply-To: <502D054B.3010606@c-s.fr>
References: <201208141426.q7EEQSPc003956@localhost.localdomain>
 <20120814155227.018988da@pyramind.ukuu.org.uk>
 <502CF2A0.8080109@c-s.fr>
 <20120816152918.5ed2649f@pyramind.ukuu.org.uk>
 <502D054B.3010606@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> MAX_IDL: Maximum idle characters. When a character is received, the 
> receiver begins counting idle characters. If MAX_IDL idle characters
> are received before the next data character, an idle timeout occurs
> and the buffer is closed,
> generating a maskable interrupt request to the core to receive the
> data from the buffer. Thus, MAX_IDL offers a way to demarcate frames.
> To disable the feature, clear MAX_IDL. The bit length of an idle
> character is calculated as follows: 1 + data length (5–9) + 1 (if
> parity is used) 
> + number of stop bits (1–2). For 8 data bits, no parity, and 1 stop
> bit, the character length is 10 bits


So if you have slightly bursty high speed data as its quite typical
before your change you would get one interrupt per buffer of 32 bytes,
with it you'll get a lot more interrupts.

You have two available hints about the way to set this - one of them is
the baud rate (low baud rates mean the fifo isn't a big win and the
latency is high), the other is the low_latency flag if the driver
supports the low latency feature (and arguably you can still use a
request for it as a hint even if you refuse the actual feature).

So I think a reasonable approach would be set the idle timeout down for
low baud rates or if low_latency is requested.

> generated if there is at least one word in the FIFO and for a time 
> equivalent to the transmission of four characters

Which is a bit more reasonable than one, although problematic at low
speed (hence the fifo on/off).
