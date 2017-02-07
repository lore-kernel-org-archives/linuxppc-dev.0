Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHc8J0NPrzDqKl
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 18:55:27 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v177ra55110865
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 02:55:25 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28f68s06aw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 02:55:24 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 7 Feb 2017 17:55:22 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C2CF02BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 18:55:19 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v177tB1q35782878
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 18:55:19 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v177slea002753
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 18:54:47 +1100
Date: Tue, 7 Feb 2017 13:24:20 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/powernv: Add more BPF in defconfig
References: <20170206025544.3292-1-mikey@neuling.org>
 <20170206025544.3292-2-mikey@neuling.org>
 <87tw86g8t3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87tw86g8t3.fsf@concordia.ellerman.id.au>
Message-Id: <20170207075420.GJ4090@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/07 11:10AM, Michael Ellerman wrote:
> Michael Neuling <mikey@neuling.org> writes:
> 
> > This enables BCC (https://github.com/iovisor/bcc) on powernv.
> >
> > This adds 225KB to the vmlinux size.
> >
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> >  arch/powerpc/configs/powernv_defconfig | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
> > index 7028dbc753..911b43e2c7 100644
> > --- a/arch/powerpc/configs/powernv_defconfig
> > +++ b/arch/powerpc/configs/powernv_defconfig
> > @@ -29,6 +29,7 @@ CONFIG_CGROUP_CPUACCT=y
> >  CONFIG_CGROUP_PERF=y
> >  CONFIG_USER_NS=y
> >  CONFIG_BLK_DEV_INITRD=y
> > +CONFIG_BPF_SYSCALL=y
> >  # CONFIG_COMPAT_BRK is not set
> >  CONFIG_PROFILING=y
> >  CONFIG_OPROFILE=y
> > @@ -79,6 +80,10 @@ CONFIG_NETFILTER=y
> >  # CONFIG_NETFILTER_ADVANCED is not set
> >  CONFIG_BRIDGE=m
> >  CONFIG_VLAN_8021Q=m
> > +CONFIG_NET_SCHED=y
> > +CONFIG_NET_CLS_BPF=y
> > +CONFIG_NET_CLS_ACT=y
> > +CONFIG_NET_ACT_BPF=y
> 
> I'm inclined to make these =m.
> 
> I assume that would still work for bcc?

Yes, that should work too.
As an aside, I had sent a patch to enable BPF_SYSCALL across powernv, 
pseries and ppc64 defconfigs:
https://patchwork.ozlabs.org/patch/721997/

It would be good to have the network related BPF configs enabled across 
all three.

- Naveen
