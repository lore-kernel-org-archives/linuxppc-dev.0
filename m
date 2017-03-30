Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtwst35KqzDqKx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 18:16:34 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2U78gQ1145632
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 03:16:23 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29gfrjj8gk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 03:16:22 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 30 Mar 2017 12:46:19 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2U7F1DA11010204
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 12:45:01 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2U7GGOs012845
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 12:46:17 +0530
Date: Thu, 30 Mar 2017 12:46:13 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/2] powerpc: string: implement optimized memset variants
References: <20170322193030.GA8008@bombadil.infradead.org>
 <cover.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
 <d6a1a353de6a87bb5474ca9f1c1ff7ab2c4a1eb4.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
 <87mvc6b575.fsf@concordia.ellerman.id.au>
 <20170328102109.GC4762@naverao1-tp.localdomain>
 <87a884jow3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87a884jow3.fsf@concordia.ellerman.id.au>
Message-Id: <20170330071613.GE4762@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/03/29 10:36PM, Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> > I also tested zram today with the command shared by Wilcox:
> >
> > without patch:       1.493782568 seconds time elapsed    ( +-  0.08% )
> > with patch:          1.408457577 seconds time elapsed    ( +-  0.15% )
> >
> > ... which also shows an improvement along the same lines as x86, as 
> > reported by Minchan Kim.
> 
> I got:
> 
>   1.344847397 seconds time elapsed                                          ( +-  0.13% )
> 
> Using the C versions. Can you also benchmark those on your setup so we
> can compare? So basically apply Matt's series but not your 2.

Ok, with a more comprehensive test:
	$ sudo modprobe zram
	$ sudo zramctl -f -s 1G
	# ~/tmp/1g has repeated 8 byte patterns
	$ sudo bash -c "cat ~/tmp/1g > /dev/zram0"

Here are the results I got on a P8 vm with:
	$ sudo ./perf stat -r 10 taskset -c 16-23 dd if=/dev/zram0 of=/dev/null

vanilla:	1.770592578 seconds time elapsed	( +-  0.07% )
generic:	1.728865141 seconds time elapsed	( +-  0.06% )
optimized:	1.695363255 seconds time elapsed        ( +-  0.10% )

(generic) is with Matt's arch-independent patches applied. Profiling 
indicates that most of the overhead is actually with the lzo 
decompression...

Also, with a simple module to memset64() a 1GB vmalloc'ed buffer, here 
are the results:
generic:	0.245315533 seconds time elapsed	( +-  1.83% )
optimized:	0.169282701 seconds time elapsed	( +-  1.96% )


- Naveen
