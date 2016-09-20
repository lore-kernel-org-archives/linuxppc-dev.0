Return-Path: <ebiederm@xmission.com>
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdp0W3FV1zDsfk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 02:21:14 +1000 (AEST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
 <2097581.F8Sg9EkmE6@hactar> <87d1k3p0jy.fsf@x220.int.ebiederm.org>
 <15061913.JRHEL97DN3@hactar>
Date: Tue, 20 Sep 2016 11:07:29 -0500
In-Reply-To: <15061913.JRHEL97DN3@hactar> (Thiago Jung Bauermann's message of
 "Sun, 18 Sep 2016 18:25:51 -0300")
Message-ID: <87y42mk11a.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATHC v2 0/9] ima: carry the measurement list across kexec
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Am Samstag, 17 September 2016, 00:17:37 schrieb Eric W. Biederman:
>> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>> > Hello Eric,
>> > 
>> > Am Freitag, 16 September 2016, 14:47:13 schrieb Eric W. Biederman:
>> >> I can see tracking to see if the list has changed at some
>> >> point and causing a reboot(LINUX_REBOOT_CMD_KEXEC) to fail.
>> > 
>> > Yes, that is an interesting feature that I can add using the checksum-
>> > verifying part of my code. I can submit a patch for that if there's
>> > interest, adding a reboot notifier that verifies the checksum and causes
>> > a regular reboot instead of a kexec reboot if the checksum fails.
>> 
>> I was thinking an early failure instead of getting all of the way down
>> into a kernel an discovering the tpm/ima subsystem would not
>> initialized.  But where that falls in the reboot pathway I don't expect
>> there is much value in it.
>
> I'm not sure I understand. What I described doesn't involve the tpm or ima. 
> I'm suggesting that if I take the parts of patch 4/5 in the kexec hand-over 
> buffer series that verify the image checksum, I can submit a separate patch 
> that checks the integrity of the kexec image early in kernel_kexec() and 
> reverts to a regular reboot if the check fails. This would be orthogonal to 
> ima carrying its measurement list across kexec.
>
> I think there is value in that, because if the kexec image is corrupted the 
> machine will just get stuck in the purgatory and (unless it's a platform 
> where the purgatory can print to the console) without even an error message 
> explaining what is going on. Whereas if we notice the corruption before 
> jumping into the purgatory we can switch to a regular reboot and the machine 
> will boot successfully.
>
> To have an early failure, when would the checksum verification be done?
> What I can think of is to have kexec_file_load accept a new flag 
> KEXEC_FILE_VERIFY_IMAGE, which userspace could use to request an integrity 
> check when it's about to start the reboot procedure. Then it can decide to 
> either reload the kernel or use a regular reboot if the image is corrupted.
>
> Is this what you had in mind?

Sort of.

I was just thinking that instead of having the boot path verify your ima
list matches what is in the tpm and halting the boot there, we could
test that on reboot.  Which would give a clean failure without the nasty
poking into a prepared image.  The downside is that we have already run
the shutdown scripts so it wouldn't be much cleaner, than triggering a
machine reboot from elsewhere.

But I don't think we should spend too much time on that.  It was a
passing thought.  We should focus on getting a non-poked ima buffer
cleanly into kexec and we can worry about the rest later.

>> >> At least the common bootloader cases that I know of using kexec are
>> >> very
>> >> minimal distributions that live in a ramdisk and as such it should be
>> >> very straight forward to measure what is needed at or before
>> >> sys_kexec_load.  But that was completely dismissed as unrealistic so I
>> >> don't have a clue what actual problem you are trying to solve.
>> > 
>> > We are interested in solving the problem in a general way because it
>> > will be useful to us in the future for the case of an arbitrary number
>> > of kexecs (and thus not only a bootloader but also multiple full-blown
>> > distros may be involved in the chain).
>> > 
>> > But you are right that for the use case for which we currently need this
>> > feature it's feasible to measure everything upfront. We can cross the
>> > other bridge when we get there.
>> 
>> Then let's start there.  Passing the measurment list is something that
>> should not be controversial.
>
> Great!
>
>> >> If there is anyway we can start small and not with this big scary
>> >> infrastructure change I would very much prefer it.
>> > 
>> > Sounds good. If we pre-measure everything then the following patches
>> > from my buffer hand-over series are enough:
>> > 
>> > [PATCH v5 2/5] kexec_file: Add buffer hand-over support for the next
>> > kernel [PATCH v5 3/5] powerpc: kexec_file: Add buffer hand-over support
>> > for the next kernel
>> > 
>> > Would you consider including those two?
>> > 
>> > And like I mentioned in the cover letter, patch 1/5 is an interesting
>> > improvement that is worth considering.
>> 
>> So from 10,000 feet I think that is correct.
>> 
>> I am not quite certain why a new mechanism is being invented.  We have
>> other information that is already passed (much of it architecture
>> specific) like the flattened device tree.  If you remove the need to
>> update the information can you just append this information to the
>> flattened device tree without a new special mechanism to pass the data?
>> 
>> I am just reluctant to invent a new mechanism when there is an existing
>> mechanism that looks like it should work without problems.
>
> Michael Ellerman suggested putting the buffer contents inside the device 
> tree itself, but the s390 people are also planning to implement this 
> feature. That architecture doesn't use device trees, so a solution that 
> depends on DTs won't help them.
>
> With this mechanism each architecture will still need its own way of 
> communicating to the next kernel where the buffer is, but I think it's 
> easier to pass a base address and length than to pass a whole buffer.

A base address and length pair is fine.  There are several other pieces
of data that we pass that way.

> I suppose we could piggyback the ima measurements buffer at the end of one 
> of the other segments such as the kernel or, in the case of powerpc, the dtb 
> but it looks hackish to me. I think it's cleaner to put it in its own 
> segment.

The boot protocol unfortunately is different on different architectures,
and for each one we will have to implement and document the change.
Because when you get into boot protocol issues you can't assume the
kernel you are booting is the same version as the kernel that is booting
it.

Where I run into a problem is you added a semi-generic concept a
hand-over buffer.  Not a ima data buffer but a hand-over buffer.

The data falling in it's own dedicated area of memory and being added
with kexec_add_buffer is completely fine.  I can see a dedicated pointer
in struct kimage if necessary.

A semi-generic concept called a hand-over buffer seems to be a
construction of infrustructure for no actual reason that will just
result in confusion.  There are lots of things that are handed over, the
flattend device tree, ramdisks, bootparams on x86, etc, etc.  ima is not
special in this execpt for being perhaps the first addition that we are
going to want the option of including on most architectures.

Eric
