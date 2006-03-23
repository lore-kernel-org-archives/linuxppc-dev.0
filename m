Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id E681867A6F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 04:45:03 +1100 (EST)
Message-ID: <4422DEFF.9070202@ovro.caltech.edu>
Date: Thu, 23 Mar 2006 09:46:39 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Memory mapping PCI memory region to user space
References: <B1E46DE837A394458BB1A58F74A66A780596CB@ala-mail02.corp.ad.wrs.com>
	<204E7000-3E88-4497-86C0-5AF786D72F75@kernel.crashing.org>
	<4422D6E3.1010407@ovro.caltech.edu>
	<CCA437BF-E204-4652-9E6D-25388225EFE8@kernel.crashing.org>
In-Reply-To: <CCA437BF-E204-4652-9E6D-25388225EFE8@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Chris Wyse <chris.wyse@windriver.com>,
	"Linuxppc-Embedded \(\(E-Mail\)\)" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar,

>> When I was testing the Yosemite board as the host, I found
>> that I could set the endian flag on the mmapped page, which
>> then made the PCI device registers read as 32-bit quantities
>> read back with the same layout under both x86 and PPC
>> hosts.
> 
> Hmm, I guess I would handle this like how the reset of the kernel  
> handle is with the io routines handling the swapping.  Not sure if  
> there is any advantage to using the endian flag.  I guess if you have  
> something you are treating as just memory there would be.

I haven't used the feature, I just tested it to see what it did.

The application case I thought of was this; the PCI boards I built
(that I am revising, and replacing the DSP with a PPC) have an
8MB PCI region that I can mmap from the host. I have a test
suite that runs from the host that manipulates registers on the boards
to download FPGAs etc. When the boards are used in a real system,
the onboard DSP is generally used, and the host just talks to
the DSP.

However, for the test suite, if I have a header with definitions
like:

#define CONTROL_FPGA_ENABLE   (1 << 0)
#define CONTROL_FPGA_DONE_BIT (1 << 1)

that correspond to bits in a 32-bit PCI mmapped register. Then
code in the user-space test suite that did something like

   pci_addr[CONTROL_OFFSET] |= CONTROL_FPGA_ENABLE;

would instead need to be re-written, eg.,

   write_le32(&pci_addr[CONTROL_OFFSET], CONTROL_FPGA_ENABLE);

to be portable.

I definitely agree that this is how kernel-level code should be
written, but user-space code ... well, if I want to reuse code
already written, setting the page endian flag and reusing the
code would seem like the way to go. (This isn't what I need
to do, since my host will still be an x86, the PPC will
be a target device, but I still need to think about the
endian issues).

Now of course that I have seen the consequences of my coding,
I'll be more careful to deal with endianness more appropriately.

Its a tricky trade-off though. I could define control ioctl's
that hide all the endianness issues ... but then the driver just
gets bigger. I think the appropriate solution for the user-space
test code would be to use CPU-to-little-endian routines, and
wrap the lot in a re-usable library that the test suite
links against.

> There isn't a sysfs flag for the endianness page attribute since  thats 
> a PPC book-e specific feature.  We could possible expand things  to 
> support it but, I've been trying to actively avoid using the 'E' bit.

Ok, I haven't received the 8349E board that I am waiting
on, so I hadn't spotted that the PAGE_ENDIAN flag was
Book E specific.

Thanks for your insight.

Cheers
Dave
