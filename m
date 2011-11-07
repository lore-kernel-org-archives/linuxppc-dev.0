Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 92401B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 05:42:12 +1100 (EST)
Message-ID: <4EB82657.4090204@freescale.com>
Date: Mon, 7 Nov 2011 12:41:27 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 6/7] fsl_pmc: Add API to enable device as wakeup event
 source
References: <1320410349-14600-1-git-send-email-chenhui.zhao@freescale.com>
 <CAOZdJXXB9zJWqC+kPq7ZDdzePtp8XNBnWcf5UmE8Ye50U-G7Dg@mail.gmail.com>
In-Reply-To: <CAOZdJXXB9zJWqC+kPq7ZDdzePtp8XNBnWcf5UmE8Ye50U-G7Dg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/04/2011 07:08 PM, Tabi Timur-B04825 wrote:
> On Fri, Nov 4, 2011 at 7:39 AM, Zhao Chenhui <chenhui.zhao@freescale.com> wrote:
>> +       /* clear to enable clock in low power mode */
>> +       if (enable)
>> +               clrbits32(&pmc_regs->pmcdr, *pmcdr_mask);
>> +       else
>> +               setbits32(&pmc_regs->pmcdr, *pmcdr_mask);
> 
> You need to use be32_to_cpup() when dereferencing a pointer to a
> device tree property.

Or just use of_property_read_u32().

-Scott
