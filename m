Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0E256B7D59
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Feb 2010 07:21:19 +1100 (EST)
Message-ID: <4B882D3B.5050003@windriver.com>
Date: Fri, 26 Feb 2010 15:21:15 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] 8250: add workaround for MPC8[356]xx UART break IRQ storm
References: <1267212301-26851-1-git-send-email-paul.gortmaker@windriver.com>
	<EB2B2912-24C3-46C9-B894-0A84D593570F@kernel.crashing.org>
In-Reply-To: <EB2B2912-24C3-46C9-B894-0A84D593570F@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10-02-26 02:42 PM, Kumar Gala wrote:
> 
> On Feb 26, 2010, at 1:25 PM, Paul Gortmaker wrote:
> 

[...]

>>
>> +	if ((up->bugs&  UART_BUG_PPC)&&  (status == UART_LSR_RFE_ERROR_BITS)) {
>> +		spin_unlock_irqrestore(&up->port.lock, flags);
>> +		return;
>> +	}
>> +

[...]

> 
> is there harm caused if we have SERIAL_8250_PPC_BUG set and dont need it?

In theory, no -- strip away all the window dressing and we are
left with the above change.  So, you'd have to have some UART
implementation that was setting those bits and still relying
on its interrupt event to be processed normally.  But since
there are so many different 8250 implementations out there,
I was being cautious and taking the absolute safe approach.

P.

> 
> - k
