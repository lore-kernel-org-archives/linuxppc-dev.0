Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 486CCDDEE7
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 08:28:12 +1100 (EST)
In-Reply-To: <FC71C8AD27EC834C88291394CDB18EB001B65E7C@az33exm21.fsl.freescale.net>
References: <FC71C8AD27EC834C88291394CDB18EB001B65E7C@az33exm21.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <00CBBEC0-9CB5-48C6-9F58-8749E378D807@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][POWERPC] [004/006] Removed config options that we
	don'tsupport in embedded6xx
Date: Fri, 16 Mar 2007 15:03:00 -0500
To: "Stewart Katherine-ra4863" <K.Stewart@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 16, 2007, at 2:45 PM, Stewart Katherine-ra4863 wrote:

> Hmm, a little bit more homework is needed, I believe.
>
> A couple of the boards listed in your delete are still
> active & available systems.  The two that caught my eye are:
> PQ2FADS_VR : MPC82xx Family Application Development System
> PQ2FADS ZU : MPC82xx Family Application Development System
>
> Have all the formal maintainers of the boards listed for
> removal from the config been consulted?

This is just arch/powerpc not arch/ppc.  Those boards are still  
supported over there.  The only PQ2 board supported in arch/powerpc  
is 8272 ADS.  I did my homework and checked with Vitaly on that.  :)

> A reasonable list of the one's Freescale still has active can be found
> at:
> http://www.freescale.com/webapp/sps/site/taxonomy.jsp? 
> nodeId=0162468rH3b
> TdGJk19Pcqx
> but I need to double check a couple of other spots, too.
>
> Couple of minor comments in text.
>
> Kate
>
>> -----Original Message-----
>> From: linuxppc-dev-bounces+k.stewart=freescale.com@ozlabs.org
>> [mailto:linuxppc-dev-bounces+k.stewart=freescale.com@ozlabs.org]On
>> Behalf Of Kumar Gala
>> Sent: Friday, March 16, 2007 10:24 AM
>> To: linuxppc-dev@ozlabs.org
>> Subject: [PATCH][POWERPC] [004/006] Removed config options that we
>> don'tsupport in embedded6xx
>>
>>
>> When we started arch/powerpc we duplicated a number of config
>> options from arch/ppc
>> for various platforms that are supported.  Now that we
>> actually support a few
>> platforms, remove all the ones that haven't been moved over.
>> Additionally, this
>> cleanup moved the 82xx/PQ2 options over into
>> arch/powerpc/platforms/82xx/Kconfig
>> where they belong.  It also killed GEN550 which doesn't exist
>> in arch/powerpc.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>>  arch/powerpc/Kconfig.debug                 |    3 +-
>>  arch/powerpc/platforms/82xx/Kconfig        |   35 ++++
>>  arch/powerpc/platforms/embedded6xx/Kconfig |  264
>> +---------------------------
>>  3 files changed, 38 insertions(+), 264 deletions(-)
>>
> <snip>
>
>> +
>> +config 8260
>> +	bool "CPM2 Support" if WILLOW
>> +	depends on 6xx
>> +	default y if PQ2FADS
>> +	help
>> +	  The MPC8260 is a typical embedded CPU made by
>> Motorola.  Selecting
>
> while you're updating this, it should be corrected. Motorola
> doesn't make these parts, Freescale does.
>
>> +	  this option means that you wish to build a kernel for
>> a machine with
>> +	  an 8260 class CPU.
>> +
>> +config 8272
>> +	bool
>> +	depends on 6xx
>> +	default y if ADS8272
>> +	select 8260
>> +	help
>> +	  The MPC8272 CPM has a different internal dpram setup
>> than other CPM2
>> +	  devices
>> +
>> +config CPM2
>> +	bool
>> +	depends on 8260 || MPC8560 || MPC8555
>> +	default y
>> +	help
>> +	  The CPM2 (Communications Processor Module) is a coprocessor on
>> +	  embedded CPUs made by Motorola.  Selecting this
>
> ditto change Motorola to Freescale
>
>> option means that
>> +	  you wish to build a kernel for a machine with a CPM2
>> coprocessor
>> +	  on it (826x, 827x, 8560).
>>  endmenu

Agreed, we can do a general Motorola -> Freescale cleanup after this  
settles down.

- k
