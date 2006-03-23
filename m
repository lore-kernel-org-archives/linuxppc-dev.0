Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A93E067B27
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 07:00:41 +1100 (EST)
In-Reply-To: <B1E46DE837A394458BB1A58F74A66A78059878@ala-mail02.corp.ad.wrs.com>
References: <B1E46DE837A394458BB1A58F74A66A78059878@ala-mail02.corp.ad.wrs.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FA7B7204-761F-47D6-8C29-1D72CA55B135@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Memory mapping PCI memory region to user space
Date: Thu, 23 Mar 2006 14:01:32 -0600
To: "Wyse, Chris" <chris.wyse@windriver.com>
Cc: "Linuxppc-Embedded \(\(E-Mail\)\)" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 23, 2006, at 1:52 PM, Wyse, Chris wrote:

> Hi,
>
> Thanks for all the help.
>
> My ideal solution would have been to use sysfs, but I didn't want to
> upgrade the kernel.  Therefore, I used Dave's program as a guide for
> setting the protect bits appropriately, and was able to get the driver
> working.  The driver required the pfn_pte macro change specified in my
> original post.  It appears to be a kernel bug on PPC processors with a
> greater than 32 bit address space.

The issue with greater than 32 bit address spaces goes away in newer  
kernels with the use of io_remap_pfn_range() instead of  
io_remap_page_range().

- kumar

> -----Original Message-----
> From: David Hawkins [mailto:dwh@ovro.caltech.edu]
> Sent: Thursday, March 23, 2006 12:47 PM
> To: Kumar Gala
> Cc: Wyse, Chris; Linuxppc-Embedded ((E-Mail))
> Subject: Re: Memory mapping PCI memory region to user space
>
> Hi Kumar,
>
>>> When I was testing the Yosemite board as the host, I found that I
>>> could set the endian flag on the mmapped page, which then made the
>>> PCI device registers read as 32-bit quantities read back with the
>>> same layout under both x86 and PPC hosts.
>>
>> Hmm, I guess I would handle this like how the reset of the kernel
>> handle is with the io routines handling the swapping.  Not sure if
>> there is any advantage to using the endian flag.  I guess if you have
>> something you are treating as just memory there would be.
>
> I haven't used the feature, I just tested it to see what it did.
>
> The application case I thought of was this; the PCI boards I built  
> (that
> I am revising, and replacing the DSP with a PPC) have an 8MB PCI  
> region
> that I can mmap from the host. I have a test suite that runs from the
> host that manipulates registers on the boards to download FPGAs etc.
> When the boards are used in a real system, the onboard DSP is  
> generally
> used, and the host just talks to the DSP.
>
> However, for the test suite, if I have a header with definitions
> like:
>
> #define CONTROL_FPGA_ENABLE   (1 << 0)
> #define CONTROL_FPGA_DONE_BIT (1 << 1)
>
> that correspond to bits in a 32-bit PCI mmapped register. Then code in
> the user-space test suite that did something like
>
>    pci_addr[CONTROL_OFFSET] |= CONTROL_FPGA_ENABLE;
>
> would instead need to be re-written, eg.,
>
>    write_le32(&pci_addr[CONTROL_OFFSET], CONTROL_FPGA_ENABLE);
>
> to be portable.
>
> I definitely agree that this is how kernel-level code should be  
> written,
> but user-space code ... well, if I want to reuse code already written,
> setting the page endian flag and reusing the code would seem like the
> way to go. (This isn't what I need to do, since my host will still  
> be an
> x86, the PPC will be a target device, but I still need to think about
> the endian issues).
>
> Now of course that I have seen the consequences of my coding, I'll be
> more careful to deal with endianness more appropriately.
>
> Its a tricky trade-off though. I could define control ioctl's that  
> hide
> all the endianness issues ... but then the driver just gets bigger. I
> think the appropriate solution for the user-space test code would  
> be to
> use CPU-to-little-endian routines, and wrap the lot in a re-usable
> library that the test suite links against.
>
>> There isn't a sysfs flag for the endianness page attribute since
>> thats a PPC book-e specific feature.  We could possible expand things
>
>> to support it but, I've been trying to actively avoid using the 'E'
> bit.
>
> Ok, I haven't received the 8349E board that I am waiting on, so I  
> hadn't
> spotted that the PAGE_ENDIAN flag was Book E specific.
>
> Thanks for your insight.
>
> Cheers
> Dave
>
>
>
