Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 125AEDE43B
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 20:53:53 +1000 (EST)
Message-Id: <C48BDA23-14CD-49B1-9882-189657DCBB62@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18429.31390.141903.1442@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 01/11] [POWERPC] bootwrapper: Allow specifying of image
	physical offset
Date: Thu, 10 Apr 2008 05:53:48 -0500
References: <1207015715-31496-1-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-2-git-send-email-galak@kernel.crashing.org>
	<18418.2460.594352.712502@cargo.ozlabs.ibm.com>
	<5DBEA342-7674-414B-A666-B8FBEED34814@kernel.crashing.org>
	<18418.55835.338209.611273@cargo.ozlabs.ibm.com>
	<0F53B076-0A94-4A2D-8D9A-ED507B53ABE6@kernel.crashing.org>
	<18420.31327.633359.619200@cargo.ozlabs.ibm.com>
	<C91EF39E-9776-4D7C-883E-F560A671E221@kernel.crashing.org>
	<18429.31390.141903.1442@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 9, 2008, at 9:25 PM, Paul Mackerras wrote:
> Kumar Gala writes:
>
>> So now we can look at the vmlinux and determine the physical offset.
>> The question is how best to do that.  Here are the options I see:
>> * readelf, grep and parse output
>> * objdump grep and parse output
>> * simple C program that read's the elf and reports back
>
> Either readelf or objdump for now, and if that proves to be fragile we
> can look at a C program.  You could do:
>
> readelf -l $vmlinux | grep -m 1 LOAD | awk '{print $4}'
>
> or
>
> objdump -p $vmlinux | grep -m 1 LOAD | awk '{print $7}'
>
> There's not a lot of difference.  Since the wrapper already uses
> objdump, I think we should use objdump rather than making the wrapper
> depend on an additional program (readelf).
>
>> The other questions is if we'd ever have a vmlinux with more than one
>> PT_LOAD PHDR.  If so which one do we use (the one with the lowest
>> physical address)?
>
> I think we would take the first one.

Ok.  I've reworked this patch and sent in the new patch series.

- k
