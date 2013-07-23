Return-Path: <R58495@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 535DA2C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 06:33:06 +1000 (EST)
Message-ID: <51EEE873.8090002@freescale.com>
Date: Tue, 23 Jul 2013 13:32:51 -0700
From: York Sun <yorksun@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC] power/mpc85xx: Add delay after enabling I2C master
References: <1374604984.15592.34@snotra>
In-Reply-To: <1374604984.15592.34@snotra>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: albrecht.dress@arcor.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2013 11:43 AM, Scott Wood wrote:
>>
>> Yes. The max divider from sys clock to i2c clcok is 32K.
>> i2c->real_clk is the clock I2C controller pumps out, not its internal
>> operation clock.
> 
> 32K is the max for all implementations?

Yes, according to application note 2919 (published).

> 
> BTW, Where does the "2000000" come from?  Shouldn't it be 1000000 if
> you're converting to usec?  If you're trying to add some slack, say so
> rather than having a comment suggest that the output of that formula is
> 64K cycles.  Or is there an implicit assumption that i2c runs at half
> the system frequency?  Is that assumption true for all implementations
> that have this erratum?

The clock source is half the sysclk. This erratum applies to selected
85xx SoCs. I have confirmed with application team that it is safe to
apply the delay to all 85xx.

> 
>> > In any case, you should send this patch to the i2c maintainer and list.
>> >
>>
>> I don't have the name on top of my head. Is that
>> linux-i2c@vger.kernel.org?
> 
> Yes, and Wolfram Sang <wsa@the-dreams.de> is the maintainer.  This is
> listed in the MAINTAINERS file.
> 

I can resubmit this patch after the feedback is addressed.

York
