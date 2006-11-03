Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id E110B67C9C
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 04:47:27 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so428897ugf
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Nov 2006 09:47:26 -0800 (PST)
Message-ID: <528646bc0611030947l259bb266p32d7df9dd2223c8f@mail.gmail.com>
Date: Fri, 3 Nov 2006 10:47:26 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "M Ptich" <ptich@hotmail.com>
Subject: Re: Clear OS / HAL separation
In-Reply-To: <BAY102-F362BE9713459EAE9EED9FAA9FE0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <528646bc0611022215qad62c3br4642dfb40d9db8c1@mail.gmail.com>
	<BAY102-F362BE9713459EAE9EED9FAA9FE0@phx.gbl>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/3/06, M Ptich <ptich@hotmail.com> wrote:
> Hi Grant,
>
> Thanks a lot for your kind reply. What I meant is inordinate amount of
> sometimes ifdefs, sometimes call redirection (like ppc_md), pretty messy.
> But it is mostly in already machine-dependent code, so does not count as bad
> separation, you're right.
>
> But I am wondering about your remark that "there is separation between
> bootloader and
> kernel responsibilities". I think that on PPC Kernel depends very little on
> the bootloader - bootloader just needs to set up 5 input parameters (one of
> them is a pointer to initialized bd_t), and have initial Kernel TLB with
> IPROT=1. That's it, all the devices (including internal CPU stuff) are
> initialized in the Kernel. Am I correct ?

If you're looking in arch/ppc, you are 100% correct.  If you are
looking in arch/powerpc, which is where new development is occuring, a
device tree is used to pass information about available devices to the
kernel.  Also, your boot loader *should* (but you don't need to do it
this way) setup your SOC configuration (gpio, etc).  By doing it this
way, the device tree can encapsulate most of the differences between
different boards using the same processor (or SOC).  Board specific
code is kept to a minimum; or in some cases is non-existent.
Everything you need can be covered by device drivers and processor
specific code.

However, unless you've got real openfirmware, it is still just a
handoff from the bootloader to the kernel.  Once the kernel is booted,
it won't make any calls back to the bootloader.

Cheers,
g.

BTW, please make sure you include the mailing list when replying

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
