Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 227C3DDF26
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 03:39:41 +1000 (EST)
Date: Thu, 20 Sep 2007 21:41:59 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [POWERPC] Fix QEIC->MPIC cascading
Message-ID: <20070920174159.GA10765@localhost.localdomain>
References: <20070920130244.GA18043@localhost.localdomain>
	<46F2A7CC.1040106@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <46F2A7CC.1040106@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 20, 2007 at 12:03:08PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
>> set_irq_chained_handler overwrites MPIC's handle_irq function
>> (handle_fasteoi_irq) thus MPIC never gets eoi event from the
>> cascaded IRQ. This situation hangs MPIC on MPC8568E.
>
> I'm not familiar with the differences between IPIC and MPIC.  What is this 
> patch not needed for 83xx?

Yup, this patch not needed for 83xx. IPIC doesn't have end()/eoi().
(..and MPIC doesn't have ack()).

Though...

Idially QEIC should do both ack() and end(), at the beginning and at
the end of irq handling respectively.

I don't know (didn't look) why this works for 83xx w/o ack()...
maybe IPIC don't need this. Or maybe there is a bug hiding.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
