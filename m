Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9430AB7D0B
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Apr 2010 05:20:43 +1000 (EST)
Subject: Re: [PATCH v2] powerpc: Add hibernation support for FSL BookE
	processors
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100415184513.GA27101@oksana.dev.rtsoft.ru>
Date: Thu, 15 Apr 2010 14:20:23 -0500
Message-Id: <2954FCF7-F34C-4E9D-A2EB-AC117D287EB5@kernel.crashing.org>
References: <20100224213802.GA12843@oksana.dev.rtsoft.ru>
	<20100415184513.GA27101@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 15, 2010, at 1:45 PM, Anton Vorontsov wrote:

> On Thu, Feb 25, 2010 at 12:38:02AM +0300, Anton Vorontsov wrote:
>> This is started as swsusp_32.S modifications, but the amount of #ifdefs
>> made the whole file horribly unreadable, so let's put the support into
>> its own separate file.
>> 
>> The code should be relatively easy to modify to support 44x BookEs as
>> well, but since I don't have any 44x to test, let's confine the code to
>> FSL BookE. (The only FSL-specific parts are 'flush_dcache_L1' and TLB
>> invalidation code).
>> 
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>> 
>> Sorry for the delayed response...
>> 
>> On Tue, Jan 12, 2010 at 01:34:08PM +1100, Benjamin Herrenschmidt wrote:
>> [...]
>>> Here's a quick review. Looks good but two things:
>>> 
>>> - Please make it swsusp_booke.c, 44x support is trivial and I don't
>>> want to rename the file :-)
>> 
>> Done.
>> 
>>> - Is there really an SDR1 register on FSL BookE ? It's supposed to be
>>> the pointer to the hash table on server ...
>> 
>> Thanks, fixed.
>> 
>>> - You probably should save/restore the TCR and ack pending crap DEC or
>>> FIT interrupts in the TSR right before you kick the decrementer
>> 
>> Done.
>> 
>>> - Nowadays, we still assume that the "loader" kernel is exactly the
>>> same as the "loaded" kernel on resume ?
>> 
>> I'm pretty sure today we do rely on this, yes. This is not some
>> generic code limitation though, it's just hard to test the case
>> when loader != loaded. In most cases it will work fine since the
>> loader kernel wouldn't differ a lot from the loaded kernel, so
>> it'll setup the low level stuff the same way.
>> 
>> We may try to link the loader kernel to a different address
>> (relocate it as in kdump case), and hope that it'll trigger
>> all sort of problems so that we could fix them.
>> 
>> Though, the better test case would be to resume the hibernated
>> kernel directly from the bootloader.
> 
> Kumar,
> 
> According to patchwork, this is now delegated to you. Do you
> have any objections to merge this?

Would like Scott's Ack.

- k
