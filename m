Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9A4C9DF4F3
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 02:49:58 +1000 (EST)
Date: Tue, 15 Jul 2008 20:49:56 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [POWERPC] 86xx: suspend support
Message-ID: <20080715164956.GA11917@polina.dev.rtsoft.ru>
References: <20080606192443.GA20132@polina.dev.rtsoft.ru>
	<899616AF-593D-4B7A-A64E-3F15934CE6CF@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <899616AF-593D-4B7A-A64E-3F15934CE6CF@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>, Jason Jin <Jason.jin@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 15, 2008 at 11:16:14AM -0500, Kumar Gala wrote:
>
> On Jun 6, 2008, at 2:24 PM, Anton Vorontsov wrote:
>
>> This patch adds suspend (standby, not suspend-to-ram) support for  
>> MPC86xx
>> processors.
>>
>> In standby mode MPC86xx is able to wakeup only upon external  
>> interrupts
>> (including sreset).
>>
>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>> arch/powerpc/Kconfig                          |    2 +-
>> arch/powerpc/platforms/86xx/Makefile          |    1 +
>> arch/powerpc/platforms/86xx/mpc86xx_suspend.c |   92 ++++++++++++++++ 
>> +++++++++
>> 3 files changed, 94 insertions(+), 1 deletions(-)
>> create mode 100644 arch/powerpc/platforms/86xx/mpc86xx_suspend.c
>
> I'd like to understand how much PM support these patches really add w/ 
> regards to the work Scott's done for 83xx PM.

This support provides "sleep" mode, i.e. almost all internal core
functions are off, some peripherals could be turned off, but sysclk
must be preserved. Upon wakeup CPU continues execution where it was
put to sleep. This is also called standby mode.

This patch does not implement "deep sleep" (suspend-to-ram) mode yet.
Deep sleep can save more power: CPU can be turned off completely (except
SDRAM -- it must still receive refresh cycles).

But deep sleep is also more tricky to implement.. During deep sleep CPU
losing all track of execution and state, thus upon wakeup CPU starts
execution of the firmware, so the firmware should be also aware of deep
sleep capability.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
