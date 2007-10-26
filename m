Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8ADD1DDE1E
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 23:17:32 +1000 (EST)
Message-ID: <4721E8A0.9040406@ru.mvista.com>
Date: Fri, 26 Oct 2007 17:16:16 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [RFC] [PATCH] PowerPC: Workaround for
	the	440EP(x)/GR(x)	processors identical PVR issue.
References: <20071025181640.GA18933@ru.mvista.com>	
	<1193345051.7018.15.camel@pasglop> <4721C9E9.10208@ru.mvista.com>
	<1193397923.13638.5.camel@pasglop>
In-Reply-To: <1193397923.13638.5.camel@pasglop>
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
> On Fri, 2007-10-26 at 15:05 +0400, Valentine Barshak wrote:
>> It's not enough. We need to enable APU instruction broadcast for
>> EP(x) 
>> (call __init_fpu_44x in arch/powerpc/kernel/cpu_setup_44x.S).
>> Or do you suggest to or-in FPU feature bit and enable APUIB later,
>> not 
>> in the cpu_setup callback?
> 
> It can be done at any time before the feature fixup. However, on 32
> bits, iirc, the fixup happens very early so it might not be that easy...
> just asking :-) Your patch is allright, we can always find a better way
> to do it later on.

Yes, ftr fix-up is made very early on 32 bits.
I need to workaround the identical pvr issue, since I'm going to submit 
PowerPC 440GRx Rainier board support soon. It's much like Sequoia, just 
no FPU and USB.
Thanks,
Valentine.

> 
> Ben.
> 
> 
