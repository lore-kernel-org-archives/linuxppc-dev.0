Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBBgB65SdzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 20:30:45 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9A9T7dk067694
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 05:30:42 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dgsy44uuh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 05:30:42 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 10 Oct 2017 10:30:40 +0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9A9Ucbq17694778
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 09:30:39 GMT
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9A9Uf5H032743
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 20:30:41 +1100
Date: Tue, 10 Oct 2017 15:00:34 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Santosh Sivaraj <santosh@fossix.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
References: <20171006112528.zryd4l2yl2k6xk2h@naverao1-tp.localdomain>
 <20171009080949.25913-1-santosh@fossix.org>
 <20171009103918.liylptwpf2tsu3qa@naverao1-tp.localdomain>
 <20171010090352.zociis352gxvfelg@santosiv.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171010090352.zociis352gxvfelg@santosiv.in.ibm.com>
Message-Id: <20171010093033.73x66lxl3xxi33qo@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/10/10 09:03AM, Santosh Sivaraj wrote:
> * Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com> wrote (on 2017-10-09 10:39:18 +0000):
> 
> > On 2017/10/09 08:09AM, Santosh Sivaraj wrote:

[snip]

> > > +	add     r3,r3,r0
> > > +	ld      r0,CFG_TB_UPDATE_COUNT(r3)
> > > +	cmpld   cr0,r0,r8               /* check if updated */
> > > +	bne-    70b
> > 
> > I also notice that the code for dealing with CLOCK_MONOTONIC is similar 
> > for _COARSE and regular clocks. If possible, we should reuse that as 
> > well.
> >
> In this case we will be adding more checks and branches in order to reuse
> the code. If we want to keep the code common we will have to do a lot of
> jumping around, code will contain a bunch of branches, which I feel will make
> the code/flow hard to understand. (Q: Does lot of branches have bad effect on
> branch prediction?)

Right - like we discussed offline, if it hurts readability, that's a 
good enough reason not to do this. We are only talking about a few 
instructions here anyway, so no need to worry too much.

- Naveen
