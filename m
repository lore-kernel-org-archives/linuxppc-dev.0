Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 47F751007D2
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Nov 2009 08:17:49 +1100 (EST)
Message-ID: <4AECAA0A.1080304@suse.de>
Date: Sat, 31 Oct 2009 22:20:10 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 20/27] Split init_new_context and destroy_context
References: <1256917647-6200-1-git-send-email-agraf@suse.de>	<1256917647-6200-21-git-send-email-agraf@suse.de>
	<20091031154059.750d7213.sfr@canb.auug.org.au>
In-Reply-To: <20091031154059.750d7213.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org,
	bphilips@suse.de, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Hi Alexander,
>
> On Fri, 30 Oct 2009 16:47:20 +0100 Alexander Graf <agraf@suse.de> wrote:
>   
>> --- a/arch/powerpc/include/asm/mmu_context.h
>> +++ b/arch/powerpc/include/asm/mmu_context.h
>> @@ -23,6 +23,11 @@ extern void switch_slb(struct task_struct *tsk, struct mm_struct *mm);
>>  extern void set_context(unsigned long id, pgd_t *pgd);
>>  
>>  #ifdef CONFIG_PPC_BOOK3S_64
>> +extern int __init_new_context(void);
>> +extern void __destroy_context(int context_id);
>> +#endif
>> +
>> +#ifdef CONFIG_PPC_BOOK3S_64
>>     
>
> don't add the #endif/#ifdef pair ...

Any other comments? I'd like to wind up a final patch set so I can stop
spamming on all those MLs :-).

Alex
