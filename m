Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0140.outbound.protection.outlook.com [65.55.169.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C6BF1A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 15:18:42 +1000 (AEST)
Message-ID: <1440739104.26094.1.camel@freescale.com>
Subject: Re: [PATCH v2,2/5] powerpc/rcpm: add RCPM driver
From: Scott Wood <scottwood@freescale.com>
To: Chenhui Zhao <chenhui.zhao@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <Jason.Jin@freescale.com>
Date: Fri, 28 Aug 2015 00:18:24 -0500
In-Reply-To: <1440722422.31670.0@remotesmtp.freescale.net>
References: <1440590988-25594-1-git-send-email-chenhui.zhao@freescale.com>
 <1440590988-25594-2-git-send-email-chenhui.zhao@freescale.com>
 <20150826203539.GA10582@home.buserror.net>
 <1440722422.31670.0@remotesmtp.freescale.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-08-28 at 08:40 +0800, Scott Wood wrote:
> On Thu, Aug 27, 2015 at 4:35 AM, Scott Wood <scottwood@freescale.com> 
> wrote:
> > On Wed, Aug 26, 2015 at 08:09:45PM +0800, Chenhui Zhao wrote:

I didn't write this e-mail.  Please fix your mail client.

> > >  +static void rcpm_v1_cpu_up_prepare(int cpu)
> > >  +{
> > >  +        rcpm_v1_cpu_exit_state(cpu, E500_PM_PH15);
> > >  +        rcpm_v1_irq_unmask(cpu);
> > >  +}
> > >  +
> > >  +static void rcpm_v2_cpu_exit_state(int cpu, int state)
> > >  +{
> > >  +        int hw_cpu = get_hard_smp_processor_id(cpu);
> > >  +        u32 mask = 1 << cpu_core_index_of_thread(hw_cpu);
> > 
> > Are you sure cpu_core_index_of_thread() is supposed to take a hardware
> > cpu id?  The only current user, pseries_energy.c, has the comment
> > "Convert logical cpu number to core number".
> 
> Here, the method of getting core index of thread is same for physical 
> and logical.
> So use this existed function to do the job.

I realize that you get the same result either way, but that doesn't make it 
OK.  You have "cpu"; pass that instead of "hw_cpu".

-Scott
