Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22a.google.com (mail-pf0-x22a.google.com
 [IPv6:2607:f8b0:400e:c00::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KRmb0nk6zDqZH
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 20:46:06 +1000 (AEST)
Received: by mail-pf0-x22a.google.com with SMTP id p15so5587365pff.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Apr 2018 03:46:06 -0700 (PDT)
Date: Mon, 9 Apr 2018 20:45:53 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64: irq_work avoid immediate interrupt when
 raised with hard irqs enabled
Message-ID: <20180409204553.414404bf@roar.ozlabs.ibm.com>
In-Reply-To: <1523263589.11062.20.camel@kernel.crashing.org>
References: <20180405143146.4285-1-npiggin@gmail.com>
 <1523263589.11062.20.camel@kernel.crashing.org>
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

On Mon, 09 Apr 2018 18:46:29 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2018-04-06 at 00:31 +1000, Nicholas Piggin wrote:
> > irq_work_raise should not schedule the hardware decrementer interrupt
> > unless it is called from NMI context. Doing so often just results in an
> > immediate masked decrementer interrupt:
> > 
> >    <...>-550    90d...    4us : update_curr_rt <-dequeue_task_rt
> >    <...>-550    90d...    5us : dbs_update_util_handler <-update_curr_rt
> >    <...>-550    90d...    6us : arch_irq_work_raise <-irq_work_queue
> >    <...>-550    90d...    7us : soft_nmi_interrupt <-soft_nmi_common
> >    <...>-550    90d...    7us : printk_nmi_enter <-soft_nmi_interrupt
> >    <...>-550    90d.Z.    8us : rcu_nmi_enter <-soft_nmi_interrupt
> >    <...>-550    90d.Z.    9us : rcu_nmi_exit <-soft_nmi_interrupt
> >    <...>-550    90d...    9us : printk_nmi_exit <-soft_nmi_interrupt
> >    <...>-550    90d...   10us : cpuacct_charge <-update_curr_rt
> > 
> > Set the decrementer pending in the irq_happened mask directly, rather
> > than having the masked decrementer handler do it.  
> 
> Setting the paca field needs hard irqs off...

Doh! Good catch, I should have noticed that :)

> also preempt_disable
> doesn't look necessary if IRQs are off.

True, just copied from existing code.

Thanks,
Nick
