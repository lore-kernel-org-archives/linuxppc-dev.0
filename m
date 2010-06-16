Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 7726D1007D2
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 07:40:03 +1000 (EST)
Date: Wed, 16 Jun 2010 14:40:15 -0700 (PDT)
Message-Id: <20100616.144015.260092207.davem@davemloft.net>
To: cbouatmailru@gmail.com
Subject: Re: [PATCH] gianfar: Fix setup of RX time stamping
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100611122023.GA1598@oksana.dev.rtsoft.ru>
References: <95DC1AA8EC908B48939B72CF375AA5E3F03D8C46@alice.at.omicron.at>
	<20100611122023.GA1598@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, richard.cochran@omicron.at,
	Manfred.Rudigier@omicron.at, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <cbouatmailru@gmail.com>
Date: Fri, 11 Jun 2010 16:20:23 +0400

> On Fri, Jun 11, 2010 at 01:49:05PM +0200, Manfred Rudigier wrote:
>> Previously the RCTRL_TS_ENABLE bit was set unconditionally. However, if
>> the RCTRL_TS_ENABLE is set without TMR_CTRL[TE], the driver does not work
>> properly on some boards (Anton had problems with the MPC8313ERDB and
>> MPC8568EMDS).
>> 
>> With this patch the bit will only be set if requested from user space
>> with the SIOCSHWTSTAMP ioctl command, meaning that time stamping is
>> disabled during normal operation. Users who are not interested in time
>> stamps will not experience problems with buggy CPU revisions or
>> performance drops any more.
>> 
>> The setting of TMR_CTRL[TE] is still up to the user. This is considered
>> safe because users wanting HW timestamps must initialize the eTSEC clock
>> first anyway, e.g. with the recently submitted PTP clock driver.
>> 
>> Signed-off-by: Manfred Rudigier <manfred.rudigier@omicron.at>
>> ---
> 
> Looks OK. I tested that it doesn't break anything, but I didn't
> test the timestamping functionality. So
> 
> Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>

Applied, thanks guys.
