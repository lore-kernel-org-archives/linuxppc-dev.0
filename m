Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EE2C767A79
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 09:38:37 +1000 (EST)
In-Reply-To: <7cb1293c0605181456p3c1726e2n56942dfbd4217f70@mail.gmail.com>
References: <7cb1293c0605181456p3c1726e2n56942dfbd4217f70@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DACD852C-7C2C-47DD-A02C-D7EE3720C37D@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PPC host with a PCI root-complex
Date: Fri, 19 May 2006 01:38:25 +0200
To: "Srinivas Murthy" <codevana@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> We have a ppc host with a PCI root-complex across which there are  
> multiple PCI end points.
>
> An application running on the ppc host reading one of the device  
> memory regions (not DMA access but direct CPU read) causes a parity  
> error on the PCI interface controller.
>
> We think that the error should be propagated up as a machine-check  
> which is considered a non-recoverable system-wide error. However  
> with multiple PCI devices present we think that this is too generic  
> and could be reduced to be a critical-error which could be  
> recovered from.
>
> Are there any other approaches/thoughts keeping in mind that this  
> is PPC host and we're running a PCI-rootcomplex interface?

You can handle the machine check in a platform-specific way --
see ppc_md.machine_check_exception().


Segher
