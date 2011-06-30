Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C450B6F54
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jul 2011 09:13:24 +1000 (EST)
Subject: Re: [RFC PATCH 17/17] KVM: PPC: Add an ioctl for userspace to
	select which platform to emulate
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4E0C9339.2080601@redhat.com>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
	<20110629104103.GR25406@bloggs.ozlabs.ibm.com>
	<4E0C9077.2060608@suse.de> <4E0C9339.2080601@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Jul 2011 09:13:12 +1000
Message-ID: <1309475592.14501.211.camel@pasglop>
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
	kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Regarding that.  There's another option - the ioctl code embeds the 
> structure size.  So if we extend the ioctl parsing to pad up (or 
> truncate down) from the user's size to our size, and similarly in the 
> other direction, we can get away from this ugliness.

I don't like relying on that much ... I prefer having an explicit
version in the structure head (or use a flag).

> Some years ago I posted a generic helper that did this (and also 
> kmalloc'ed and kfree'd the data itself), but it wasn't received 
> favourably.  Maybe I should try again (and we can possibly use it in kvm 
> even if it is rejected for general use, though that's against our 
> principles of pushing all generic infrastructure to the wider kernel).

Cheers,
Ben.
