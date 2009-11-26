Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 68ACD1007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 08:56:15 +1100 (EST)
References: <1259249056-3953-1-git-send-email-agraf@suse.de>
Message-Id: <37C1770E-4657-413A-9A40-A0C04FE2D055@suse.de>
From: Alexander Graf <agraf@suse.de>
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <1259249056-3953-1-git-send-email-agraf@suse.de>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 7A341)
Subject: Re: [PATCH] PPC: Sync guest visible MMU state
Date: Thu, 26 Nov 2009 22:56:11 +0100
Cc: kvm-ppc <kvm-ppc@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Am 26.11.2009 um 16:24 schrieb Alexander Graf <agraf@suse.de>:

> Currently userspace has no chance to find out which virtual address  
> space we're
> in and resolve addresses. While that is a big problem for migration,  
> it's also
> unpleasent when debugging, as gdb and the monitor don't work on  
> virtual
> addresses.
>
> This patch exports enough of the MMU segment state to userspace to  
> make
> debugging work and thus also includes the groundwork for migration.
>
> Signed-off-by: Alexander Graf <agraf@suse.de>
>
> ---
>
> Ben, please take this patch in your tree.
>
> v2 -> v3:
>
>  - don't use anonymous unions/structs
> ---
> arch/powerpc/include/asm/kvm.h        |   20 +++++++++++-
> arch/powerpc/include/asm/kvm_asm.h |    1 +
> arch/powerpc/include/asm/kvm_book3s.h |    3 ++
> arch/powerpc/kvm/book3s.c             |   53 ++++++++++++++++++++++++ 
> +++++++-
> arch/powerpc/kvm/book3s_64_emulate.c  |   38 ++++++++++++++---------
> arch/powerpc/kvm/book3s_64_mmu.c |    2 +
> arch/powerpc/kvm/powerpc.c            |    3 ++
> include/linux/kvm.h                   |    3 ++
> 8 files changed, 104 insertions(+), 19 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/kvm.h b/arch/powerpc/include/ 
> asm/kvm.h
> index c9ca97f..cb6ad08 100644
> --- a/arch/powerpc/include/asm/kvm.h
> +++ b/arch/powerpc/include/asm/kvm.h
> @@ -46,8 +46,24 @@ struct kvm_regs {
> };
>
> struct kvm_sregs {
> -    __u32 pvr;
> -    char pad[1020];
> +    union {
> +        struct {
> +            __u32 pvr;

Meh this breaks old userspace. Better patch following tomorrow.
