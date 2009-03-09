Return-Path: <jwboyer@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 2324EDDE19
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 22:15:03 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j5so900897wah.9
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Mar 2009 04:15:01 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Mon, 9 Mar 2009 07:14:37 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: Machine check in 4xx ethernet driver
Message-ID: <20090309111436.GA2256@yoda.jdub.homelinux.org>
References: <22408005.post@talk.nabble.com>
	<20090309103820.GA17943@zod.rchland.ibm.com>
	<22410889.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22410889.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 09, 2009 at 03:53:25AM -0700, Felix Radensky wrote:
>
>
>
>Josh Boyer-4 wrote:
>> 
>> On Mon, Mar 09, 2009 at 12:47:02AM -0700, Felix Radensky wrote:
>>>
>>>Hi,
>>>
>>>I'm getting machine check exception when trying to dump
>>>emac registers on 405EX Kilauea board. The kernel is 2.6.29-rc7
>>>The problem seems not new, I can reproduce it on 2.6.25 Denx kernel
>> 
>> I've not looked at what that code path does, but the EMAC regs are
>> in DCR space, not MMIO.  Using memcpy_fromio there seems odd.
>> 
>> 
>
>At least on 405EX MAL registers are in DCR space, but EMAC and RGMII
>ones are in MMIO space.

Ah, quite right.  No coffee yet this morning.

You'll need to look at the code path ethtool is forcing.  Perhaps it's doing
something stupid.

josh
