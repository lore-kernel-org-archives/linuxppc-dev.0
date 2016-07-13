Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqB3B5vbQzDqFP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:55:50 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D7sn2C111562
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 03:55:48 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452at3tnx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 03:55:48 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 01:55:47 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Petr Tesarik <ptesarik@suse.cz>, linux-arm-kernel@lists.infradead.org,
 bhe@redhat.com, arnd@arndb.de, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, dyoung@redhat.com,
 vgoyal@redhat.com
Subject: Re: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <20160713073657.GX1041@n2100.armlinux.org.uk>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org> <50662781.Utjsnse3nb@hactar>
 <20160712225805.0d27fe5d@hananiah.suse.cz>
 <20160712221804.GV1041@n2100.armlinux.org.uk>
 <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160713073657.GX1041@n2100.armlinux.org.uk>
Date: Wed, 13 Jul 2016 17:55:33 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87poqinf9m.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Russell King - ARM Linux <linux@armlinux.org.uk> writes:
> On Wed, Jul 13, 2016 at 02:59:51PM +1000, Stewart Smith wrote:
>> Russell King - ARM Linux <linux@armlinux.org.uk> writes:
>> > On Tue, Jul 12, 2016 at 10:58:05PM +0200, Petr Tesarik wrote:
>> >> I'm not an expert on DTB, so I can't provide an example of code
>> >> execution, but you have already mentioned the /chosen/linux,stdout-path
>> >> property. If an attacker redirects the bootloader to an insecure
>> >> console, they may get access to the system that would otherwise be
>> >> impossible.
>> >
>> > I fail to see how kexec connects with the boot loader - the DTB image
>> > that's being talked about is one which is passed from the currently
>> > running kernel to the to-be-kexec'd kernel.  For ARM (and I suspect
>> > also ARM64) that's a direct call chain which doesn't involve any
>> > boot loader or firmware, and certainly none that would involve the
>> > passed DTB image.
>> 
>> For OpenPOWER machines, kexec is the bootloader. Our bootloader is a
>> linux kernel and initramfs with a UI (petitboot) - this means we never
>> have to write a device driver twice: write a kernel one and you're done
>> (for booting from the device and using it in your OS).
>
> I think you misunderstood my point.
>
> On ARM, we do not go:
>
> 	kernel (kexec'd from) -> boot loader -> kernel (kexec'd to)
>
> but we go:
>
> 	kernel (kexec'd from) -> kernel (kexec'd to)
>
> There's no intermediate step involving any bootloader.
>
> Hence, my point is that the dtb loaded by kexec is _only_ used by the
> kernel which is being kexec'd to, not by the bootloader, nor indeed
> the kernel which it is loaded into.
>
> Moreover, if you read the bit that I quoted (which is what I was
> replying to), you'll notice that it is talking about the DTB loaded
> by kexec somehow causing the _bootloader_ to be redirected to an
> alternative console.  This point is wholely false on ARM.

Ahh.. I missed the bootloader bit there.

In which case, we're the same on OpenPOWER, there is no intermediate
bootloader - in our case we have linux (with kexec) taking on what uboot
or grub is typically used for on other platforms.


-- 
Stewart Smith
OPAL Architect, IBM.
