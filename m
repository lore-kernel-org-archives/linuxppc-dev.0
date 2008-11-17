Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 0682FDDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 18:42:00 +1100 (EST)
In-Reply-To: <1226867161.7178.167.camel@pasglop>
References: <31226871825643c98694.1714636915.miltonm@bga.com>
	<1226867161.7178.167.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7fd0818d9990856402b85d09b562bb51@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] ppc32: remove secondary_ti
Date: Mon, 17 Nov 2008 01:46:37 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 16, 2008, at 2:26 PM, Benjamin Herrenschmidt wrote:

> On Sun, 2008-11-16 at 15:43 -0600, Milton Miller wrote:
>> Instead of copying current_set[cpu] to secondary_ti, directly index 
>> into
>> current_set by the cpu number like head_64.S.  In addition to removing
>> the variable, a slow to respond cpu will not clobber another cpus
>> stack.
>
> Except that we don't know our CPU number at this stage do we ? IE. r24
> is our HW number, is it guaranteed to be what we want to index
> current_set ?

No, you are right, current_set is ordered by logical cpu id.

We could search the hwcpuid array similar to our search of the paca on 
ppc64.  But for now go ahead and reject this patch.

milton
