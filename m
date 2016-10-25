Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t392q63ZpzDvWV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 21:52:19 +1100 (AEDT)
Date: Tue, 25 Oct 2016 12:49:33 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
cc: Marc Zyngier <marc.zyngier@arm.com>, monstr@monstr.eu, ralf@linux-mips.org,
 jason@lakedaemon.net, alistair@popple.id.au, mporter@kernel.crashing.org,
 soren.brinkmann@xilinx.com, linux-kernel@vger.kernel.org,
 linux-mips@linux-mips.org, michal.simek@xilinx.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org
Subject: Re: [Patch v5 04/12] irqchip: xilinx: Add support for parent intc
In-Reply-To: <581adf44-388c-f8e5-8437-59d7ace2fa8f@imgtec.com>
Message-ID: <alpine.DEB.2.20.1610251246020.4990@nanos>
References: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1476723176-39891-5-git-send-email-Zubair.Kakakhel@imgtec.com>
 <32f5f17d-7864-c782-7a6f-03660b7ab055@arm.com>
 <581adf44-388c-f8e5-8437-59d7ace2fa8f@imgtec.com>
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

On Tue, 25 Oct 2016, Zubair Lutfullah Kakakhel wrote:
> On 10/21/2016 10:48 AM, Marc Zyngier wrote:
> > Shouldn't you return an error if irq is zero?
> > 
> 
> I'll add the following for the error case
> 
> 	pr_err("%s: Parent exists but interrupts property not defined\n" ,
> __func__);

Please do not use this silly __func__ stuff. It's not giving any value to
the printout.

Set a proper prefix for your pr_* stuff, so the string is prefixed with
'irq-xilinx:' or whatever you think is appropriate. Then the string itself
is good enough to find from which place this printk comes.

Thanks,

	tglx
