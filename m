Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f175.google.com (mail-yw0-f175.google.com
	[209.85.211.175]) by ozlabs.org (Postfix) with ESMTP id 3F922B6F04
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2009 16:16:57 +1100 (EST)
Received: by ywh5 with SMTP id 5so6826361ywh.11
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Dec 2009 21:16:56 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091208.202838.78052287.davem@davemloft.net>
References: <20091205043015.28041.19288.stgit@angua>
	<20091208.202838.78052287.davem@davemloft.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 8 Dec 2009 22:16:36 -0700
Message-ID: <fa686aa40912082116r7750c83cs55ccfbb4b937c095@mail.gmail.com>
Subject: Re: [PATCH/REPOST] net/mpc5200: Fix locking on fec_mpc52xx driver
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: a.llano@ziv.es, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 8, 2009 at 9:28 PM, David Miller <davem@davemloft.net> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Fri, 04 Dec 2009 21:33:13 -0700
>
>> Fix the locking scheme on the fec_mpc52xx driver. =A0This device can
>> receive IRQs from three sources; the FEC itself, the tx DMA, and the
>> rx DMA. =A0Mutual exclusion was handled by taking a spin_lock() in the
>> critical regions, but because the handlers are run with IRQs enabled,
>> spin_lock() is insufficient and the driver can end up interrupting
>> a critical region anyway from another IRQ.
>>
>> Asier Llano discovered that this occurs when an error IRQ is raised
>> in the middle of handling rx irqs which resulted in an sk_buff memory
>> leak.
>
> I'll apply this fix.

Thanks.

> But, longer term, it's a thousand times easier and more efficient to
> move the processing of these interrupts into softirq context.

I agree.  Just need to find someone to do it.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
