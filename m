Return-Path: <markc@mail.com>
Received: from smtp1.us4.outblaze.com (smtp1.us4.outblaze.com [205.158.62.78])
	by ozlabs.org (Postfix) with SMTP id DC41867A77
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 04:43:38 +1100 (EST)
Message-ID: <00be01c64ea1$4c6e0e20$6401a8c0@CHUCK2>
From: "Mark Chambers" <markc@mail.com>
To: "Linuxppc-Embedded \(\(E-Mail\)\)" <linuxppc-embedded@ozlabs.org>
References: <B1E46DE837A394458BB1A58F74A66A780596CB@ala-mail02.corp.ad.wrs.com><204E7000-3E88-4497-86C0-5AF786D72F75@kernel.crashing.org><4422D6E3.1010407@ovro.caltech.edu>
	<CCA437BF-E204-4652-9E6D-25388225EFE8@kernel.crashing.org>
Subject: Re: Memory mapping PCI memory region to user space
Date: Thu, 23 Mar 2006 12:43:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>
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
>
>> So, if someone planned on using that 'feature', that would
>> be a reason for writing your own mmap() implementation.
>> I didn't see any option in the sysfs file for setting that
>> page flag (but, I didn't look around in other sysfs files).
>
> There isn't a sysfs flag for the endianness page attribute since
> thats a PPC book-e specific feature.  We could possible expand things
> to support it but, I've been trying to actively avoid using the 'E' bit.
>

Framebuffer applications could care about this.  Also, on the MPC8247
(maybe others, but I know about this one) you can make the PCI space
big- or little-endian.

Seems to me this is really not an endian issue but a PCI implementation
issue.  PCI is actually endian-agnostic, so we're really 'fixing' the 
Freescale
PCI implementation with endian swapping.

Mark Chambers 
