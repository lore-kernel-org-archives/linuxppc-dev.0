Return-Path: <j.borkhuis@dutchspace.nl>
Received: from kirk.dutchspace.nl (kirk.dutchspace.nl [193.200.147.14])
	by ozlabs.org (Postfix) with ESMTP id 2A16EDDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 May 2008 16:28:13 +1000 (EST)
Message-ID: <482A8446.2030309@dutchspace.nl>
Date: Wed, 14 May 2008 08:18:46 +0200
From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
MIME-Version: 1.0
To: MingLiu <eemingliu@hotmail.com>
Subject: Re: mmap problem in device driver and application program.
References: <BAY138-W55519F961B3A01D0B8A167B2D00@phx.gbl>	<1210266109.3755.8.camel@localhost.localdomain>	<BAY138-W36C7249F532D111A1DC508B2D00@phx.gbl>
	<1210366552.3755.21.camel@localhost.localdomain>
	<BAY138-W368A781D323F0E5E4D0BF3B2CF0@phx.gbl>
In-Reply-To: <BAY138-W368A781D323F0E5E4D0BF3B2CF0@phx.gbl>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

MingLiu wrote:
> Dear Dave,
>   
>> If you are using memory that is not under the kernel's memory management> you will need to use something other than remap_pfn_range.> 
>>     
> Happenly and unfortunately we are using the memory space out of the control from the kernel. We have 2GB memory on the board and only 64(or 32) MB is reserved for the kernel. The rest large space is for the data buffering or LUT use. In my question, the LUT memory is located in the rest part rather than the kernel memory area. 
>  
> Any more suggestion on how to mmap this LUT area? Any idea will be valuable for a beginner like me. Thanks in advance. 
>   

If this is physical memory that is not controlled by the kernel you
could also use the /dev/mem device. You could do something like:

memFd = open("/dev/mem", O_RDWR);
memBuf = mmap(0, <Memory size>, PROT_READ | PROT_WRITE, MAP_SHARED,
memFd, <Physical address of memory);

which maps the physical memory into user space, without the need for a
special device driver or mmap implementation.

Kind regards,
Johan Borkhuis
