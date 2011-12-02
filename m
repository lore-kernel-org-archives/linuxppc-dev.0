Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 50E451007D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 11:18:03 +1100 (EST)
Subject: Re: [PATCH 3/3] 8250: add workaround for MPC8[356]xx UART break IRQ
 storm
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4ED81632.3030809@windriver.com>
Date: Thu, 1 Dec 2011 18:17:56 -0600
Message-Id: <176AE2A1-6AA2-4F14-942F-8ED77AB1DBEC@kernel.crashing.org>
References: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>
 <1322783258-20443-4-git-send-email-paul.gortmaker@windriver.com>
 <4ED812E4.60905@freescale.com> <4ED81632.3030809@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 1, 2011, at 6:05 PM, Paul Gortmaker wrote:

> On 11-12-01 06:51 PM, Scott Wood wrote:
>> On 12/01/2011 05:47 PM, Paul Gortmaker wrote:
>>> diff --git a/include/linux/serial_8250.h =
b/include/linux/serial_8250.h
>>> index 8c660af..b0f4042 100644
>>> --- a/include/linux/serial_8250.h
>>> +++ b/include/linux/serial_8250.h
>>> @@ -18,6 +18,11 @@
>>> #define UART_BUG_TXEN	(1 << 1)	/* buggy TX IIR status =
*/
>>> #define UART_BUG_NOMSR	(1 << 2)	/* buggy MSR status bits =
(Au1x00) */
>>> #define UART_BUG_THRE	(1 << 3)	/* buggy THRE =
reassertion */
>>> +#ifdef CONFIG_PPC32
>>> +#define UART_BUG_FSLBK	(1 << 4)	/* buggy FSL break IRQ =
storm */
>>> +#else	/* help GCC optimize away IRQ handler errata code for =
ARCH !=3D PPC32 */
>>> +#define UART_BUG_FSLBK	0
>>> +#endif
>>=20
>> I believe this bug still exists on our 64-bit chips.
>=20
> OK, I'll simply change the above to CONFIG_PPC then.

It does, the bug is in the uart IP which I don't think we ever plan on =
fixing, so 32 or 64-bit parts will have it for ever and ever ;)

- k=
