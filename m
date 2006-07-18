Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17597.7594.554879.945280@cargo.ozlabs.ibm.com>
Date: Wed, 19 Jul 2006 03:43:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: matt@genesi-usa.com
Subject: Re: AltiVec in the kernel
In-Reply-To: <004c01c6aa68$6f580d00$99dfdfdf@bakuhatsu.net>
References: <004c01c6aa68$6f580d00$99dfdfdf@bakuhatsu.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey writes:

> Once upon a time we were all told this wouldn't work for some reason,
> but a lot of documentation now hints that it does actually work and
> for instance there is a RAID5/6 driver (for G5) which uses AltiVec
> in a kernel context.

It's possible, with some restrictions, basically the same restrictions
on using floating point in the kernel.

Kernel use of altivec interacts with the lazy altivec context switch
that we do on UP kernels, and the fact that the kernel context switch
doesn't save/restore the altivec state.  That means that before using
altivec in the kernel you may have to save away the altivec state, and
you have to make sure you don't sleep or get preempted while using
altivec.

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

No, that's irrelevant; that just has to do with the VRSAVE register,
not the altivec state.  In fact VRSAVE isn't actually even part of the
altivec state.

> In the code above is there ANY significance of r22 and r23 other
> than that they are fairly high up and probably marked as "will
> be trashed" by all the relevant ABIs and so?

I hope we do a bit better than "probably" ... :)  No, there is no
particular significance to the choice of r22 and r23.  If you read the
code you will see that those registers are saved at the beginning of
the context switch routine and restored (from the new process's stack)
at the end.

Paul.
