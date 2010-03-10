Return-Path: <jeremy@goop.org>
Received: from claw.goop.org (claw.goop.org [74.207.240.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.goop.org", Issuer "Goop.org CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2317DB7D13
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 05:33:43 +1100 (EST)
Message-ID: <4B97E4A7.6060501@goop.org>
Date: Wed, 10 Mar 2010 10:27:51 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] irq: move some interrupt arch_* functions into struct
	irq_chip.
References: <1268218524.11737.68547.camel@zakaz.uk.xensource.com>	<1268218559-26784-2-git-send-email-ijc@hellion.org.uk>	<86802c441003100406t70dd854fx491f0ee9a6fce62b@mail.gmail.com>	<1268225473.11737.69196.camel@zakaz.uk.xensource.com>
	<m1iq94gjkf.fsf@fess.ebiederm.org>
In-Reply-To: <m1iq94gjkf.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Ian Campbell <Ian.Campbell@citrix.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/10/2010 09:42 AM, Eric W. Biederman wrote:
> All we need between the Xen and the rest of x86 is a convention
> so that we never manage the same irqs.   At least for domU we are
> in an either/or situation so I don't see even that being a problem.
>    

Dom0 too.  This is part of the work implementing what we discussed a 
while back - Xen now completely owns the local and IO apics, so dom0 
only deals with Xen, not the hardware.  Xen has a completely different 
interrupt setup path, but at least it isn't a mishmash of Xen stuff and 
native APIC stuff.

     J
