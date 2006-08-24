Return-Path: <bcook@bpointsys.com>
Received: from bpointsys.com (70-253-197-251.ded.swbell.net [70.253.197.251])
	by ozlabs.org (Postfix) with ESMTP id EAB0167B6E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 00:18:32 +1000 (EST)
From: Brent Cook <bcook@bpointsys.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: atomic operations in user space
Date: Thu, 24 Aug 2006 09:18:19 -0500
References: <4879B0C6C249214CBE7AB04453F84E4D0FC380@zch01exm20.fsl.freescale.net>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D0FC380@zch01exm20.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="Boundary-00=_rUb7EovZRvIftD5"
Message-Id: <200608240918.19450.bcook@bpointsys.com>
Cc: Terry Liang <tliang@brocade.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_rUb7EovZRvIftD5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Thursday 24 August 2006 05:39, Li Yang-r58472 wrote:
> Why do you need atomic operations in user land?  IPC will be sufficient
> to deal with race conditions between processes.
>
> Best Regards,
> Leo

What about multiple threads within a process updating a counter?

Of course, if you look at these functions in the kernel header, they're just 2 or 3 inline assembly calls - you could easily rewrite them. Google for 'PowerPC atomic increment' and grab one of the unencumbered implementations if you need to use it in a non-GPL program.

On the other hand, I see no license at the top of my /usr/include/asm-i386/atomic.h file at all, same for PowerPC - are Linux header files actually GPL or are they more like the glibc headers, with exceptions made for userspace programs?

The atomic operations on x86 were accidentally exported early on, so they have to hang around apparently for compatibility (there are some mailing list threads out there to this effect.) Currently, you just have to assume in Linux that if you include something from /usr/include/linux or asm that it will not necessarily be cross-version or cross-architecture compatible. Not every arch in Linux even has atomic operations of this nature, which I guess is the main reason why they are not exported in general.

 - Brent

> > -----Original Message-----
> > From: linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.org
> > [mailto:linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.org] On
>
> Behalf Of
>
> > Terry Liang
> > Sent: Thursday, August 24, 2006 3:04 AM
> > To: linuxppc-embedded@ozlabs.org
> > Subject: atomic operations in user space
> >
> > Thanks. Arnd. My main concern is whether the operations are really
>
> atomic as they
>
> > are in the kernel space. I have read some discussion in another forum
>
> that on other
>
> > platforms, even if you are able to compile the atomic_add(),
>
> atomic_set(), etc.
>
> > from an user space application,  they don't guarantee to be atomic.
>
> Thanks.
>
> > Regards,
> >
> > Terry Liang
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

--Boundary-00=_rUb7EovZRvIftD5
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

<html><head><meta name="qrichtext" content="1" /></head><body style="font-size:8pt;font-family:Bitstream Vera Sans Mono">
<p>On Thursday 24 August 2006 05:39, Li Yang-r58472 wrote:</p>
<p>&gt; Why do you need atomic operations in user land?  IPC will be sufficient</p>
<p>&gt; to deal with race conditions between processes.</p>
<p>&gt;</p>
<p>&gt; Best Regards,</p>
<p>&gt; Leo</p>
<p></p>
<p>What about multiple threads within a process updating a counter?</p>
<p></p>
<p>Of course, if you look at these functions in the kernel header, they're just 2 or 3 inline assembly calls - you could easily rewrite them. Google for 'PowerPC atomic increment' and grab one of the unencumbered implementations if you need to use it in a non-GPL program.</p>
<p></p>
<p>On the other hand, I see no license at the top of my /usr/include/asm-i386/atomic.h file at all, same for PowerPC - are Linux header files actually GPL or are they more like the glibc headers, with exceptions made for userspace programs?</p>
<p></p>
<p>The atomic operations on x86 were accidentally exported early on, so they have to hang around apparently for compatibility (there are some mailing list threads out there to this effect.) Currently, you just have to assume in Linux that if you include something from /usr/include/linux or asm that it will not necessarily be cross-version or cross-architecture compatible. Not every arch in Linux even has atomic operations of this nature, which I guess is the main reason why they are not exported in general.</p>
<p></p>
<p> - Brent</p>
<p></p>
<p>&gt; &gt; -----Original Message-----</p>
<p>&gt; &gt; From: linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.org</p>
<p>&gt; &gt; [mailto:linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.org] On</p>
<p>&gt;</p>
<p>&gt; Behalf Of</p>
<p>&gt;</p>
<p>&gt; &gt; Terry Liang</p>
<p>&gt; &gt; Sent: Thursday, August 24, 2006 3:04 AM</p>
<p>&gt; &gt; To: linuxppc-embedded@ozlabs.org</p>
<p>&gt; &gt; Subject: atomic operations in user space</p>
<p>&gt; &gt;</p>
<p>&gt; &gt; Thanks. Arnd. My main concern is whether the operations are really</p>
<p>&gt;</p>
<p>&gt; atomic as they</p>
<p>&gt;</p>
<p>&gt; &gt; are in the kernel space. I have read some discussion in another forum</p>
<p>&gt;</p>
<p>&gt; that on other</p>
<p>&gt;</p>
<p>&gt; &gt; platforms, even if you are able to compile the atomic_add(),</p>
<p>&gt;</p>
<p>&gt; atomic_set(), etc.</p>
<p>&gt;</p>
<p>&gt; &gt; from an user space application,  they don't guarantee to be atomic.</p>
<p>&gt;</p>
<p>&gt; Thanks.</p>
<p>&gt;</p>
<p>&gt; &gt; Regards,</p>
<p>&gt; &gt;</p>
<p>&gt; &gt; Terry Liang</p>
<p>&gt;</p>
<p>&gt; _______________________________________________</p>
<p>&gt; Linuxppc-embedded mailing list</p>
<p>&gt; Linuxppc-embedded@ozlabs.org</p>
<p>&gt; https://ozlabs.org/mailman/listinfo/linuxppc-embedded</p>
<p></p>
</body></html>
--Boundary-00=_rUb7EovZRvIftD5--
