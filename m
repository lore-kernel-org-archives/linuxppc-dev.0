Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F57EB6EFE
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Nov 2009 22:03:53 +1100 (EST)
Message-ID: <4B07C90B.5060708@embedded-sol.com>
Date: Sat, 21 Nov 2009 13:03:39 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Michael Chan <mchan@broadcom.com>
Subject: Re: tg3: link is permanently down after ifdown and ifup
References: <4B056158.5060104@embedded-sol.com>	<4B056D85.5010904@embedded-sol.com>
	<1258671053.14964.20.camel@nseg_linux_HP1.broadcom.com>
In-Reply-To: <1258671053.14964.20.camel@nseg_linux_HP1.broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, mcarlson@broadcom.com,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Michael Chan wrote:
> On Thu, 2009-11-19 at 08:08 -0800, Felix Radensky wrote:
>   
>> Hi,
>>
>> The problem goes away if I remove the call to
>>
>> tg3_set_power_state(tp, PCI_D3hot);
>>
>> from tg3_close().
>>     
>
> Added Matt to CC.  He is on vacation and may not be able to look into
> this right away.  Thanks.
>
>   
Thanks, Michael. After digging some more into it, I've found that the
problem is in tg3_power_down_phy() routine. Apparently 57780 PHY
is not handled properly. If tg3_power_down_phy() is not invoked from
tg3_set_power_state(), the problem is not reproducible anymore. I don't
have enough information about  NIC internals to dig further.

Felix.
