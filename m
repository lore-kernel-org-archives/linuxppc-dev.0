Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 694BF1A0202
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 00:57:41 +1100 (AEDT)
Message-ID: <5693B4C1.4060400@maciej.szmigiero.name>
Date: Mon, 11 Jan 2016 14:57:21 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
References: <5677107C.60904@maciej.szmigiero.name>	<CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>
 <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
In-Reply-To: <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Fabio,

Thanks for testing.

On 11.01.2016 13:10, Fabio Estevam wrote:
> On Mon, Jan 11, 2016 at 10:04 AM, Fabio Estevam <festevam@gmail.com> wrote:
> 
>> This patch causes the following issue in linux-next:
>>
>> [    2.526984] ------------[ cut here ]------------
>> [    2.531632] WARNING: CPU: 1 PID: 1 at kernel/locking/lockdep.c:2755
>> lockdep_trace_alloc+0xf4/0x124()
>> [    2.540771] DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
>> [    2.546175] Modules linked in:
>> [    2.549447] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
>> 4.4.0-rc8-next-20160111 #204
>> [    2.557021] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>> [    2.563553] Backtrace:
>> [    2.566040] [<c00136d8>] (dump_backtrace) from [<c0013874>]
>> (show_stack+0x18/0x1c)
>> [    2.573615]  r6:00000ac3 r5:00000000 r4:00000000 r3:00000000
>> [    2.579362] [<c001385c>] (show_stack) from [<c02de89c>]
>> (dump_stack+0x88/0xa4)
>> [    2.586607] [<c02de814>] (dump_stack) from [<c002bcac>]
>> (warn_slowpath_common+0x80/0xbc)
>> [    2.594702]  r5:c0071ed0 r4:ef055b90
>> [    2.598326] [<c002bc2c>] (warn_slowpath_common) from [<c002bd8c>]
>> (warn_slowpath_fmt+0x38/0x40)
>> [    2.607028]  r8:00000004 r7:00000004 r6:024080c0 r5:024080c0 r4:60000093
>> [    2.613829] [<c002bd58>] (warn_slowpath_fmt) from [<c0071ed0>]
>> (lockdep_trace_alloc+0xf4/0x124)
>> [    2.622532]  r3:c09a1634 r2:c099dc0c
>> [    2.626161] [<c0071ddc>] (lockdep_trace_alloc) from [<c010bc0c>]
>> (kmem_cache_alloc+0x30/0x174)
>> [    2.634778]  r4:ef001f00 r3:c0b02a88
>> [    2.638407] [<c010bbdc>] (kmem_cache_alloc) from [<c03edac8>]
>> (regcache_rbtree_write+0x150/0x724)
>> [    2.647283]  r10:00000000 r9:00000010 r8:00000004 r7:00000004
>> r6:0000002c r5:00000000
>> [    2.655203]  r4:00000000
>> [    2.657767] [<c03ed978>] (regcache_rbtree_write) from [<c03ec7d8>]
>> (regcache_write+0x5c/0x64)
> 
> This fixes the warning:
> 
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -180,7 +180,6 @@ static const struct regmap_config fsl_ssi_regconfig = {
>         .volatile_reg = fsl_ssi_volatile_reg,
>         .precious_reg = fsl_ssi_precious_reg,
>         .writeable_reg = fsl_ssi_writeable_reg,
> -       .cache_type = REGCACHE_RBTREE,
>  };
> 
> Is this the correct fix?
> 

This will disable register cache so it isn't right.
Could you try REGCACHE_FLAT instead, please?

Looks like the problem here is rbtree cache does some non-atomic allocations in
read / write path when not supplied with default register values.

Best regards,
Maciej Szmigiero
