Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpzBF55MXzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 09:46:13 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6CNe7ie146531
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 19:45:36 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24566wewbw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 19:45:36 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 12 Jul 2016 19:45:35 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vivek Goyal <vgoyal@redhat.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: bhe@redhat.com, arnd@arndb.de, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, dyoung@redhat.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <20160712140242.GA30181@redhat.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org> <2675986.6AfrV5PCe0@hactar>
 <20160712140242.GA30181@redhat.com>
Date: Wed, 13 Jul 2016 09:45:22 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877fcqpgj1.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vivek Goyal <vgoyal@redhat.com> writes:
> On Tue, Jul 12, 2016 at 10:58:09AM -0300, Thiago Jung Bauermann wrote:
>> Hello Eric,
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
>> > 
>> > What x86 does is pass it's equivalent of the device tree blob from one
>> > kernel to another directly and behind the scenes.  It does not go
>> > through userspace for this.
>> > 
>> > Until a persuasive case can be made for going around the kernel and
>> > probably adding a feature (like code execution) that can be used to
>> > defeat the signature scheme I am going to nack this.
>> 
>> There are situations where userspace needs to change things in the device 
>> tree to be used by the next kernel.
>> 
>> For example, Petitboot (the boot loader used in OpenPOWER machines) is a 
>> userspace application running in an intermediary Linux instance and uses 
>> kexec to load the target OS. It has to modify the device tree that will be 
>> used by the next kernel so that the next kernel uses the same console that 
>> petitboot was configured to use (i.e., set the /chosen/linux,stdout-path 
>> property). It also modifies the device tree to allow the kernel to inherit 
>> Petitboot's Openfirmware framebuffer.
>
> Can some of this be done with the help of kernel command line options for
> second kernel?

how would this be any more secure?

Passing in an address for a framebuffer via command line option means
you could scribble over any bit of memory, which is the same kind of
damage you could do by modifying the device tree.

-- 
Stewart Smith
OPAL Architect, IBM.
