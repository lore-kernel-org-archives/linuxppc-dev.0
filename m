Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A412BDDEEF
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2007 11:06:42 +1000 (EST)
Message-ID: <46086E19.4010609@am.sony.com>
Date: Mon, 26 Mar 2007 18:06:33 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 8/9] ps3: cleanup ps3fb before clearing HPTE
References: <4605B861.9060006@am.sony.com>
	<e1f83c095fc09e65524d4a8800c36120@bga.com>
In-Reply-To: <e1f83c095fc09e65524d4a8800c36120@bga.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:
> Paul, after reading this note I send a big fat
> 
> NACK
> 
> to this patch.

Sorry for not being more clear.  That was what I was kind of
saying, that there is something strange here, and I am looking
into it.

> On Mar 24, 2007, at 6:46 PM, Geoff Levand wrote:
> 
>> Christoph Hellwig wrote:
>>>>>  static void ps3_hpte_clear(void)
>>>>  {
>>>> +
>>>> +#ifdef CONFIG_FB_PS3
>>>> +    ps3fb_cleanup();
>>>> +#endif
>>>
>>> And well, adding framebuffer calls into the mmu code is rather fucked.
>>> This at least needs a big comment explaning the hypervisor braindamage
>>> that is responsible for this in colourfull language.
>>
>> Sorry for such a late reply, but I'm now doing the kexec code and see
>> why it was put here (by the original author).  It is so you will have
>> debugging output until the very last possible moment during a kexec
>> shutdown.
> 
> But that is REALLY to late for that.
> 
>> The real problem is really that this routine (and the corresponding 
>> ppc_md
>> variable) are inappropriately named.
> 
> Ok, this should be
> ppc_md.kexec_cleanup_nothing_but_static_data_bss_real_mode_cleanup()
> 
> 
>> In the general case all that is left
>> to do is to call ppc_md.hpte_clear_all, but for ps3 we also want to do 
>> the
>> framebuffer shutdown here, so something like this should be better:
>>
>> -static void ps3_hpte_clear(void)
>> +static void ps3_kexec_final(void)
>>
>> -       ppc_md.hpte_clear_all = ps3_hpte_clear;
>> +       ppc_md.hpte_clear_all = ps3_kexec_final;
>>
> 
> NACK.

Yes, I just wanted to report why this strange code was in ps3_hpte_clear,
since Christoph never did get an answer, and give my idea on what might
work.  This is not a solution, just a thought.  I haven't really got
into it enough to say what the best way would be.  Thanks for the
comments though.
 
> Oh, I just looked at your ps3 kexec hooks.  Your ps3_kexec_cpu_down 
> looks
> totally broken.  

Yes, disregard anything you find regarding kexec on ps3.  I'll post
some new stuff for review, hopefully sometime soon.

-Geoff
