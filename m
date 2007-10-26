Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 80782DDDFF
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 21:06:30 +1000 (EST)
Message-ID: <4721C9E9.10208@ru.mvista.com>
Date: Fri, 26 Oct 2007 15:05:13 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [RFC] [PATCH] PowerPC: Workaround for the
	440EP(x)/GR(x)	processors identical PVR issue.
References: <20071025181640.GA18933@ru.mvista.com>
	<1193345051.7018.15.camel@pasglop>
In-Reply-To: <1193345051.7018.15.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-dev@ozlabs.org, sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2007-10-25 at 22:16 +0400, Valentine Barshak wrote:
>> PowerPC 440EP(x) 440GR(x) processors have the same PVR values, since
>> they have identical cores. However, FPU is not supported on GR(x) and
>> enabling APU instruction broadcast in the CCR0 register (to enable FPU)
>> may cause unpredictable results. There's no safe way to detect FPU
>> support at runtime. This patch provides a workarund for the issue.
>> We use a POWER6 "logical PVR approach". First, we identify all EP(x)
>> and GR(x) processors as GR(x) ones (which is safe). Then we check 
>> the device tree cpu path. If we have a EP(x) processor entry,
>> we call identify_cpu again with PVR | 0x8. This bit is always 0
>> in the real PVR. This way we enable FPU only for 440EP(x).
>>
>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> 
> Why not just or-in the FPU feature bit ?
> 
> Ben.
> 
> 

It's not enough. We need to enable APU instruction broadcast for EP(x) 
(call __init_fpu_44x in arch/powerpc/kernel/cpu_setup_44x.S).
Or do you suggest to or-in FPU feature bit and enable APUIB later, not 
in the cpu_setup callback?
Thanks,
Valentine.
