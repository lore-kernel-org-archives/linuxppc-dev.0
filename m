Return-Path: <xenidis@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 74F50B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 04:57:06 +1100 (EST)
Received: by dady9 with SMTP id y9so2127691dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2012 09:57:04 -0800 (PST)
Sender: Jimi Xenidis <xenidis@gmail.com>
Subject: Re: [PATCH] powerpc: icswx: fix race condition where threads do not
 get their ACOP register updated in time.
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <1330300068.20389.63.camel@pasglop>
Date: Mon, 27 Feb 2012 11:56:58 -0600
Message-Id: <A8E3F067-7E3B-419C-B070-26F629B95CF0@pobox.com>
References: <1329948466-325-1-git-send-email-jimix@pobox.com>
 <1330300068.20389.63.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 26, 2012, at 5:47 PM, Benjamin Herrenschmidt wrote:

>=20
>>=20
>> +	/*
>> +	 * We could be here because another thread has enabled acop
>> +	 * but the ACOP register has yet to be updated.
>> +	 *
>> +	 * This should have been taken care of by the IPI to sync all
>> +	 * the threads (see smp_call_function(sync_cop, mm, 1)), but
>> +	 * that could take forever if there are a significant amount
>> +	 * of threads.
>> +	 *
>> +	 * Given the number of threads on some of these systems,
>> +	 * perhaps this is the best way to sync ACOP rather than whack
>> +	 * every thread with an IPI.
>> +	 */
>=20
> This is actually pretty standard stuff... If it was me I would make it
> all lazy and avoid the IPI completely but it doesn't necessarily hurt
> that much.

I'm happy to get rid of the IPI completely if Anton (or someone else) =
agrees to test on his end.
If not, do you want me to reduce the comment?


> In any case the "recovery" is indeed needed and you should
> probably also remove the pr_debug, it's really just spam.

ack

>=20
>> +	if (acop_copro_type_bit(ct) && current->active_mm->context.acop) =
{
>=20
> Shouldn't that be "&" ? In fact, gcc would even warn so either make
> it acop_check_copro(acop, ct) or do a (x & y) !=3D 0

Ach!! nice catch!
-jx

>=20
> Cheers,
> Ben.
>=20
>> +		pr_debug("%s[%d]: Spurrious ACOP Fault, CT: %d, bit: =
0x%llx "
>> +			"SPR: 0x%lx, mm->acop: 0x%lx\n",
>> +			current->comm, current->pid,
>> +			ct, acop_copro_type_bit(ct), mfspr(SPRN_ACOP),
>> +			current->active_mm->context.acop);
>> +
>> +		sync_cop(current->active_mm);
>> +		return 0;
>> +	}
>> +
>> +	/* check for alternate policy */
>> 	if (!acop_use_cop(ct))
>> 		return 0;
>>=20
>> 	/* at this point the CT is unknown to the system */
>> -	pr_warn("%s[%d]: Coprocessor %d is unavailable",
>> +	pr_warn("%s[%d]: Coprocessor %d is unavailable\n",
>> 		current->comm, current->pid, ct);
>>=20
>> 	/* get inst if we don't already have it */
>> diff --git a/arch/powerpc/mm/icswx.h b/arch/powerpc/mm/icswx.h
>> index 42176bd..6dedc08 100644
>> --- a/arch/powerpc/mm/icswx.h
>> +++ b/arch/powerpc/mm/icswx.h
>> @@ -59,4 +59,10 @@ extern void free_cop_pid(int free_pid);
>>=20
>> extern int acop_handle_fault(struct pt_regs *regs, unsigned long =
address,
>> 			     unsigned long error_code);
>> +
>> +static inline u64 acop_copro_type_bit(unsigned int type)
>> +{
>> +	return 1ULL << (63 - type);
>> +}
>> +
>> #endif /* !_ARCH_POWERPC_MM_ICSWX_H_ */
>=20
>=20
