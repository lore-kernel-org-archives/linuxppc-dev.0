Message-ID: <3E8B3895.5050908@embeddededge.com>
Date: Wed, 02 Apr 2003 14:23:01 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Matt Porter <porter@cox.net>
Cc: Jean-Denis Boyer <jdboyer@mediatrix.com>,
	kas turi <inox_kas@yahoo.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Disabling data cache
References: <2702075D4DE2B043BF5EB82E9CFAD45B763543@mail1.mediatrix.com> <20030402094037.A31751@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter wrote:

> On Wed, Apr 02, 2003 at 09:28:21AM -0500, Jean-Denis Boyer wrote:
>
>>There is a kernel configuration option for that: CONFIG_DCACHE_DISABLE.
>>In the kernel configuration UI, look into the section 'MPC8260 CPM Options'.
>
>
> There is no code backing that option in linuxppc_2_4_devel, it is useless.

It was orginally done for 8xx processors.  I suspect someone (I don't
think it was me) :-) tried to consolidate 8xx and 82xx CPM configurations
and messed it up.

> Certainly one could take what one person did (in the old post I referenced)
> and put it under a config option for debug purposes.  Yet another nice
> project for somebody. :)

Data cache configuration options are a PITA for most processors.  You would
have to litter #ifdefs all over the kernel.  IMHO, you should make cache
coherent busses work correctly, then write code.  In the case of 8xx, it is
a trival bit setting in one control register that can be done at start up
time, making debug easier for this non-coherent cache processor.

This #ifdef used to be near the end of initial_mmu() in head_8xx.S.  When
I added the TLB Pinning option, I decided to simplify the code and remove
the disable data cache option.  If necessary, it is easy to do this with
a simple code change.  The copyback #ifdef is a little more useful as we
are more likely to see memory controller set up rather than data cache
coherency problems these days and this option can help debug those.

I'll remove the configuration option.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
