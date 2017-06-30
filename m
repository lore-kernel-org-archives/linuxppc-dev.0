Return-Path: <eguan@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzZXd3gr0zDr5r
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 21:48:01 +1000 (AEST)
Date: Fri, 30 Jun 2017 19:47:56 +0800
From: Eryu Guan <eguan@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: tj@kernel.org, Balbir Singh <bsingharora@gmail.com>, liwan@redhat.com,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: kworker with empty task->cpus_allowed (was Re: [v4.12-rc1
 regression] mount ext4 fs results in kernel crash on PPC64le host)
Message-ID: <20170630114756.GD23360@eguan.usersys.redhat.com>
References: <20170628083237.GF23360@eguan.usersys.redhat.com>
 <CAKTCnzncEoCC4=p2_ySpNdB6229SbCCqjDCzfpf8XA0xvvzH1g@mail.gmail.com>
 <20170629034122.GI23360@eguan.usersys.redhat.com>
 <CAKTCnzk8VMN0hBi24vEoNPGvvX-s8uhrjMdn7drQVDUdfA_+Ow@mail.gmail.com>
 <20170629100533.GQ23360@eguan.usersys.redhat.com>
 <87efu39he0.fsf@concordia.ellerman.id.au>
 <20170629113933.GT23360@eguan.usersys.redhat.com>
 <878tkb9ewo.fsf@concordia.ellerman.id.au>
 <20170629135919.GU23360@eguan.usersys.redhat.com>
 <8760fdrdq1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8760fdrdq1.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 30, 2017 at 08:07:02PM +1000, Michael Ellerman wrote:
> Eryu Guan <eguan@redhat.com> writes:
> >
> > I have to update the patch a bit to make it compile.
> 
> Sure.
> 
> >> +	WARN_ON(cpumask_empty(worker->task->cpus_allowed));
> >> +	WARN_ON(cpumask_empty(pool->attrs->cpumask));
> >
> > Seems only the last two WARN_ON were triggered.
> 
> OK thanks.
> 
> Can you try this patch and see if it changes anything? (with the debug
> still applied).

This patch fixes the crash for me. After appliying this patch (with all
other debug patches still applied), kernel didn't print any warnings or
calltraces or debug messages.

> 
> We've been trying to reproduce the bug here but haven't had any luck so far.

I'm using this reproducer:
for i in `seq 5`; do
	mkfs -t ext4 -F /dev/sda5 && sleep 3 && mount /dev/sda5 /mnt/ext4 && umount /dev/sda5
done

Thanks,
Eryu

> 
> cheers
> 
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 4640f6d64f8b..b310ecc07e00 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -733,6 +733,8 @@ void __init setup_per_cpu_areas(void)
>  	for_each_possible_cpu(cpu) {
>                  __per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
>  		paca[cpu].data_offset = __per_cpu_offset[cpu];
> +
> +		set_cpu_numa_node(cpu, numa_cpu_lookup_table[cpu]);
>  	}
>  }
>  #endif
