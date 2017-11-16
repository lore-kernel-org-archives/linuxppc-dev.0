Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd4YQ72lWzDr17
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 02:15:06 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id r62so7235418pfd.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 07:15:06 -0800 (PST)
Date: Fri, 17 Nov 2017 01:14:46 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Shriya <shriyak@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, paulus@samba.org, ego@linux.vnet.ibm.com,
 mikey@neuling.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] cpufreq: powernv: Return the actual CPU frequency in
 /proc/cpuinfo
Message-ID: <20171117011446.13144fd6@roar.ozlabs.ibm.com>
In-Reply-To: <1507274648-14221-1-git-send-email-shriyak@linux.vnet.ibm.com>
References: <1507274648-14221-1-git-send-email-shriyak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri,  6 Oct 2017 12:54:08 +0530
Shriya <shriyak@linux.vnet.ibm.com> wrote:

> Make /proc/cpuinfo read the frequency of the CPU it is running at
> instead of reading the cached value of the last requested frequency.
> In conditions like WOF/throttle CPU can be running at a different
> frequency than the requested frequency.
> 
> Signed-off-by: Shriya <shriyak@linux.vnet.ibm.com>

This causes the following:

[    7.203270] BUG: sleeping function called from invalid context at /home/npiggin/linux/kernel/locking/rwsem.c:23
[    7.203323] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: systemd
[    7.203352] 1 lock held by systemd/1:
[    7.203367]  #0:  (&p->lock){+.+.}, at: [<c0000000003e12f8>] seq_read+0x78/0x5c0
[    7.203416] CPU: 164 PID: 1 Comm: systemd Not tainted 4.14.0-00345-g8fb6e339cdf5 #33
[    7.203452] Call Trace:
[    7.203463] [c000000ff55039d0] [c000000000be4f24] dump_stack+0x104/0x190 (unreliable)
[    7.203502] [c000000ff5503a10] [c0000000001297d0] ___might_sleep+0x2e0/0x320
[    7.203539] [c000000ff5503a90] [c000000000c049fc] down_read+0x3c/0xc0
[    7.203569] [c000000ff5503ad0] [c0000000009f7c70] cpufreq_get+0x50/0xc0
[    7.203600] [c000000ff5503b20] [c000000000093618] pnv_get_proc_freq+0x28/0x60
[    7.203637] [c000000ff5503b50] [c00000000002bfc0] show_cpuinfo+0x1b0/0x460
[    7.203667] [c000000ff5503c00] [c0000000003e14b8] seq_read+0x238/0x5c0
[    7.203698] [c000000ff5503ca0] [c000000000441e80] proc_reg_read+0xb0/0x110
[    7.203729] [c000000ff5503cf0] [c0000000003a16cc] __vfs_read+0x6c/0x1c0
[    7.203759] [c000000ff5503d90] [c0000000003a18dc] vfs_read+0xbc/0x1b0
[    7.203788] [c000000ff5503de0] [c0000000003a20cc] SyS_read+0x6c/0x110
[    7.203819] [c000000ff5503e30] [c00000000000b82c] system_call+0x58/0x6c

>  arch/powerpc/platforms/powernv/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index 897aa14..55ea4bf 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -311,7 +311,7 @@ static unsigned long pnv_get_proc_freq(unsigned int cpu)
>  {
>  	unsigned long ret_freq;
>  
> -	ret_freq = cpufreq_quick_get(cpu) * 1000ul;
> +	ret_freq = cpufreq_get(cpu) * 1000ul;
>  
>  	/*
>  	 * If the backend cpufreq driver does not exist,
