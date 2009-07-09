Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 10D86B7083
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jul 2009 13:41:34 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49CC7DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2009 13:41:32 +1000 (EST)
Message-Id: <E6EB8DA7-8B38-4C97-BE3C-4649DFA295C8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Alan Modra <amodra@bigpond.net.au>
In-Reply-To: <20090708233954.GA3181@bubble.grove.modra.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: binutils 2.19 issue with kernel link
Date: Wed, 8 Jul 2009 22:39:09 -0500
References: <09159ADA-39F9-419E-AE46-4CFAE612AFB9@kernel.crashing.org>
	<20090708233954.GA3181@bubble.grove.modra.org>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	bug-binutils@gnu.org, Edmar Wienskoski-RA8797 <Edmar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 8, 2009, at 6:39 PM, Alan Modra wrote:

> On Wed, Jul 08, 2009 at 05:41:39PM -0500, Kumar Gala wrote:
>> If we modify the linker script:
>>
>>      _end2 = .;
>>      _end3 = ALIGN(4096);
>>      _end4 = ALIGN(PAGE_SIZE);
>>      . = ALIGN(PAGE_SIZE);
>>      _end = . ;
>>      PROVIDE32 (end = .);
>>
>> and the result is:
>>
>> 00001000 A _end
>> c067f678 A _end2
>> c0680000 A _end3
>> c0680000 A _end4
>
> Possibly some section with a zero vma is being placed before _end.
> Generate a link map to see if this is so.

Playing with this further I think its related to the -me500 option we  
pass and thus wondering if its something with the APU section  
handling.  If I hack the kernel up a little and pass -m440 instead  
things seem to be ok.

- k
