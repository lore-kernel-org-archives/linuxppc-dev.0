Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kn.nortel.com (zrtps0kn.nortel.com [47.140.192.55])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B207BDDDE6
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 16:43:33 +1100 (EST)
Message-ID: <4902B1D8.8070800@nortel.com>
Date: Fri, 24 Oct 2008 23:42:48 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [BUG] oops in net_rx_action on 64-bit powerpc
References: <F169D4F5E1F1974DBFAFABF47F60C10A069DFCEF@orsmsx507.amr.corp.intel.com>
	<20081023.171614.72881694.davem@davemloft.net>	<49025C94.60406@nortel.com>
	<20081024.164128.113131091.davem@davemloft.net>
In-Reply-To: <20081024.164128.113131091.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, romieu@fr.zoreil.com, jesse.brandeburg@intel.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller wrote:
> From: "Chris Friesen" <cfriesen@nortel.com>
> Date: Fri, 24 Oct 2008 17:39:00 -0600
> 
>> So...it would appear that the NAPI code is somehow buggy, and
>> 6ba33ac should probably be reverted until the problem is found and
>> fixed.
> 
> No I think the problem is simple enough that someone should study the
> ->poll() routine quickly and audit it's return values.

Assuming that amd8111e_rx_poll() is the proper routine, there is only one exit 
point, and it returns "num_rx_pkt".  This variable is initialized to zero and 
increments for each packet sent up the stack.

Chris
