Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B0939B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Jul 2009 00:39:29 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9F50DDD1C
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Jul 2009 00:39:28 +1000 (EST)
Message-Id: <D4C31507-B4F9-4979-A6E1-7971242D644B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Alan Modra <amodra@bigpond.net.au>
In-Reply-To: <20090710041536.GE3181@bubble.grove.modra.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: binutils 2.19 issue with kernel link
Date: Fri, 10 Jul 2009 09:37:03 -0500
References: <09159ADA-39F9-419E-AE46-4CFAE612AFB9@kernel.crashing.org>
	<20090708233954.GA3181@bubble.grove.modra.org>
	<E6EB8DA7-8B38-4C97-BE3C-4649DFA295C8@kernel.crashing.org>
	<AB02ECF3-9C72-436B-A946-CBCCD3859762@kernel.crashing.org>
	<20090709044007.GB3181@bubble.grove.modra.org>
	<4B3B917C-C8B0-416B-888D-13E6C0645BF8@kernel.crashing.org>
	<4A5645A9.3080003@freescale.com>
	<20090710041536.GE3181@bubble.grove.modra.org>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	bug-binutils@gnu.org, Edmar Wienskoski-RA8797 <edmar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 9, 2009, at 11:15 PM, Alan Modra wrote:

> On Thu, Jul 09, 2009 at 02:31:53PM -0500, Edmar Wienskoski-RA8797  
> wrote:
>> I understand your arguments, but there is something inconsistent  
>> about this.
>> If I change the script to be:
>>       _end3 = . ;
>>       . = _end3;
>>       . = ALIGN(PAGE_SIZE);
>>       _end = . ;
>>       PROVIDE32 (end = .);
>> }
>> The result is corrected:
>> c067f678 A _end3
>> c0680000 A _end
>>
>> Why the apuinfo section with zero VMA sometimes interfere with "."  
>> and
>> sometimes not ?
>
> I said it was weird in my last email.  Not so.  The orphan gets placed
> between
>
>       _end3 = . ;
>       . = _end3;
>
> So dot is restored after the orphan section sets it.

This seems to be a bit of a chick and egg scenario.  Older kernel  
linker scripts aren't going to cover all sections and thus may have  
orphan sections.  How do we ensure _end can be set properly under such  
conditions?

- k
