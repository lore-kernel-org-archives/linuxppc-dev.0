Return-Path: <det.nicolas@free.fr>
Received: from smtp11.wanadoo.fr (smtp11.wanadoo.fr [193.252.22.31])
	by ozlabs.org (Postfix) with ESMTP id 5647268185
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2005 16:19:29 +1000 (EST)
Received: from smtp11.wanadoo.fr (mwinf1107 [172.22.142.37])
	by mwinf1110.wanadoo.fr (SMTP Server) with ESMTP id 894921C02B36
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2005 07:59:38 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1107.wanadoo.fr (SMTP Server) with ESMTP id 0DA4D1C000A3
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2005 07:59:35 +0200 (CEST)
From: Nicolas DET <det.nicolas@free.fr>
To: Dale Farnsworth <dale@farnsworth.org>, linuxppc-dev@ozlabs.org
Date: 31 Aug 2005 07:55:49 +0100
In-Reply-To: <20050830233205.GB24345@xyzzy.farnsworth.org>
Message-Id: <20050831055934.871E41C00097@mwinf1107.wanadoo.fr>
Subject: Re: Marvell MV6436xx ethernet driver patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Dale,

On 31/08/2005, you wrote:
> On Tue, Aug 30, 2005 at 08:16:12PM +0100, Nicolas DET wrote:
>> You can find enclosed a patch for the Marvell MV643xx ethernet driver.
>> 
>> It's also there:
>> http://arrakin.homedns.org/~nicolas/mv643xx_eth.tar.gz (tarball)
>> http://arrakin.homedns.org/~nicolas/mv643xx_eth.diff.bz2 
>> 
>> The diff is against the kernel 2.6.13 (kernel.org).

> Thank you for working on this driver, Nicolas.

It was very fun and interresting :-)
I wish I could spend more time, however I won't be able to this week ;-/.

>> The main changes (AFAIR):
>> * Workaround for the TCP/UDP hw checksum

> I implemented something similar a while back, but found it too ugly to
> keep around.  Fortunately, there is already a much simpler workaround for
> the hw checksum bug in linux-2.6.git.  See
>     http://oss.sgi.com/archives/netdev/2005-08/msg00124.html

Ok.

>> * Define and use SRAM (for pegasos II archp/ppc/chrp_pegasos_eth.c)

> Good.  This is pegasos-specific and it would be good to split this
> patch out from the mv643xx driver bits.  Descriptors in SRAM is a big
> win.   
>> * Able to use max burst size from/to DDR (serious transfer boost)

> This is a good idea.  I suspect that most of the gain is from
> turning off snooping and flushing/invalidating the cache explicitly.
> Implementation-wise, I'd rather we not manipulate the MV643XX_ETH_BAR_?
> registers directly in the driver.  Today that is done in platform
> setup code.  This has promise but needs to be reworked.

Yeah, the point was to have no snooping for this part of the chip.
The descriptors in SRAM, and the data in DDR. This give a serious boost.

I noticed MV643xx memory performances are really higher when turning
off snoop (not only for ethernet).

Well, I confess manipulating such thing here, is not totaly smart.
However I don't really know where to put them.
Maybe, somewhere in arch/ppc ?

Because, at some pooint the driver will need to have this modified in order
to reall work correctly.

For example, if you use a module with that option (it will disable
snooping) and then 'rmmod & modprobe' a new module without it will not work
(no snooping as the new module expect!).

Conclusion: yes, touching ETH_BAR isn't really well here, but where could
we move it ?

>> * Option can be selected through the menu (drivers/net/Kconfig)

> Do these really need to be user configurable?

> The following shouldn't be user options, IMHO:
> MV643XX_CHECKSUM_OFFLOAD_TX -- on
> MV643XX_CHECKSUM_OFFLOAD_TX_WORKAROUND -- on
> MV64XXX_HWSTATS -- on
> MV643XX_COAL -- on
> MV64XXX_USESRAM -- on/off depending on platform
> MV64XXX_MAXBURST -- on/off depending on platform

Ok. It can easily go back into the .h

> I'm not as sure about MV643XX_NAPI, but I think it should always be on
> for GigE drivers.  Is it worth being able to turn off NAPI?

I'm really not sure. I also though NAPI should always be turned on.
Nevertheless, I noticed the CPU usage is really highy with NAPI on than
off. Maybe, NAPI doesn't like too much interrupt coalescing.

> Some general comments:
> Several Kconfig hunks seem unrelated to MV643XX
> Several lines in the patch have trailing whitespace.
> C++ style comments (//) aren't acceptable.
> Why the addition of EXTRA_BYTES to the definition of RX_SKB_SIZE?  Did
> you see problems without it?

Thanks a lot for this comments!
I confess eassily,, I'm not use to submit patch and to the kernel code
rules.
So, you advices are welcome.

Do you want me to clean the patch ? or something ?
I'm not sure I could, I'll be away from thursday to the next friday at
least.

Regards
-- 
Nicolas DET
MorphOS & Linux developer
