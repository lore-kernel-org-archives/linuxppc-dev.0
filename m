Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 0171FB7D5B
	for <linuxppc-dev@ozlabs.org>; Mon, 10 May 2010 22:01:33 +1000 (EST)
Message-ID: <4BE7F58C.50006@redhat.com>
Date: Mon, 10 May 2010 15:01:16 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
Subject: Re: [RFC][PATCH resend 8/12] asm-generic: bitops: introduce le bit
	offset macro
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
	<4BE04677.4060608@redhat.com>
	<20100505115924.7bb92036.takuya.yoshikawa@gmail.com>
	<201005061538.54326.arnd@arndb.de> <4BE7F22E.9070504@oss.ntt.co.jp>
In-Reply-To: <4BE7F22E.9070504@oss.ntt.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-arch@vger.kernel.org, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
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

On 05/10/2010 02:46 PM, Takuya Yoshikawa wrote:
> (2010/05/06 22:38), Arnd Bergmann wrote:
>> On Wednesday 05 May 2010, Takuya Yoshikawa wrote:
>>> Date:
>>> Yesterday 04:59:24
>>>> That's why the bitmaps are defined as little endian u64 aligned, 
>>>> even on
>>>> big endian 32-bit systems.  Little endian bitmaps are wordsize 
>>>> agnostic,
>>>> and u64 alignment ensures we can use long-sized bitops on mixed size
>>>> systems.
>>
>> Ok, I see.
>>
>>> There was a suggestion to propose set_le_bit_user() kind of macros.
>>> But what I thought was these have a constraint you two explained and 
>>> seemed to be
>>> a little bit specific to some area, like KVM.
>>>
>>> So I decided to propose just the offset calculation macro.
>>
>> I'm not sure I understand how this macro is going to be used though.
>> If you are just using this in kernel space, that's fine, please go for
>> it.
>
> Yes, I'm just using in kernel space: qemu has its own endian related 
> helpers.
>
> So if you allow us to place this macro in asm-generic/bitops/* it will 
> help us.
>
> Avi, what do you think? Do you want to place it in kvm.h ?

I really prefer anything that is generic to be outside kvm, even if kvm 
is the only user.

-- 
error compiling committee.c: too many arguments to function
