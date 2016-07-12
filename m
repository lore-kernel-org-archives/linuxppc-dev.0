Return-Path: <ebiederm@xmission.com>
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpwGn6Y8MzDqLG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 07:34:57 +1000 (AEST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Petr Tesarik <ptesarik@suse.cz>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, bhe@redhat.com,
 arnd@arndb.de, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 linux-arm-kernel@lists.infradead.org, dyoung@redhat.com, vgoyal@redhat.com
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org> <50662781.Utjsnse3nb@hactar>
 <20160712225805.0d27fe5d@hananiah.suse.cz>
Date: Tue, 12 Jul 2016 16:22:07 -0500
In-Reply-To: <20160712225805.0d27fe5d@hananiah.suse.cz> (Petr Tesarik's
 message of "Tue, 12 Jul 2016 22:58:05 +0200")
Message-ID: <87a8hm1ri8.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC 0/3] extend kexec_file_load system call
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Petr Tesarik <ptesarik@suse.cz> writes:

> On Tue, 12 Jul 2016 13:25:11 -0300
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> wrote:
>
>> Hi Eric,
>> 
>> I'm trying to understand your concerns leading to your nack. I hope you 
>> don't mind expanding your thoughts on them a bit.
>> 
>> Am Dienstag, 12 Juli 2016, 08:25:48 schrieb Eric W. Biederman:
>> > AKASHI Takahiro <takahiro.akashi@linaro.org> writes:
>> > > Device tree blob must be passed to a second kernel on DTB-capable
>> > > archs, like powerpc and arm64, but the current kernel interface
>> > > lacks this support.
>> > > 
>> > > This patch extends kexec_file_load system call by adding an extra
>> > > argument to this syscall so that an arbitrary number of file descriptors
>> > > can be handed out from user space to the kernel.
>> > > 
>> > > See the background [1].
>> > > 
>> > > Please note that the new interface looks quite similar to the current
>> > > system call, but that it won't always mean that it provides the "binary
>> > > compatibility."
>> > > 
>> > > [1] http://lists.infradead.org/pipermail/kexec/2016-June/016276.html
>> > 
>> > So this design is wrong.  The kernel already has the device tree blob,
>> > you should not be extracting it from the kernel munging it, and then
>> > reinserting it in the kernel if you want signatures and everything to
>> > pass.
>> 
>> I don't understand how the kernel signature will be invalidated. 
>> 
>> There are some types of boot images that can embed a device tree blob in 
>> them, but the kernel can also be handed a separate device tree blob from 
>> firmware, the boot loader, or kexec. This latter case is what we are 
>> discussing, so we are not talking about modifying an embedded blob in the 
>> kernel image.
>> 
>> > What x86 does is pass it's equivalent of the device tree blob from one
>> > kernel to another directly and behind the scenes.  It does not go
>> > through userspace for this.
>> > 
>> > Until a persuasive case can be made for going around the kernel and
>> > probably adding a feature (like code execution) that can be used to
>> > defeat the signature scheme I am going to nack this.
>> 
>> I also don't understand what you mean by code execution. How does passing a 
>> device tree blob via kexec enables code execution? How can the signature 
>> scheme be defeated?
>
> I'm not an expert on DTB, so I can't provide an example of code
> execution, but you have already mentioned the /chosen/linux,stdout-path
> property. If an attacker redirects the bootloader to an insecure
> console, they may get access to the system that would otherwise be
> impossible.
>
> In general, tampering with the hardware inventory of a machine opens up
> a security hole, and one must be very cautious which modifications are
> allowed. You're giving this power to an (unsigned, hence untrusted)
> userspace application; Eric argues that only the kernel should have
> this power.

At the very least it should be signed.  And of course the more signed
images we have in different combinations the more easily someone can
find a combination that does things the people performing the signing
didn't realizing they were allowing.

So if we can not add an extra variable into the mix it would be good.

Eric
