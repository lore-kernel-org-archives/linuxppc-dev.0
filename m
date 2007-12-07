Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0CD34DDE29
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 09:12:31 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB7MCSLY030833
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 17:12:28 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB7MCR6R171140
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 15:12:27 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB7MCQ3F017372
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 15:12:27 -0700
Message-ID: <4759C548.6030304@linux.vnet.ibm.com>
Date: Sat, 08 Dec 2007 03:42:24 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC
References: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
	<20071207212817.GA391@lixom.net>
	<4759BCA2.1020809@linux.vnet.ibm.com>
	<975B5B2B-C1F3-4021-9AE2-8873FFE1BDEC@kernel.crashing.org>
In-Reply-To: <975B5B2B-C1F3-4021-9AE2-8873FFE1BDEC@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Dec 7, 2007, at 3:35 PM, Balbir Singh wrote:
> 
>> Olof Johansson wrote:
>>> Hi,
>>>
>>> On Sat, Dec 08, 2007 at 02:44:25AM +0530, Balbir Singh wrote:
>>>
>>>> Comments are as always welcome!
>>>
>>> Care to explain what this is useful for? (Not saying it's a stupid idea,
>>> just wondering what the reason for doing it is).
>>>
>>
>> In my case, I use it to test parts of my memory controller patches on an
>> emulated NUMA machine. I plan to use it to test out page migration
>> across nodes.
> 
> Can you explain that further.  I'm still not clear on why this is useful.
> 
> - k

Sure. In my case I need to emulate NUMA nodes to do some NUMA specific
testing. The memory controller I've written has some interesting data
structures like per node, per zone LRU lists. To be able to test those
features on a non-numa box is a problem, since we get just the default node.

To be able to test the memory controller under NUMA, I use fake NUMA
nodes. x86-64 has a similar feature, the code I have here is the
simplest I could come up with for PowerPC.

I just thought of another very interesting use case, it can be used to
split up the zone's lru lock which is highly contended.

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
