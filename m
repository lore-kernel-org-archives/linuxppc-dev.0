Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 2BB74B7E14
	for <linuxppc-dev@ozlabs.org>; Thu, 13 May 2010 21:47:48 +1000 (EST)
Message-ID: <4BEBE6D0.8020000@redhat.com>
Date: Thu, 13 May 2010 14:47:28 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
Subject: Re: [RFC][PATCH 0/12] KVM, x86, ppc, asm-generic: moving dirty bitmaps
	to user space
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
	<4BE7F6D7.3060005@redhat.com> <4BE7FB7B.5010600@oss.ntt.co.jp>
In-Reply-To: <4BE7FB7B.5010600@oss.ntt.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-arch@vger.kernel.org, x86@kernel.org, arnd@arndb.de,
	kvm@vger.kernel.org, kvm-ia64@vger.kernel.org,
	fernando@oss.ntt.co.jp, mtosatti@redhat.com, agraf@suse.de,
	kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, mingo@redhat.com, paulus@samba.org,
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

On 05/10/2010 03:26 PM, Takuya Yoshikawa wrote:
>> No doubt get.org -> get.opt is measurable, but get.opt->switch.opt is
>> problematic. Have you tried profiling to see where the time is spent
>> (well I can guess, clearing the write access from the sptes).
>
>
> Sorry but no, and I agree with your guess.
> Anyway, I want to do some profiling to confirm this guess.
>
>
> BTW, If we only think about performance improvement of time, optimized
> get(get.opt) may be enough at this stage.
>
> But if we consider the future expansion like using user allocated 
> bitmaps,
> new API's introduced for switch.opt won't become waste, I think, 
> because we
> need a structure to get and export bitmap addresses.

User allocated bitmaps have the advantage of reducing pinned memory.  
However we have plenty more pinned memory allocated in memory slots, so 
by itself, user allocated bitmaps don't justify this change.

Perhaps if we optimize memory slot write protection (I have some ideas 
about this) we can make the performance improvement more pronounced.

-- 
error compiling committee.c: too many arguments to function
