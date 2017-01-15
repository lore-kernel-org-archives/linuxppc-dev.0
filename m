Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v1fh52jWJzDqTr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 02:01:09 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0FErxmd061504
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jan 2017 10:01:06 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27ymwjsq0y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jan 2017 10:01:05 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 16 Jan 2017 01:01:02 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0F6613578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 02:01:00 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0FF12OM48955612
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 02:01:02 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0FF0wXq023328
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 02:00:59 +1100
Subject: Re: [PATCH 3/3] powerpc: bpf: implement in-register swap for 64-bit
 endian operations
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: "'Naveen N. Rao'" <naveen.n.rao@linux.vnet.ibm.com>, David Laight
 <David.Laight@ACULAB.COM>
Cc: "daniel@iogearbox.net" <daniel@iogearbox.net>, "ast@fb.com" <ast@fb.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Date: Sun, 15 Jan 2017 09:00:58 -0600
In-Reply-To: <20170113175201.GD3470@naverao1-tp.localdomain>
References: <e73efe6facf6c06932b4a87707e5978172ee773e.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
 <bb264395301754f43b77ddec68a16dd34220abb4.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DB02635FB@AcuExch.aculab.com>
 <20170113175201.GD3470@naverao1-tp.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1484492458.11927.17.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-01-13 at 23:22 +0530, 'Naveen N. Rao' wrote:
> > That rather depends on whether the processor has a store to load forwarder
> > that will satisfy the read from the store buffer.
> > I don't know about ppc, but at least some x86 will do that.
> 
> Interesting - good to know that.
> 
> However, I don't think powerpc does that and in-register swap is likely 
> faster regardless. Note also that gcc prefers this form at higher 
> optimization levels.

Of course powerpc has a load-store forwarder these days, however, I
wouldn't be surprised if the in-register form was still faster on some
implementations, but this needs to be tested.

Ideally, you'd want to try to "optimize" load+swap or swap+store
though.

Cheers,
Ben.
