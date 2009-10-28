Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CD237B7BCD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 22:24:38 +1100 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9SBL9eI006383
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2009 07:21:09 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9SBOYEU089922
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2009 07:24:34 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9SBOXFS012300
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2009 07:24:34 -0400
Date: Wed, 28 Oct 2009 07:24:30 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Subject: Re: Accessing flash directly from User Space
Message-ID: <20091028112430.GO22408@zod.rchland.ibm.com>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<4AE7545F.80805@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>
	<4AE75859.5050108@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
Cc: Bill Gatliff <bgat@billgatliff.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 27, 2009 at 04:24:53PM -0600, Jonathan Haws wrote:
>> >>> How can I get that pointer?  Unfortunately I cannot simply use
>> the
>> >>>
>> >> address of the flash.  Is there some magical function call that
>> >> gives me access to that portion of the memory space?
>> >>
>> >> $ man 2 mmap
>> >>
>> >> You want MAP_SHARED and O_SYNC.
>> >>
>> >
>> >
>> > To use that I need to have a file descriptor to a device, do I
>> not?  However, I do not have a base flash driver to give me that
>> file descriptor.  Am I missing something with that call?
>> >
>> 
>> /dev/mem
>> 
>Okay, I now have access to the flash memory, however when I write to it the writes do not take.  I have tried calling msync() on the mapping to no avail.  I have opened the fd with O_SYNC, but cannot get things to work right.
>
>Here are the calls:
>
>	int fd = open("/dev/mem", O_SYNC | O_RDWR);
>	uint16_t * flash = (uint16_t *)mmap(NULL, NOR_FLASH_SIZE,
>			(PROT_READ | PROT_WRITE), MAP_PRIVATE, fd,
>			NOR_FLASH_BASE_ADRS);

What board and CPU are you using?  Is your flash really at 0xFC800000, or is
that the virtual address that VxWorks puts it at?

josh
