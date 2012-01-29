Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8CC0CB6EF7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jan 2012 14:14:53 +1100 (EST)
Message-ID: <4F24B9DF.8010006@windriver.com>
Date: Sun, 29 Jan 2012 11:15:43 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
Subject: Re: Problem in getting shared memory access on P1022RDK
References: <93CD5F41FDBC6042A6B449764F3B35CC050CCA22@EU-MBX-03.mgc.mentorg.com>
 <93CD5F41FDBC6042A6B449764F3B35CC050CCA80@EU-MBX-03.mgc.mentorg.com>
 <4F033685.6000509@freescale.com>
 <93CD5F41FDBC6042A6B449764F3B35CC050CCB2E@EU-MBX-03.mgc.mentorg.com>
 <4F050653.6010601@windriver.com>
 <93CD5F41FDBC6042A6B449764F3B35CC050CD375@EU-MBX-03.mgc.mentorg.com>
 <4F0E9539.7090205@windriver.com>
 <93CD5F41FDBC6042A6B449764F3B35CC050CE2CD@EU-MBX-03.mgc.mentorg.com>
In-Reply-To: <93CD5F41FDBC6042A6B449764F3B35CC050CE2CD@EU-MBX-03.mgc.mentorg.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arshad, Farrukh wrote:
> I have dumped TLB entries while mapping shared memory. On both cores M-Bit (MAS2[61]) is set in TLB0 entries. On both cores M-Bit is set for all valid TLB1 entries. TLB1 does contains some invalid entries which has M-Bit cleared. So I believe at this time the coherency is not the issue. Any further thoughts on the issue ?
>

Did you check all associated TLBx VPN/RPN and attribute setting are same between
two scenarios: W -> Core0 & R <- Core1 and W -> Core1 & R <- Core0?

Can you send me your TLB dump log separately if possible?

And did you try this flag 'O_SYNC'?

Tiejun

> I have modified dump_tlb_book3e function (found in arch/powerpc/xmon/xmon.c) function for BookE MMU to dump TLB entries.
> 
> Regards,
> Farrukh Arshad
> 
> 
> -----Original Message-----
> From: tiejun.chen [mailto:tiejun.chen@windriver.com] 
> Sent: Thursday, January 12, 2012 1:09 PM
> To: Arshad, Farrukh
> Cc: Scott Wood; linuxppc-dev@lists.ozlabs.org
> Subject: Re: Problem in getting shared memory access on P1022RDK
> 
> Arshad, Farrukh wrote:
>> Adding more it,
>>
>> I have removed the shared memory kernel driver dependency just to narrow down the problem area and I have written a small piece of code in user space. A writer & a reader application which access the shared memory and I got the same behavior as with the shared memory kernel driver. Interestingly, my user space application work fine on P1022DS but not on P1022RDK however both using the same CPU modules.
>>
>> When I write a simple string on shared memory from Core 1 it is read 
>> at Core 0 properly When I write a simple string on shared memory from Core 0 it is not read at Core 1.
>>
> 
> Did you dump TLB entry to check page memory coherence attribute for a shared memory as I mentioned previously? This should be consistent on both sides.
> 
>> With this test now I am sure the problem lies in the kernel itself. Any pointers to look for the troubled area ?
>>
>> My application code is (error checking and other code is omitted)
>>
>> #define 	SHM_BASE 	0x1C000000
>> #define	SHM_SIZE 	0x400000		// 4 MB of Shared Memory
>> #define 	PAGE_SIZE 	(4*1024)
>>
>> fd = open(device, O_RDWR);
> 
> You may need to add with 'O_SYNC'.
> 
> Tiejun
> 
>> shm = malloc(SHM_SIZE + (PAGE_SIZE - 1)); if ( (unsigned long) shm % 
>> PAGE_SIZE) {
>> 	shm += PAGE_SIZE - ((unsigned long)shm % PAGE_SIZE); }
>>
>> shm = mmap(shm, SHM_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED | 
>> MAP_FIXED, fd, SHM_BASE); ......
>> ...... write some string at shm.
>>
>> My memory partitioning for both systems is
>>
>> Core                 		Base Address         	Size
>> Core 0               		0x0000,0000          	0x1000,0000
>> Core 1               		0x1000,0000          	0x0C00,0000
>> Shared Memory    	0x1C00,0000          	0x0400,0000
>>
>> Regards,
>> Farrukh Arshad.
>> Mentor Graphics Pakistan
> 
