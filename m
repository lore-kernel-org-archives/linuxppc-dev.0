Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04f.nortel.com (zcars04f.nortel.com [47.129.242.57])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 930C5DDDFD
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 10:39:08 +1100 (EST)
Message-ID: <49025C94.60406@nortel.com>
Date: Fri, 24 Oct 2008 17:39:00 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [BUG] oops in net_rx_action on 64-bit powerpc
References: <4900D794.5020807@nortel.com>
	<F169D4F5E1F1974DBFAFABF47F60C10A069DFCEF@orsmsx507.amr.corp.intel.com>
	<20081023.171614.72881694.davem@davemloft.net>
In-Reply-To: <20081023.171614.72881694.davem@davemloft.net>
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
> From: "Brandeburg, Jesse" <jesse.brandeburg@intel.com> Date: Thu, 23 Oct
> 2008 14:50:06 -0700
> 
>> Chris Friesen wrote:
>>> I tried booting a post 2.6.27 -git on a Motorola ATCA6101 (very similar
>>> to a Maple board).  The first time I booted I got the first log below
>>> via the serial console.  I rebooted and got as far as a login prompt.
>>> I was able to log in via the serial console, but then got an almost
>>> identical oops again, as shown in the second log below.
>>> 
>>> I configed out the gigE drivers for the backplane so the only remaining
>>> network link was the e100 link used for booting, but the problem
>>> remained.
>>> 
>>> Anyone have any idea what might be causing this?
>>> 
>>> Thanks,
>>> 
>>> Chris
>>> 
>>> 
>>> Starting xinetd: [  OK  ] Starting cron: [  OK  ] Unable to handle
>>> kernel paging request for data at address 0x00100108
>> that 00100108 pattern looks familiar, I'm not much help here, but I think
>> that had something to do with the list management of the poll_list in a
>> netdev struct.
>> 
>> so now you just have to figure out why someone's netdev struct is
>> becoming NULL. :-)
> 
> Usually this is an indication of returning the wrong value from the
> driver's ->poll() routine.

Looks like I was wrong before...the remaining ethernet link is an AMD-8111, 
not an e100.  Sorry about that.

I backed out 6ba33ac "amd8111e: delete non NAPI code from the driver".  With 
NAPI disabled, the blade appears stable.  With NAPI enabled, the original 
problem recurred.

So...it would appear that the NAPI code is somehow buggy, and 6ba33ac should 
probably be reverted until the problem is found and fixed.

Chris
