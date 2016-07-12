Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpz5Q3Fg2zDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 09:41:54 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6CNcxfh026501
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 19:41:52 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452asqw5q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 19:41:52 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 12 Jul 2016 17:41:52 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Petr Tesarik <ptesarik@suse.cz>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: bhe@redhat.com, arnd@arndb.de, dyoung@redhat.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 vgoyal@redhat.com, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <20160712225805.0d27fe5d@hananiah.suse.cz>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org> <50662781.Utjsnse3nb@hactar>
 <20160712225805.0d27fe5d@hananiah.suse.cz>
Date: Wed, 13 Jul 2016 09:41:39 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a8hmpgp8.fsf@linux.vnet.ibm.com>
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

In this case, the user is sitting at the (or one of the) console(s) of
the machine. There could be petitboot UIs running on the VGA display,
IPMI serial over lan, local serial port. The logic behind setting
/chosen/linux,stdout-path is (currently) mostly to set it for the kernel
to what the user is interacting with. i.e. if you select an OS installer
to boot from the VGA console, you get a graphical installer running and
if you selected it from a text console, you get a text installer running
(on the appropriate console).

So the bootloader (petitboot) needs to work out which console is being
interacted with in order to set up /chosen/linux,stdout-path correctly.

This specific option could be passed as a kernel command line to the
next kernel, yes. However, isn't the kernel command line also an attack
vector? Is *every* command line option safe?

> In general, tampering with the hardware inventory of a machine opens up
> a security hole, and one must be very cautious which modifications are
> allowed. You're giving this power to an (unsigned, hence untrusted)
> userspace application; Eric argues that only the kernel should have
> this power.

In the case of petitboot on OpenPOWER, this (will) be a signed and
trusted kernel and userspace and verified by a previous bit of firmware.

-- 
Stewart Smith
OPAL Architect, IBM.
