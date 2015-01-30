Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E2F11A0D04
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 12:38:30 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 30 Jan 2015 11:38:29 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5F9242CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 12:38:26 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0U1cIbE42729678
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 12:38:26 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0U1bqLx031307
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 12:37:52 +1100
Date: Fri, 30 Jan 2015 12:37:28 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Avoid context switch in EEH reset if
 required
Message-ID: <20150130013728.GA22102@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1421621243-21265-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1421746096.4949.40.camel@kernel.crashing.org>
 <20150120225607.GA12174@shangw> <20150120235338.GA5280@shangw>
 <20150123035029.GA19657@shangw>
 <1422093450.4949.89.camel@kernel.crashing.org>
 <54C6CF73.7000403@linux.vnet.ibm.com>
 <1422333116.4949.100.camel@au1.ibm.com>
 <54C81800.6070407@linux.vnet.ibm.com>
 <1422403122.4949.123.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422403122.4949.123.camel@au1.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 wenxiong@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Brian J King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 28, 2015 at 10:58:42AM +1100, Benjamin Herrenschmidt wrote:
>On Tue, 2015-01-27 at 16:58 -0600, Brian King wrote:
>> I'd argue we are our own worst enemy here really. The new user is EEH
>> code.
>> I don't see a huge reason that code would need to use this exact same
>> API.
>> 
>> > In fact, even with IPR and the existing call, how do you wait for
>> the link to come
>> > back for a PERST ? That can take a while...
>> 
>> Basically, I assert reset, delay for 1/2 second via a timer interrupt,
>> deassert reset,
>> delay for 2 seconds via another timer interrupt, then proceed with
>> adapter initialization.
>
>I'm surprised that even works properly... for example in the case of
>PERST we need to mask various error traps before asserting and unmask
>them when the link comes up (such as the surprise link down error), I
>don't see an opportunity in that scheme for FW to do that latter...
>

The FW perhaps does more than what's supposed to do for assert, and
less than what's supposed to do for deassert, but need confirm with
FW developers later. In this case, the link should come up in 1/2
second, which is really short. Otherwise, FW need implement deassert
function in blocking mode to wait the link to come back, which forces
the API to be called in non-atomic context. I'll check with FW developer
later on this.

I guess we have to change the API to be called in non-atomic context in
long run. For now, Wendy is waiting for the fix and port it to RHEL7.1.
I also sent another alternative patch, which was verified by Wendy.
I'm not sure if it's reasonable to include the following patch and
change driver's code to call this API under non-atomic context later
as proceeding enhancement?

https://patchwork.ozlabs.org/patch/432065/

Thanks,
Gavin
