Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0B26B6F8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Aug 2011 21:59:06 +1000 (EST)
Message-ID: <4E412100.1020403@suse.de>
Date: Tue, 09 Aug 2011 13:58:56 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Make KVM_GUEST default to n
References: <20110805132358.086648e5@kryten>
In-Reply-To: <20110805132358.086648e5@kryten>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/05/2011 05:23 AM, Anton Blanchard wrote:
> KVM_GUEST adds a 1 MB array to the kernel (kvm_tmp) which grew
> my kernel enough to cause it to fail to boot.
>
> Dynamically allocating or reducing the size of this array is a
> good idea, but in the meantime I think it makes sense to make
> KVM_GUEST default to n in order to minimise surprises.
>
> Signed-off-by: Anton Blanchard<anton@samba.org>

Hrm - the idea was that the code is so little intrusive that it could 
simply always be enabled. But yeah, maybe this should be default n.

Ben, could you please pull this into your ppc tree for now? I don't 
think I'll manage to clean up my tree and send out a pull request before 
KVM Forum.


Alex

> ---
>
> Index: linux-powerpc/arch/powerpc/platforms/Kconfig
> ===================================================================
> --- linux-powerpc.orig/arch/powerpc/platforms/Kconfig	2011-08-01 17:33:46.120121554 +1000
> +++ linux-powerpc/arch/powerpc/platforms/Kconfig	2011-08-01 17:35:06.921772044 +1000
> @@ -24,7 +24,7 @@ source "arch/powerpc/platforms/wsp/Kconf
>
>   config KVM_GUEST
>   	bool "KVM Guest support"
> -	default y
> +	default n
>   	---help---
>   	  This option enables various optimizations for running under the KVM
>   	  hypervisor. Overhead for the kernel when not running inside KVM should
