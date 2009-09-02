Return-Path: <rientjes@google.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 12939B70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 06:09:15 +1000 (EST)
Received: from smtp-out.google.com (smtp-out.google.com [216.239.33.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D0CADDD01
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Sep 2009 06:09:13 +1000 (EST)
Received: from spaceape10.eur.corp.google.com (spaceape10.eur.corp.google.com
	[172.28.16.144]) by smtp-out.google.com with ESMTP id n82K989c029897
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Sep 2009 21:09:08 +0100
Received: from pxi32 (pxi32.prod.google.com [10.243.27.32])
	by spaceape10.eur.corp.google.com with ESMTP id n82K9162011124
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Sep 2009 13:09:05 -0700
Received: by pxi32 with SMTP id 32so1079184pxi.25
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Sep 2009 13:09:04 -0700 (PDT)
Date: Wed, 2 Sep 2009 13:09:01 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] Fix fake numa on ppc
In-Reply-To: <661de9470909021256i569261bxbe1523d8e37b5b14@mail.gmail.com>
Message-ID: <alpine.DEB.1.00.0909021304210.13939@chino.kir.corp.google.com>
References: <20090902060911.GA5728@in.ibm.com>
	<alpine.DEB.1.00.0909012326290.31814@chino.kir.corp.google.com>
	<20090902080346.GB3806@in.ibm.com>
	<alpine.DEB.1.00.0909021226160.10279@chino.kir.corp.google.com>
	<661de9470909021256i569261bxbe1523d8e37b5b14@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="531381004-1054151817-1251921958=:13939"
Cc: linuxppc-dev@ozlabs.org, Ankita Garg <ankita@in.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--531381004-1054151817-1251921958=:13939
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.1.00.0909021306361.13939@chino.kir.corp.google.com>

On Thu, 3 Sep 2009, Balbir Singh wrote:

> > Right, I'm proposing an alternate mapping scheme (which we've used for
> > years) for both platforms such that a cpu is bound (and is set in
> > cpumask_of_node()) to each fake node with which it has physical affinity.
> > That is the only way for zonelist ordering in node order, task migration
> > from offlined cpus, correct sched domains, etc.  I can propose a patchset
> > for x86_64 to do exactly this if there aren't any objections and I hope
> > you'll help do ppc.
> 
> Sounds interesting, I'd definitely be interested in seeing your
> proposal, but I would think of that as additional development on top
> of this patch
> 

Absolutely.  I'm not familiar with numa=fake on ppc, but if cpus are being 
bound to nodes with which they don't have affinity, it definitely warrants 
a fix such as this (although the initial value for fake_enabled looks 
wrong and fake_numa_node_mapping[] can be __cpuinitdata).  I'll cc you, 
Ben, and Ankita on the x86_64 patches.  Thanks.
--531381004-1054151817-1251921958=:13939--
