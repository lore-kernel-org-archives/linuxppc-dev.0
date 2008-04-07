Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 21365DE13B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 00:14:41 +1000 (EST)
Date: Mon, 7 Apr 2008 09:24:56 -0500
From: Olof Johansson <olof@lixom.net>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC: MPIC ack interrupts at mpic_teardown_this_cpu()
Message-ID: <20080407142456.GA20229@lixom.net>
References: <20080403190943.GA16446@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080403190943.GA16446@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 03, 2008 at 11:09:43PM +0400, Valentine Barshak wrote:
> We really need to ack interrupts at mpic_teardown, since
> not all platforms reset mpic at kernel start-up. For example,
> kexec'ed kernel hangs on P.A. Semi if mpic_eoi() isn't called.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

I have applied this to pasemi.git for-2.6.26 with the following comment
added before the mpic_eoi call:

        /* We need to EOI the IPI since not all platforms reset the MPIC
         * on boot and new interrupts wouldn't get delivered otherwise.
         */
	mpic_eoi(mpic);


Thanks,

-Olof
