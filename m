Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D7C78B6F7B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 11:05:16 +1100 (EST)
Message-ID: <4ED81632.3030809@windriver.com>
Date: Thu, 1 Dec 2011 19:05:06 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] 8250: add workaround for MPC8[356]xx UART break IRQ
 storm
References: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>
 <1322783258-20443-4-git-send-email-paul.gortmaker@windriver.com>
 <4ED812E4.60905@freescale.com>
In-Reply-To: <4ED812E4.60905@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11-12-01 06:51 PM, Scott Wood wrote:
> On 12/01/2011 05:47 PM, Paul Gortmaker wrote:
>> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
>> index 8c660af..b0f4042 100644
>> --- a/include/linux/serial_8250.h
>> +++ b/include/linux/serial_8250.h
>> @@ -18,6 +18,11 @@
>>  #define UART_BUG_TXEN	(1 << 1)	/* buggy TX IIR status */
>>  #define UART_BUG_NOMSR	(1 << 2)	/* buggy MSR status bits (Au1x00) */
>>  #define UART_BUG_THRE	(1 << 3)	/* buggy THRE reassertion */
>> +#ifdef CONFIG_PPC32
>> +#define UART_BUG_FSLBK	(1 << 4)	/* buggy FSL break IRQ storm */
>> +#else	/* help GCC optimize away IRQ handler errata code for ARCH != PPC32 */
>> +#define UART_BUG_FSLBK	0
>> +#endif
> 
> I believe this bug still exists on our 64-bit chips.

OK, I'll simply change the above to CONFIG_PPC then.

Thanks,
Paul.

> 
> -Scott
> 
