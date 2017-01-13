Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v0VZQ31fhzDqVS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2017 04:52:14 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0DHnQL4101181
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 12:52:11 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27y21h42wj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 12:52:11 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Sat, 14 Jan 2017 03:52:08 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D6B862BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2017 04:52:06 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0DHq60Y29163616
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2017 04:52:06 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0DHq505001948
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2017 04:52:06 +1100
Date: Fri, 13 Jan 2017 23:22:01 +0530
From: "'Naveen N. Rao'" <naveen.n.rao@linux.vnet.ibm.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "ast@fb.com" <ast@fb.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH 3/3] powerpc: bpf: implement in-register swap for 64-bit
 endian operations
References: <e73efe6facf6c06932b4a87707e5978172ee773e.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
 <bb264395301754f43b77ddec68a16dd34220abb4.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DB02635FB@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB02635FB@AcuExch.aculab.com>
Message-Id: <20170113175201.GD3470@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/01/13 05:17PM, David Laight wrote:
> From: Naveen N. Rao
> > Sent: 13 January 2017 17:10
> > Generate instructions to perform the endian conversion using registers,
> > rather than generating two memory accesses.
> > 
> > The "way easier and faster" comment was obviously for the author, not
> > the processor.
> 
> That rather depends on whether the processor has a store to load forwarder
> that will satisfy the read from the store buffer.
> I don't know about ppc, but at least some x86 will do that.

Interesting - good to know that.

However, I don't think powerpc does that and in-register swap is likely 
faster regardless. Note also that gcc prefers this form at higher 
optimization levels.

Thanks,
Naveen
