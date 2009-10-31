Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 18AB01007D3
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 23:02:21 +1100 (EST)
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
	<1256917647-6200-20-git-send-email-agraf@suse.de>
	<20091031153719.10a4e61b.sfr@canb.auug.org.au>
Message-Id: <4A927295-575F-4AF2-AA7E-D83CBAC6C343@suse.de>
From: Alexander Graf <agraf@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20091031153719.10a4e61b.sfr@canb.auug.org.au>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 7A341)
Subject: Re: [PATCH 19/27] Export symbols for KVM module
Date: Sat, 31 Oct 2009 13:02:14 +0100
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, kvm-ppc <kvm-ppc@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Avi Kivity <avi@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"bphilips@suse.de" <bphilips@suse.de>, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Am 31.10.2009 um 05:37 schrieb Stephen Rothwell <sfr@canb.auug.org.au>:

> Hi Alexander,
>
> On Fri, 30 Oct 2009 16:47:19 +0100 Alexander Graf <agraf@suse.de>  
> wrote:
>>
>> diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ 
>> ppc_ksyms.c
>> index c8b27bb..baf778c 100644
>> --- a/arch/powerpc/kernel/ppc_ksyms.c
>> +++ b/arch/powerpc/kernel/ppc_ksyms.c
>> @@ -163,11 +163,12 @@ EXPORT_SYMBOL(screen_info);
>> #ifdef CONFIG_PPC32
>> EXPORT_SYMBOL(timer_interrupt);
>> EXPORT_SYMBOL(irq_desc);
>> -EXPORT_SYMBOL(tb_ticks_per_jiffy);
>> EXPORT_SYMBOL(cacheable_memcpy);
>> EXPORT_SYMBOL(cacheable_memzero);
>> #endif
>>
>> +EXPORT_SYMBOL(tb_ticks_per_jiffy);
>
> Since you are moving this anyway, how about moving it into
> arch/powerpc/kernel/time.c where tb_ticks_per_jiffy is defined.

Well the fun part is that the hrtimer conversion patch actually  
deprecates this change.

I merely forgot to change the export back.

So I suppose I'll leave things here as is and then revert this chunk  
in the hrtimer patch.

Alex
