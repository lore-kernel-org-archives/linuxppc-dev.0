Return-Path: <cbouatmailru@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id BE2A11007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 22:20:29 +1000 (EST)
Received: by wyj26 with SMTP id 26so703921wyj.15
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 05:20:27 -0700 (PDT)
Date: Fri, 11 Jun 2010 16:20:23 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Manfred Rudigier <Manfred.Rudigier@omicron.at>
Subject: Re: [PATCH] gianfar: Fix setup of RX time stamping
Message-ID: <20100611122023.GA1598@oksana.dev.rtsoft.ru>
References: <95DC1AA8EC908B48939B72CF375AA5E3F03D8C46@alice.at.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <95DC1AA8EC908B48939B72CF375AA5E3F03D8C46@alice.at.omicron.at>
Cc: "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
	Richard Cochran <richard.cochran@omicron.at>,
	'David Miller' <davem@davemloft.net>,
	"'linuxppc-dev@ozlabs.org'" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 11, 2010 at 01:49:05PM +0200, Manfred Rudigier wrote:
> Previously the RCTRL_TS_ENABLE bit was set unconditionally. However, if
> the RCTRL_TS_ENABLE is set without TMR_CTRL[TE], the driver does not work
> properly on some boards (Anton had problems with the MPC8313ERDB and
> MPC8568EMDS).
> 
> With this patch the bit will only be set if requested from user space
> with the SIOCSHWTSTAMP ioctl command, meaning that time stamping is
> disabled during normal operation. Users who are not interested in time
> stamps will not experience problems with buggy CPU revisions or
> performance drops any more.
> 
> The setting of TMR_CTRL[TE] is still up to the user. This is considered
> safe because users wanting HW timestamps must initialize the eTSEC clock
> first anyway, e.g. with the recently submitted PTP clock driver.
> 
> Signed-off-by: Manfred Rudigier <manfred.rudigier@omicron.at>
> ---

Looks OK. I tested that it doesn't break anything, but I didn't
test the timestamping functionality. So

Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
