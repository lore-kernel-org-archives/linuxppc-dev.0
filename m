Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 45174DDF70
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 02:27:11 +1000 (EST)
Date: Fri, 3 Oct 2008 20:27:09 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/83xx: don't probe broken PCI on mpc837x_mds
	boards
Message-ID: <20081003162709.GB31740@oksana.dev.rtsoft.ru>
References: <20081002151852.GA8823@oksana.dev.rtsoft.ru>
	<504AAC96-2F7E-4A06-B544-1F2169BB2176@kernel.crashing.org>
	<20081003160814.GA26115@oksana.dev.rtsoft.ru>
	<01391274-EE23-4DE0-BEA9-BC2BCBD16789@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <01391274-EE23-4DE0-BEA9-BC2BCBD16789@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 03, 2008 at 11:14:18AM -0500, Kumar Gala wrote:
>
> On Oct 3, 2008, at 11:08 AM, Anton Vorontsov wrote:
>
>> In the standalone setup the board's CPLD disables the PCI internal
>> arbiter, thus any access to the PCI bus will hang the board.
>>
>> When there is no PCI arbiter on the bus the u-boot adds
>> status = "broken (no arbiter)" property into the PCI controller's
>> node, and so marks the PCI controller as unavailable.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>>
>> On Thu, Oct 02, 2008 at 02:48:44PM -0500, Kumar Gala wrote:
>>> Can you add to the commit message something about using the 'status
>>> field in the device tree to determine if the pci controller is
>>> available'
>>
>> Something like this?
>>
>> Thanks,
>
> yes, but should we just have "status = disabled" since that is the  
> effect?

I don't know, should we? For the unavailable/disabled case the status
can be anything but not 'ok' or 'okay' (the only status values for the
available devices). So if we can encode the reason, why not do this?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
