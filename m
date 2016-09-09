Return-Path: <ebiederm@xmission.com>
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVnhY1WRYzDrpW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 16:43:08 +1000 (AEST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>
References: <1472579105-26296-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <8760q7lswz.fsf@x220.int.ebiederm.org>
 <871t0vlrlv.fsf@x220.int.ebiederm.org> <3106532.NfQxgDJQ20@hactar>
Date: Thu, 08 Sep 2016 23:07:17 -0500
In-Reply-To: <3106532.NfQxgDJQ20@hactar> (Thiago Jung Bauermann's message of
 "Thu, 08 Sep 2016 16:20:45 -0300")
Message-ID: <87k2elhg22.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v4 0/5] kexec_file: Add buffer hand-over for the next
 kernel
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Am Mittwoch, 07 September 2016, 09:19:40 schrieb Eric W. Biederman:
>> ebiederm@xmission.com (Eric W. Biederman) writes:
>> > Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>> >> Hello,
>> >> 
>> >> The purpose of this new version of the series is to fix a small issue
>> >> that I found, which is that the kernel doesn't remove the memory
>> >> reservation for the hand-over buffer it received from the previous
>> >> kernel in the device tree it sets up for the next kernel. The result
>> >> is that for each successive kexec, a stale hand-over buffer is left
>> >> behind, wasting memory.
>> >> 
>> >> This is fixed by changes to kexec_free_handover_buffer and
>> >> setup_handover_buffer in patch 2. The other change is to fix checkpatch
>> >> warnings in the last patch.
>> > 
>> > This is fundamentally broken.  You do not increase the integrity of a
>> > system by dropping integrity checks.
>> > 
>> > No. No. No. No.
>> > 
>> > Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> The IMA measurement list can be verified without the need of a checksum over 
> its contents by replaying the PCR extend operations and checking that the 
> result matches the registers in the TPM device. So the fact that it is not 
> part of the kexec segments checksum verification doesn't actually reduce the 
> integrity of the system.

Bit flips and errant DMA transfers are the concern here.  That happens
routinely and can easily result in a corrupt data structure which may be
non-trivial to verify.

> Currently, IMA doesn't perform that verification when it restores the 
> measurement list from the kexec handover buffer, so if you believe it's 
> necessary to do that check at boot time, we could do one of the following:
>
> 1. Have IMA replay the PCR extend operations when it restores the 
> measurement list from the handover buffer and validate it against the TPM 
> PCRs, or
>
> 2. Have a buffer hash in the ima_kexec_hdr that IMA includes in the handover 
> buffer, and verify the buffer checksum before restoring the measurement 
> list.
>
> What do you think?

I think you are playing very much with fire and I am extremely
uncomfortable with the entire concept.  I think you are making things
more complicated in a way that will allow system to try and start
booting when their memory is correct.  Which may wind up corrupting
someones non-volatile storage.

It makes me doubly nervous that this adds a general purpose facility
that is generally not at all reusable.

I have seen malicious actors cause entirely too much damage to be at all
comfortable using a data structure before we validate that it was valid
before we started booting.  This isn't the same case but it is close
enough I don't trust someone just splatting data structures.
We can't guarantee integrity but we should not bypass best practices
either.

>> To be constructive the way we have handled similiar situations in the
>> past (hotplu memory) is to call kexec_load again.
>
> Thanks for your suggestion. Unfortunately it's always possible for new 
> measurements to be added to the measurement list between the kexec_file_load 
> and the reboot. We see that happen in practice with system scripts and 
> configuration files that are only read or executed during the reboot 
> process. They are only measured by IMA as a result of the kexec execute.

If I understand what you are saying correctly I expect things could be
setup so that those measurements are forced to happen before kexec load.

Especially in a boot loader context which you described earlier I
believe you should have quite a lot of control of the system.  Having a
facility that fundamentally undermines the design of kexec for a case
where someone might do something you have not predicted does not make me
comfortable.

Which is to say I don't see why you can't measure things before the
kexec_load system call in a tightly controlled setup like a boot loader.
Which should make it that in practice no measurements change.  I believe
that should increase the reliability of the system overall.

Having code in the kernel that updates a buffer that kexec will use
after that buffer is loaded in memory honestely gives me the heebie
jeebies.

Eric
