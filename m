Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqByP3vZZzDqFV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 18:36:45 +1000 (AEST)
Date: Wed, 13 Jul 2016 16:36:32 +0800
From: Dave Young <dyoung@redhat.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Petr Tesarik <ptesarik@suse.cz>, linux-arm-kernel@lists.infradead.org,
 bhe@redhat.com, arnd@arndb.de, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, vgoyal@redhat.com
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160713083632.GA14038@dhcp-128-65.nay.redhat.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org> <50662781.Utjsnse3nb@hactar>
 <20160712225805.0d27fe5d@hananiah.suse.cz>
 <20160712221804.GV1041@n2100.armlinux.org.uk>
 <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160713073657.GX1041@n2100.armlinux.org.uk>
 <87poqinf9m.fsf@linux.vnet.ibm.com>
 <20160713082639.GZ1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160713082639.GZ1041@n2100.armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[snip]
> Now, going back to the more fundamental issue raised in my first reply,
> about the kernel command line.
> 
> On x86, I can see that it _is_ possible for userspace to specify a
> command line, and the kernel loading the image provides the command
> line to the to-be-kexeced kernel with very little checking.  So, if
> your kernel is signed, what stops the "insecure userspace" loading
> a signed kernel but giving it an insecure rootfs and/or console?

The kexec_file_load syscall was introduced for secure boot in the first
place. In case UEFI secure boot the signature verification chain only
covers kernel mode binaries. I think there is such problem in both normal
boot and kexec boot.

Thanks
Dave
