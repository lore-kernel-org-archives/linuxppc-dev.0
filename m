Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DB432B7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 06:02:43 +1000 (EST)
Received: from mail-px0-f196.google.com (mail-px0-f196.google.com
	[209.85.216.196]) by ozlabs.org (Postfix) with ESMTP id 593AADDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Sep 2009 06:02:43 +1000 (EST)
Received: by pxi34 with SMTP id 34so1005844pxi.4
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Sep 2009 13:02:41 -0700 (PDT)
MIME-Version: 1.0
Sender: bsingharora@gmail.com
In-Reply-To: <alpine.DEB.1.00.0909021226160.10279@chino.kir.corp.google.com>
References: <20090902060911.GA5728@in.ibm.com>
	<alpine.DEB.1.00.0909012326290.31814@chino.kir.corp.google.com>
	<20090902080346.GB3806@in.ibm.com>
	<alpine.DEB.1.00.0909021226160.10279@chino.kir.corp.google.com>
Date: Thu, 3 Sep 2009 01:26:18 +0530
Message-ID: <661de9470909021256i569261bxbe1523d8e37b5b14@mail.gmail.com>
Subject: Re: [PATCH v2] Fix fake numa on ppc
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Thu, Sep 3, 2009 at 1:06 AM, David Rientjes<rientjes@google.com> wrote:
> On Wed, 2 Sep 2009, Ankita Garg wrote:
>
>> Currently, the behavior of fake numa is not so on x86 as well? Below is
>> a sample output from a single node x86 system booted with numa=3Dfake=3D=
8:
>>
>> # cat node0/cpulist
>>
>> # cat node1/cpulist
>>
>> ...
>> # cat node6/cpulist
>>
>> # cat node7/cpulist
>> 0-7
>>
>> Presently, just fixing the cpu association issue with ppc, as explained
>> in my previous mail.
>>
>
> Right, I'm proposing an alternate mapping scheme (which we've used for
> years) for both platforms such that a cpu is bound (and is set in
> cpumask_of_node()) to each fake node with which it has physical affinity.
> That is the only way for zonelist ordering in node order, task migration
> from offlined cpus, correct sched domains, etc. =A0I can propose a patchs=
et
> for x86_64 to do exactly this if there aren't any objections and I hope
> you'll help do ppc.

Sounds interesting, I'd definitely be interested in seeing your
proposal, but I would think of that as additional development on top
of this patch

Balbir Singh.
