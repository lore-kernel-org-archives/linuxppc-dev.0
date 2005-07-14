Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id C993D67C3B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 17:21:42 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j6E7RY9l000033
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 10:27:35 +0300 (EEST)
Message-ID: <42D6110C.1090309@intracom.gr>
Date: Thu, 14 Jul 2005 10:15:24 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: ming lei <mlei30@yahoo.com>
References: <20050714015703.34280.qmail@web61015.mail.yahoo.com>
In-Reply-To: <20050714015703.34280.qmail@web61015.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: double kernel page table entry for the same physical page?!
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ming lei wrote:
> Dan,
> 
> No one intents to make memory corruption in kernel
> space but it happens sometimes.
> 
> Say I have a global var in my kernel module which
> called test-mod, it picks up a physical page allocated
> by some code with  kmalloc and later kfreed(suppose
> when it does, the whole page gets freed). But then
> this code forgets a pointer(which maped to this
> physical page) already freed and modifies the pointer,
> the write gets thru since that virt address's PTE
> still valid and points to the physical page currently
> used by test-mod. So the memory corruption happens.
> 
> Maybe I miss something in the linux kernel code that
> prevents this double PTE thing.
> 
> Ming
> 

If you want to guard against stuff like this you have
some options...

1) Run different services on the same cpu on a a hypervisor
   like Xen.

2) Run most of the module's code in user space, and keep
   kernel space code to a minimum.

3) Use QNX.

Regards

Pantelis
