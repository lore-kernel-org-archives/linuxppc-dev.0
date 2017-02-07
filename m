Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHpHj1xkyzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 02:32:32 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v17FSUuj105749
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 10:32:30 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28faw83cn6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 10:32:30 -0500
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 7 Feb 2017 13:32:27 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 106EF1DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 10:32:26 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v17FWOcR34603156
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 13:32:24 -0200
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v17FWOUg007051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 13:32:24 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC] powerpc/pseries: Increase busy loop in pseries_cpu_die
Date: Tue, 07 Feb 2017 13:32:22 -0200
In-Reply-To: <20170207025645.GB22303@localhost.localdomain>
References: <1486407496-12151-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20170207025645.GB22303@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <11711559.cvjM6Evb1C@morokweng>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Dienstag, 7. Februar 2017, 08:26:45 BRST schrieb Balbir Singh:
> On Mon, Feb 06, 2017 at 04:58:16PM -0200, Thiago Jung Bauermann wrote:
> > [  447.714064] Querying DEAD? cpu 134 (134) shows 2
> > cpu 0x86: Vector: 300 (Data Access) at [c000000007b0fd40]
> > 
> >     pc: 000000001ec3072c
> >     lr: 000000001ec2fee0
> >     sp: 1faf6bd0
> >    
> >    msr: 8000000102801000
> >    dar: 212d6c1a2a20c
> 
> This looks like we accessed a bad address, but why?

Am Dienstag, 7. Februar 2017, 13:10:22 BRST schrieb Michael Ellerman:
> We shouldn't be crashing.
> 
> So we need to fix that.
> 
> We may also need to increase the timeout, though it's pretty gross TBH.
> 
> But step one is make sure we don't crash.

I didn't analyze exactly what is causing the CPU to crash because the root 
cause is the inconsistency between what the kernel thinks the CPU state is and 
reality. But if we have to be able to handle that inconsistency I will keep 
digging and try to fix that.

> > --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > @@ -206,7 +206,7 @@ static void pseries_cpu_die(unsigned int cpu)
> > 
> >  		}
> >  	
> >  	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {
> > 
> > -		for (tries = 0; tries < 25; tries++) {
> > +		for (tries = 0; tries < 5000; tries++) {
> 
> This fixes some of the asymmetry between handling of CPU_STATE_INACTIVE
> and CPU_STATE_OFFLINE, but I think we can probably move the cpu_relax()
> to msleep(1).

I didn't change it to msleep() because I thought it would introduce a 
regression. commit b906cfa397fd ("powerpc/pseries: Fix cpu hotplug") changed a 
msleep(200) that was there to a cpu_relax() with this explanation:

    Currently, pseries_cpu_die() calls msleep() while polling RTAS for 
    the status of the dying cpu.

    However, if the cpu that is going down also happens to be the one 
    doing the tick then we're hosed as the tick_do_timer_cpu 'baton' is
    only passed later on in tick_shutdown() when _cpu_down() does the 
    CPU_DEAD notification.  Therefore jiffies won't be updated anymore.

    This replaces that msleep() with a cpu_relax() to make sure we're not 
    going to schedule at that point.

    With this patch my test box survives a 100k iterations hotplug stress
    test on _all_ cpus, whereas without it, it quickly dies after ~50 
    iterations.

I can try to add it back and see what happens. Perhaps that situation won't 
happen anymore with today's kernel.

> Please also see
> 940ce42 powerpc/pseries: Increase cpu die timeout

Yes, that is the commit that I mentioned in the patch description.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
