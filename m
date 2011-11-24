Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5583B1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 02:27:07 +1100 (EST)
Message-ID: <4ECE6243.3020604@windriver.com>
Date: Thu, 24 Nov 2011 10:26:59 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] 8250: add workaround for MPC8[356]xx UART break IRQ storm
References: <1267212301-26851-1-git-send-email-paul.gortmaker@windriver.com>
 <82B7F47D-C7BF-4BD1-9982-7E7AEDC23530@kernel.crashing.org>
In-Reply-To: <82B7F47D-C7BF-4BD1-9982-7E7AEDC23530@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11-11-24 03:14 AM, Kumar Gala wrote:
> 
> On Feb 26, 2010, at 1:25 PM, Paul Gortmaker wrote:
> 
>> Sending a break on the SOC UARTs found in some MPC83xx/85xx/86xx
>> chips seems to cause a short lived IRQ storm (/proc/interrupts
>> typically shows somewhere between 300 and 1500 events).  Unfortunately
>> this renders SysRQ over the serial console completely inoperable.
>> Testing with obvious things like ACKing the event doesn't seem to
>> change anything vs. a completely dumb approach of just ignoring
>> it and waiting for it to stop, so that is what is implemented here.
>>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>>
>> This is a refresh of a patch I'd done earlier -- I've tried to make
>> the bug support as generic as possible to minimize having board
>> specific ifdef crap in 8250.c -- any suggestions on how to further
>> improve it are welcome.
>>
>> drivers/serial/8250.c      |    6 ++++++
>> drivers/serial/8250.h      |   20 ++++++++++++++++++++
>> drivers/serial/Kconfig     |   14 ++++++++++++++
>> include/linux/serial_reg.h |    2 ++
>> 4 files changed, 42 insertions(+), 0 deletions(-)
> 
> Did we ever decide what to do with this or trying to get it accepted upstream?

That is an old version.  ScottW gave me the errata information
which allowed me to fix the problem in a cleaner way.

http://patchwork.ozlabs.org/patch/46609/

I think the above version is OK as-is; the only thing I
think we could do to improve it is to go and automatically
select the thing based on known impacted CPU types (which
could be a separate commit or commits, as various CPUs are
confirmed to have the issue.)

Paul.

> 
> - k
