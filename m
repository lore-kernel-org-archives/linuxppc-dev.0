Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8h7k5284zDt0X
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 21:30:42 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA3ASc41031327
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2016 06:30:39 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26fwh37ch8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Nov 2016 06:30:39 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 3 Nov 2016 16:00:35 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 3A5061258061
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 16:01:18 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA3AUVMK42074134
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2016 16:00:31 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA3AUSYJ011609
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2016 16:00:31 +0530
Date: Thu, 3 Nov 2016 16:00:19 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Denis Kirjanov <kda@linux-powerpc.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: compiling master.
References: <20161103065317.8537-1-naveen.n.rao@linux.vnet.ibm.com>
 <87zilgnb6x.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87zilgnb6x.fsf@concordia.ellerman.id.au>
Message-Id: <20161103103019.GJ6949@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/11/03 08:51PM, Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> > diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> > index 2e4e7d8..9b7b302 100644
> > --- a/arch/powerpc/include/asm/exception-64s.h
> > +++ b/arch/powerpc/include/asm/exception-64s.h
> > @@ -91,7 +91,7 @@
> >   */
> >  #define LOAD_HANDLER(reg, label)					\
> >  	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
> > -	ori	reg,reg,(FIXED_SYMBOL_ABS_ADDR(label))@l;
> > +	ori	reg,reg,((FIXED_SYMBOL_ABS_ADDR(label)) & 0xffff);
> 
> That's weird. We explicitly added the @l there to make it work with
> binutils 2.22. Is the Redhat "2.23" not really 2.23 ?

Not sure why @l isn't working. It does seem to be 2.23. Also, it is a 
bit weird that this only shows up on BE and not on LE...

[root@rhel71be linux]# rpm -qf /usr/bin/as
binutils-2.23.52.0.1-30.el7.ppc64
[root@rhel71be linux]# rpm -qi binutils
Name        : binutils
Version     : 2.23.52.0.1
Release     : 30.el7
Architecture: ppc64
Install Date: Thursday 03 November 2016 03:58:24 PM IST
Group       : Development/Tools
Size        : 14200512
License     : GPLv3+
Signature   : RSA/SHA256, Monday 19 January 2015 10:14:51 PM IST, Key ID 
199e2f91fd431d51
Source RPM  : binutils-2.23.52.0.1-30.el7.src.rpm
Build Date  : Thursday 15 January 2015 10:55:42 PM IST
Build Host  : ppc-020.build.eng.bos.redhat.com
Relocations : (not relocatable)
Packager    : Red Hat, Inc. <http://bugzilla.redhat.com/bugzilla>
Vendor      : Red Hat, Inc.
URL         : http://sources.redhat.com/binutils
Summary     : A GNU collection of binary utilities


- Naveen
