Message-ID: <40C71EAE.6030706@fh-landshut.de>
Date: Wed, 09 Jun 2004 16:29:02 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: VME driver patch for PowerPC
References: <DB1DE297F535B340AEAE1E51B221C3D007E84015@FTWMLVEM02.e2k.ad.ge.com>
In-Reply-To: <DB1DE297F535B340AEAE1E51B221C3D007E84015@FTWMLVEM02.e2k.ad.ge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Heater, Daniel (GE Infrastructure) wrote:
>>         /* Don't swap these pages out
>>          */
>>-       vma->vm_flags |= VM_RESERVED;
>>+       vma->vm_flags |= VM_LOCKED | VM_IO | VM_SHM;
>
>
> I'm trying to understand this change. VM_IO looks like it needs to
> be there to prevent deadlocks on core dumps.
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0202.0/1309.html
>
> and if I'm interpreting some older mailing list postings correctly,
> VM_RESERVED is a replacement for VM_LOCKED | VM_SHM but VM_RESERVED
> may yield some performance advantages. Thus, in later kernels you
> only see VM_RESERVED and not VM_LOCKED | VM_SHM.
>
> Maybe since this is an out of tree driver, it should have
>
>>+       vma->vm_flags |= VM_LOCKED | VM_IO | VM_SHM | VM_RESERVED;
>
>
> to handle older kernels and still get the advantages of VM_RESERVED
> on newer kernels.
>
> What do you think? Am I interpreting this correctly?
>

To be frank, I "modelled" this after the flag configuration in
pci_mmap_page_range() in the PowerPC tree of kernel 2.4.21 (where I got the page
protection changes, too).

If VM_RESERVED is somewhat of an alias, it should prove okay. Looking into my
"documentation" yielded no quick results for flag interpretation.

I could simply test, if both works.

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
