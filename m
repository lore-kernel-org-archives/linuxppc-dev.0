Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6E0B0B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 09:53:47 +1000 (EST)
Message-ID: <1335311621.15830.42.camel@pasglop>
Subject: Re: Regression in 32-bit ppc kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
Date: Wed, 25 Apr 2012 09:53:41 +1000
In-Reply-To: <4F973026.3020103@lwfinger.net>
References: <4F973026.3020103@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-04-24 at 17:58 -0500, Larry Finger wrote:
> Hi,
> 
> Somewhere between v3.2 and v3.3, the kernel in my Powerbook G4 started issuing 
> the following traceback on bootup:

Does it continue working afterward or not at all ?

Are you using the old IDE driver or the newer libata based pata_macio ?

Cheers,
Ben.

> [   40.264006] irq 23: nobody cared (try booting with the "irqpoll" option)
> [   40.264031] Call Trace:
> [   40.264070] [dfff3f00] [c000984c] show_stack+0x7c/0x194 (unreliable)
> [   40.264102] [dfff3f40] [c00a6840] __report_bad_irq+0x44/0xf4
> [   40.264119] [dfff3f60] [c00a6adc] note_interrupt+0x1ec/0x2ac
> [   40.264135] [dfff3f80] [c00a48a8] handle_irq_event_percpu+0x250/0x2b8
> [   40.264152] [dfff3fd0] [c00a4944] handle_irq_event+0x34/0x54
> [   40.264169] [dfff3fe0] [c00a7514] handle_fasteoi_irq+0xb4/0x124
> [   40.264192] [dfff3ff0] [c000f5bc] call_handle_irq+0x18/0x28
> [   40.264208] [dec85ce0] [c000719c] do_IRQ+0x114/0x1cc
> [   40.264226] [dec85d10] [c0015868] ret_from_except+0x0/0x1c
> [   40.264254] --- Exception: 501 at find_vma+0x10/0x80
> [   40.264259]     LR = do_page_fault+0x26c/0x6ac
> [   40.264272] [dec85dd0] [c03f0128] do_page_fault+0x25c/0x6ac (unreliable)
> [   40.264289] [dec85f40] [c00155e4] handle_page_fault+0xc/0x80
> [   40.264327] --- Exception: 301 at 0x4800a174
> 
> The problem still exists in v3.4-rc3. I am currently doing a bisection of this 
> problem, but it will take a long time to complete.
> 
> Note: IRQ 23 is not active in v3.2.
> 
> Thanks,
> 
> Larry
