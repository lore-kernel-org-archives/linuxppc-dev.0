Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3CF3D67B86
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 23:53:07 +1000 (EST)
In-Reply-To: <004c01c6aa68$6f580d00$99dfdfdf@bakuhatsu.net>
References: <004c01c6aa68$6f580d00$99dfdfdf@bakuhatsu.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E40C6B7A-F2E8-4DB8-97D3-2CFF88C1D90A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: AltiVec in the kernel
Date: Tue, 18 Jul 2006 08:53:18 -0500
To: matt@genesi-usa.com
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 18, 2006, at 7:48 AM, Matt Sealey wrote:

>
> Once upon a time we were all told this wouldn't work for some reason,
> but a lot of documentation now hints that it does actually work and
> for instance there is a RAID5/6 driver (for G5) which uses AltiVec
> in a kernel context.

Using Altivec generally in the kernel is still something that is not  
recommended.  The key to using it is in disabling preemption, this  
ensures that when the code is done the Altivec register state is back  
to how the kernel found it.

	preempt_disable();
	enable_kernel_altivec();

	raid6_altivec$#_gen_syndrome_real(disks, bytes, ptrs);

	preempt_enable();

> But I didn't find any definitive documentation on how one goes about
> it. The largest clue I found was in Documentation/cpu_features.txt:
>
> 	#ifdef CONFIG_ALTIVEC
> 	BEGIN_FTR_SECTION
> 		mfspr	r22,SPRN_VRSAVE		/* if G4, save vrsave register value */
> 		stw	r22,THREAD_VRSAVE(r23)
> 	END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
> 	#endif /* CONFIG_ALTIVEC */
>
> So we can use AltiVec by implementing this kind of wrapper around
> kernel functions which may use AltiVec?
>
> In the code above is there ANY significance of r22 and r23 other
> than that they are fairly high up and probably marked as "will
> be trashed" by all the relevant ABIs and so?

I'd guess those were the registers used by the code this was snipped  
from.

> Just curious, as I would like to investigate writing some docs at
> least on this (in article fashion) to go with PPCZone, Libfreevec
> and so on. I think there is a problem here in that simply developers
> who may be interested in doing this kind of optimized code do not
> know where to start (and we are thinking from a point of view of
> also teaching sessions too, like we did at FTF Frankfurt 2004, so
> after we teach them what AltiVec is etc. we demonstrate application
> AND kernel functionality and the quirks associated with it).

I'm pretty sure Paul looked into using AltiVec for memory operations  
in the kernel and didn't see a significant benefit to it.

- kumar
