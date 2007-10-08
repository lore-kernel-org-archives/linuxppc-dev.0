Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 24E76DDF33
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 23:31:30 +1000 (EST)
In-Reply-To: <1191791123.6392.0.camel@pasglop>
References: <C2771B73-A555-4119-AC21-1441D4CC2125@freescale.com>
	<18184.23379.478676.911097@cargo.ozlabs.ibm.com>
	<796C20BF-1592-4F07-B83B-5EA35CADBA01@kernel.crashing.org>
	<1191791123.6392.0.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <94E2E7A0-FFCA-4F08-9A9C-AA62CAE63F63@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: TASK_SIZE default 0x80000000 ?
Date: Mon, 8 Oct 2007 08:31:40 -0500
To: benh@au1.ibm.com
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 7, 2007, at 4:05 PM, Benjamin Herrenschmidt wrote:

>
>> Can you explain (a) further -- I'm assuming the BAT mapping is 1:1
>> for that region?
>>
>> For (b) it looks like:
>> * 40x, 44x, fsl-booke compare against TASK_SIZE in their software
>> handlers.
>> * 8xx still tests 0x80000000
>> * 6xx (603) compares against KERNELBASE
>>
>> It would seem like we should set the default on 8xx & PReP to
>> 0x80000000 and not allow it to be modified since that will break the
>> world and for everything else move it to match KERNELBASE.  Any
>> issues with that?
>
> The proper value is neither :-)
>
> It should be compared against PAGE_OFFSET.

I'll work up a patch to switch us to testing PAGE_OFFSET instead.

- k
