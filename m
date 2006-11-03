Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 1D0D167B9F
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 17:15:54 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so301026ugf
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Nov 2006 22:15:53 -0800 (PST)
Message-ID: <528646bc0611022215qad62c3br4642dfb40d9db8c1@mail.gmail.com>
Date: Thu, 2 Nov 2006 23:15:53 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "M Ptich" <ptich@hotmail.com>
Subject: Re: Clear OS / HAL separation
In-Reply-To: <BAY102-F21F34507B25D8615CACD06A9FE0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <BAY102-F21F34507B25D8615CACD06A9FE0@phx.gbl>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/2/06, M Ptich <ptich@hotmail.com> wrote:
> I am porting 2.6 kernel from Freescale onto our PPC platform. This is my
> first experience with Linux, and I was unpleasantly surprised how poorly OS
> and platform code are separated.  So I have a question: is there a project
> underway, somewhere, that is trying to separate OS and HAL (or Board Support
> Package) for the next Linux kernel ?

Can you elaborate on what you mean?  From my perspective there is
quite well defined separation between the kernel proper, the device
drivers, and the board setup code.

However, there is no stable kernel API for you to program against, and
this is by design.  For details, read the following file in the kernel
source tree:  Documentation/stable_api_nonsense.txt

Now, all that being said, there is separation between bootloader and
kernel responsibilities that is currently evolving.  Linux 32 bit PPC
support is slowly being migrated from the arch/ppc directory into
arch/powerpc where it is merging with 64 bit ppc support.  The
arch/powerpc tree also uses a device tree (binary data structure) to
pass board configuration information from the bootloader to the
kernel.  The bootloader is responsible for initializing the board (ie.
SDRAM and certain devices).  Since the device tree informs the kernel
what devices are present, most of the kernel code can be generic and
the kernel will only setup device drivers for devices that are
actually present.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
