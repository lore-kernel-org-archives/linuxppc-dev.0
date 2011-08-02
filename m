Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71A61B71CD
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Aug 2011 22:20:35 +1000 (EST)
Message-ID: <4E37EB8C.8040408@suse.de>
Date: Tue, 02 Aug 2011 14:20:28 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/3] KVM: PPC: Assemble book3s{,
	_hv}_rmhandlers.S separately
References: <20110723074111.GA17927@bloggs.ozlabs.ibm.com>
In-Reply-To: <20110723074111.GA17927@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2011 09:41 AM, Paul Mackerras wrote:
> This makes arch/powerpc/kvm/book3s_rmhandlers.S and
> arch/powerpc/kvm/book3s_hv_rmhandlers.S be assembled as
> separate compilation units rather than having them #included in
> arch/powerpc/kernel/exceptions-64s.S.  We no longer have any
> conditional branches between the exception prologs in
> exceptions-64s.S and the KVM handlers, so there is no need to
> keep their contents close together in the vmlinux image.
>
> In their current location, they are using up part of the limited
> space between the first-level interrupt handlers and the firmware
> NMI data area at offset 0x7000, and with some kernel configurations
> this area will overflow (e.g. allyesconfig), leading to an
> "attempt to .org backwards" error when compiling exceptions-64s.S.
>
> Moving them out requires that we add some #includes that the
> book3s_{,hv_}rmhandlers.S code was previously getting implicitly
> via exceptions-64s.S.

So what if your kernel binary is bigger than the 24 bits we can jump and 
the KVM code happens to be at the end? Or do we just not care here?


Alex
