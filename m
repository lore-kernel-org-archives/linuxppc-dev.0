Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHTWn6FxlzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 13:56:53 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 75so10696904pgf.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Feb 2017 18:56:53 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 7 Feb 2017 08:26:45 +0530
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC] powerpc/pseries: Increase busy loop in pseries_cpu_die
Message-ID: <20170207025645.GB22303@localhost.localdomain>
References: <1486407496-12151-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486407496-12151-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 06, 2017 at 04:58:16PM -0200, Thiago Jung Bauermann wrote:
> [  447.714064] Querying DEAD? cpu 134 (134) shows 2
> cpu 0x86: Vector: 300 (Data Access) at [c000000007b0fd40]
>     pc: 000000001ec3072c
>     lr: 000000001ec2fee0
>     sp: 1faf6bd0
>    msr: 8000000102801000
>    dar: 212d6c1a2a20c

This looks like we accessed a bad address, but why?

>  dsisr: 42000000
>   current = 0xc000000474c6d600
>   paca    = 0xc000000007b6b600   softe: 0        irq_happened: 0x01
>     pid   = 0, comm = swapper/134
> Linux version 4.8.0-34-generic (buildd@bos01-ppc64el-026) (gcc version 5.4.0 20160609 (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) ) #36~16.04.1-Ubuntu SMP Wed Dec 21 18:53:20 UTC 2016 (Ubuntu 4.8.0-34.36~16.04.1-generic 4.8.11)
> WARNING: exception is not recoverable, can't continue
> 
> This was reproduced in v4.10-rc6 as well, but I don't have a crash log
> handy for that version right now. Sorry.
> 
> This is a race between one CPU stopping and another one calling
> pseries_cpu_die to wait for it to stop. That function does a short
> busy loop calling RTAS query-cpu-stopped-state on the stopping CPU
> to verify that it is stopped.
> 
> As can be seen in the dmesg right before or after the "Querying DEAD?"
> messages, if pseries_cpu_die waited a little longer it would have seen
> the CPU in the stopped state.
> 
> I see two cases that can be causing this race:
> 
> 1. It's possible that CPU 134 was inactive at the time it was unplugged.
>    In that case, dlpar_offline_cpu calls H_PROD on the CPU and immediately
>    calls pseries_cpu_die. Meanwhile, the prodded CPU activates and start
>    the process of stopping itself. It's possible that the busy loop is not
>    long enough to allow for the CPU to wake up and complete the stopping
>    process.
> 2. If CPU 134 was online at the time it was unplugged, it would have gone
>    through the new CPU hotplug state machine in kernel/cpu.c that was
>    introduced in v4.6 to get itself stopped. It's possible that the busy
>    loop in pseries_cpu_die was long enough for the older hotplug code but
>    not for the new hotplug state machine.
> 
> Either way, the solution is the same: wait an adequate amount in
> pseries_cpu_die.
> 
> The simple solution is to increase the number of tries in the loop.
> This was done to solve a similar problem in
> commit 940ce422a367 ("powerpc/pseries: Increase cpu die timeout"), so
> it's not as lame as it sounds. :-)
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
> 
> Notes:
>     A solution that is probably better is to have pseries_cpu_die wait
>     on a per-CPU semaphore at the beginning of the function, before doing a
>     short busy loop. Then the CPU that is stopping unlocks that semaphore right
>     before stopping itself, probably at pseries_mach_cpu_die.
>     
>     What do you think? I can implement that if there is interest.
> 
>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index a1b63e00b2f7..3d43317eec1b 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -206,7 +206,7 @@ static void pseries_cpu_die(unsigned int cpu)
>  		}
>  	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {
>  
> -		for (tries = 0; tries < 25; tries++) {
> +		for (tries = 0; tries < 5000; tries++) {

This fixes some of the asymmetry between handling of CPU_STATE_INACTIVE
and CPU_STATE_OFFLINE, but I think we can probably move the cpu_relax()
to msleep(1). 

Please also see
940ce42 powerpc/pseries: Increase cpu die timeout

Balbir Singh.
