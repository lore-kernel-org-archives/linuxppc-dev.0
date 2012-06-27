Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 89A94B6FC3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 00:05:02 +1000 (EST)
Message-ID: <4FEB1307.7060209@windriver.com>
Date: Wed, 27 Jun 2012 10:04:55 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] serial/8250: delete WR SBC850 UART quirk handling
References: <1340740469-31445-1-git-send-email-paul.gortmaker@windriver.com>
 <1340740469-31445-4-git-send-email-paul.gortmaker@windriver.com>
 <20120627125242.08a3114e@pyramind.ukuu.org.uk>
In-Reply-To: <20120627125242.08a3114e@pyramind.ukuu.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
 Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12-06-27 07:52 AM, Alan Cox wrote:
> On Tue, 26 Jun 2012 15:54:29 -0400
> Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> 
>> We've are dropping the support for the EOL SBC8560, so we can
>> also delete this variant of the Alpha quirk support.
>>
>> Cc: Alan Cox <alan@linux.intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-serial@vger.kernel.org
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>>  drivers/tty/serial/8250/8250.h |    7 -------
>>  1 files changed, 0 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
>> index f9719d1..ffd1e6e 100644
>> --- a/drivers/tty/serial/8250/8250.h
>> +++ b/drivers/tty/serial/8250/8250.h
>> @@ -119,13 +119,6 @@ static inline void serial_dl_write(struct uart_8250_port *up, int value)
>>   * is cleared, the machine locks up with endless interrupts.
>>   */
>>  #define ALPHA_KLUDGE_MCR  (UART_MCR_OUT2 | UART_MCR_OUT1)
>> -#elif defined(CONFIG_SBC8560)
>> -/*
>> - * WindRiver did something similarly broken on their SBC8560 board. The
>> - * UART tristates its IRQ output while OUT2 is clear, but they pulled
>> - * the interrupt line _up_ instead of down, so if we register the IRQ
>> - * while the UART is in that state, we die in an IRQ storm. */
>> -#define ALPHA_KLUDGE_MCR (UART_MCR_OUT2)
>>  #else
>>  #define ALPHA_KLUDGE_MCR 0
>>  #endif
> 
> Would you mind removing all of the crap from this if its going (eg
> 8250.c) not just the header so it gets missed ? Kill the symbol entirely ?

I will, once Alpha is removed from the tree.  At the moment,
it still uses it.

Paul.
--

> 
> Alan
