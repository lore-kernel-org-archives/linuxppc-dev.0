Return-Path: <rientjes@google.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8A704B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 05:46:31 +1000 (EST)
Received: from smtp-out.google.com (smtp-out.google.com [216.239.33.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44A2DDDD01
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Sep 2009 05:46:29 +1000 (EST)
Received: from spaceape23.eur.corp.google.com (spaceape23.eur.corp.google.com
	[172.28.16.75]) by smtp-out.google.com with ESMTP id n82JaB9D007332
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Sep 2009 20:36:11 +0100
Received: from pzk8 (pzk8.prod.google.com [10.243.19.136])
	by spaceape23.eur.corp.google.com with ESMTP id n82Ja7lb013887
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Sep 2009 12:36:08 -0700
Received: by pzk8 with SMTP id 8so1008480pzk.22
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Sep 2009 12:36:07 -0700 (PDT)
Date: Wed, 2 Sep 2009 12:36:04 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Ankita Garg <ankita@in.ibm.com>
Subject: Re: [PATCH v2] Fix fake numa on ppc
In-Reply-To: <20090902080346.GB3806@in.ibm.com>
Message-ID: <alpine.DEB.1.00.0909021226160.10279@chino.kir.corp.google.com>
References: <20090902060911.GA5728@in.ibm.com>
	<alpine.DEB.1.00.0909012326290.31814@chino.kir.corp.google.com>
	<20090902080346.GB3806@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2 Sep 2009, Ankita Garg wrote:

> Currently, the behavior of fake numa is not so on x86 as well? Below is
> a sample output from a single node x86 system booted with numa=fake=8:
> 
> # cat node0/cpulist
> 
> # cat node1/cpulist
> 
> ...
> # cat node6/cpulist
> 
> # cat node7/cpulist
> 0-7
> 
> Presently, just fixing the cpu association issue with ppc, as explained
> in my previous mail.
> 

Right, I'm proposing an alternate mapping scheme (which we've used for 
years) for both platforms such that a cpu is bound (and is set in 
cpumask_of_node()) to each fake node with which it has physical affinity.  
That is the only way for zonelist ordering in node order, task migration 
from offlined cpus, correct sched domains, etc.  I can propose a patchset 
for x86_64 to do exactly this if there aren't any objections and I hope 
you'll help do ppc.
