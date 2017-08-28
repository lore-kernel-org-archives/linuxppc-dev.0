Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgqN40fL0zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 21:31:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Al Viro <viro@ZenIV.linux.org.uk>, Paul Mackerras <paulus@ozlabs.org>
Cc: Nixiaoming <nixiaoming@huawei.com>, David Hildenbrand <david@redhat.com>,
 "agraf\@suse.com" <agraf@suse.com>,
 "pbonzini\@redhat.com" <pbonzini@redhat.com>,
 "rkrcmar\@redhat.com" <rkrcmar@redhat.com>,
 "benh\@kernel.crashing.org" <benh@kernel.crashing.org>,
 "kvm-ppc\@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] fix memory leak on kvm_vm_ioctl_create_spapr_tce
In-Reply-To: <20170828052808.GH5426@ZenIV.linux.org.uk>
References: <20170822142823.69425-1-nixiaoming@huawei.com>
 <95fe182a-fd21-77a1-33df-0e609c2845fd@redhat.com>
 <8fd9a878-a8ce-5576-9a5c-1c221ff6ded7@redhat.com>
 <E490CD805F7529488761C40FD9D26EF1299B4667@DGGEMA505-MBX.china.huawei.com>
 <20170823060624.GA13958@fergus.ozlabs.ibm.com>
 <20170827210220.GG5426@ZenIV.linux.org.uk>
 <20170828043837.GA12629@fergus.ozlabs.ibm.com>
 <20170828052808.GH5426@ZenIV.linux.org.uk>
Date: Mon, 28 Aug 2017 21:31:15 +1000
Message-ID: <87h8wsudx8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Al Viro <viro@ZenIV.linux.org.uk> writes:

> On Mon, Aug 28, 2017 at 02:38:37PM +1000, Paul Mackerras wrote:
>> On Sun, Aug 27, 2017 at 10:02:20PM +0100, Al Viro wrote:
>> > On Wed, Aug 23, 2017 at 04:06:24PM +1000, Paul Mackerras wrote:
>> > 
>> > > It seems to me that it would be better to do the anon_inode_getfd()
>> > > call before the kvm_get_kvm() call, and go to the fail label if it
>> > > fails.
>> > 
>> > And what happens if another thread does close() on the (guessed) fd?
>> 
>> Chaos ensues, but mostly because we don't have proper mutual exclusion
>> on the modifications to the list.  I'll add a mutex_lock/unlock to
>> kvm_spapr_tce_release() and move the anon_inode_getfd() call inside
>> the mutex.
>> 
>> It looks like the other possible uses of the fd (mmap, and passing it
>> as a parameter to the KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE ioctl on a KVM
>> device fd) are safe.
>
> Frankly, it's a lot saner to have "no failure points past anon_inode_getfd()"
> policy...

Actually I thought that was a hard rule. But I don't see it documented
or mentioned anywhere so I'm not sure now why I thought that.

cheers
