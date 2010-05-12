Return-Path: <yoshikawa.takuya@oss.ntt.co.jp>
Received: from serv2.oss.ntt.co.jp (serv2.oss.ntt.co.jp [222.151.198.100])
	by ozlabs.org (Postfix) with ESMTP id EC17DB6EFF
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 15:59:54 +1000 (EST)
Message-ID: <4BEA44B8.7050409@oss.ntt.co.jp>
Date: Wed, 12 May 2010 15:03:36 +0900
From: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
MIME-Version: 1.0
To: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC][PATCH 11/12] KVM: introduce new API for getting/switching
	dirty bitmaps
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
	<20100504220821.d68bde57.takuya.yoshikawa@gmail.com>
	<20100511034329.GB3458@amt.cnet> <4BE8F0F2.60706@oss.ntt.co.jp>
	<20100511140712.GA7063@amt.cnet>
In-Reply-To: <20100511140712.GA7063@amt.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, kvm@vger.kernel.org,
	kvm-ia64@vger.kernel.org, fernando@oss.ntt.co.jp, x86@kernel.org,
	agraf@suse.de, kvm-ppc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	mingo@redhat.com, paulus@samba.org, avi@redhat.com,
	hpa@zytor.com, tglx@linutronix.de,
	Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>>> One alternative would be:
>>>
>>> KVM_SWITCH_DIRTY_LOG passing the address of a bitmap. If the active
>>> bitmap was clean, it returns 0, no switch performed. If the active
>>> bitmap was dirty, the kernel switches to the new bitmap and returns 1.
>>>
>>> And the responsability of cleaning the new bitmap could also be left
>>> for userspace.
>>>
>>
>> That is a beautiful approach but we can do that only when we give up using
>> GET api.
>>
>>
>> I follow you and Avi's advice about that kind of maintenance policy!
>> What do you think?
>
> If you introduce a switch ioctl that frees the bitmap vmalloc'ed by the
> current set_memory_region (if its not freed already), after pointing the
> memslot to the user supplied one, it should be fine?
>

You mean switching from vmalloc'ed(not do_mmap'ed) one to user supplied one?

It may be possible but makes things really complicated in my view:
until some point we use set_bit, and then use set_bit_user, etc.

IMO:
  - # of slots is limited and the size of dirty_bitmap_old pointer is not problematic.
  - Both user side and kernel side need not allocate buffers every time and once
    paired buffers are registered, we will reuse the buffers until user side orders
    to stop logging.
  - We have a tiny advantage if we need not copy_from_user to get a bitmap address
    for switch ioctl.

  => So I think having two __user bitmaps is not a bad thing.
