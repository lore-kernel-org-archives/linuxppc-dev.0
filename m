Return-Path: <ppclinux@sundmangroup.com>
Received: from post.uniweb.no (post.uniweb.no [195.159.128.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "post.uniweb.no", Issuer "post.uniweb.no" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D880B2BE83
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Dec 2004 03:51:01 +1100 (EST)
Message-ID: <57959.194.237.142.10.1103129461.squirrel@webmail1.unisite.se>
In-Reply-To: <41BF5607.8040609@smiths-aerospace.com>
References: <62302.213.114.195.235.1103055907.squirrel@webmail1.unisite.se>
	<41BF5607.8040609@smiths-aerospace.com>
Date: Wed, 15 Dec 2004 17:51:01 +0100 (CET)
From: ppclinux@sundmangroup.com
To: "Jerry Van Baren" <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MEMORY PROBLEM
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Your SDRAM initialization is suspect

Thx for that. Those words made me go through the SDRAM
initialization once again and BINGO the PSDMR register had
an address line setting wrong.

The thing is that we have boards with 128M and 256M and the
PSDMR register settings was the same for both. Other involved
registers were modified by the book.

THX!

Cheers // Matias


> ppclinux@sundmangroup.com wrote:
>> Hello,
>> I have a Freescale-PPC8270 ( Former Motorola ) based board with 256Megs
>> of
>> RAM.
>>
>> I am using the Montavista Vista Kernel 2.4.20.
>>
>> When the system is handling larger files ~100M when NFS mounted and ~20M
>> when RAMDISKed the kernel crashes since things are being overwritten in
>> memory.
>>
>> The crash happens when handling/creating large files by measn of e.g.
>> * dd
>> * gunzip
>> * sftp download
>> etc. it seems to be a general memory handling problem.
>>
>> When looking at the memory though there are plenty of free space, or
>> there
>> should be plenty of free space but for some reason things are
>> overwritten...
>>
>> The Kernel reports actually 256M of memory. Top also shows that there is
>> o
>> r should be more than enough free memory for the operations I am trying
>> to
>> pull :-))
>>
>> Can you give me suggestions where to start digging into this problem?
>>
>> Best Regards // Matias
>
> Your SDRAM initialization is suspect
>    http://www.denx.de/twiki/bin/view/DULG/LinuxCrashesRandomly
>    http://www.denx.de/twiki/bin/view/DULG/SDRAM
>    http://www.denx.de/twiki/bin/view/DULG/UBootCrashAfterRelocation
>
> gvb
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
