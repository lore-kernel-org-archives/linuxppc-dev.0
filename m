Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 8428EDDFB5
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 00:13:04 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LgfHw-0006qg-Mv
	for linuxppc-dev@ozlabs.org; Mon, 09 Mar 2009 06:13:00 -0700
Message-ID: <22412825.post@talk.nabble.com>
Date: Mon, 9 Mar 2009 06:13:00 -0700 (PDT)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Machine check in 4xx ethernet driver
In-Reply-To: <20090309111436.GA2256@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <22408005.post@talk.nabble.com>
	<20090309103820.GA17943@zod.rchland.ibm.com>
	<22410889.post@talk.nabble.com>
	<20090309111436.GA2256@yoda.jdub.homelinux.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




Josh Boyer-4 wrote:
> 
> On Mon, Mar 09, 2009 at 03:53:25AM -0700, Felix Radensky wrote:
>>
>>
>>
>>Josh Boyer-4 wrote:
>>> 
>>> On Mon, Mar 09, 2009 at 12:47:02AM -0700, Felix Radensky wrote:
>>>>
>>>>Hi,
>>>>
>>>>I'm getting machine check exception when trying to dump
>>>>emac registers on 405EX Kilauea board. The kernel is 2.6.29-rc7
>>>>The problem seems not new, I can reproduce it on 2.6.25 Denx kernel
>>> 
>>> I've not looked at what that code path does, but the EMAC regs are
>>> in DCR space, not MMIO.  Using memcpy_fromio there seems odd.
>>> 
>>> 
>>
>>At least on 405EX MAL registers are in DCR space, but EMAC and RGMII
>>ones are in MMIO space.
> 
> Ah, quite right.  No coffee yet this morning.
> 
> You'll need to look at the code path ethtool is forcing.  Perhaps it's
> doing
> something stupid.
> 
> The problem goes away if I replace memcpy_fromio() by memcpy().
> Is memcpy_fromio() really necessary in this case ?
> 
> 

-- 
View this message in context: http://www.nabble.com/Machine-check-in-4xx-ethernet-driver-tp22408005p22412825.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
