Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 50A89B7D91
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 02:00:46 +1000 (EST)
Message-ID: <4BE97F2A.5080900@suse.de>
Date: Tue, 11 May 2010 18:00:42 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
Subject: Re: [RFC][PATCH 7/12 not tested yet] PPC: introduce __set_bit() like
	function for bitmaps in user space
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
	<20100504220418.083929bc.takuya.yoshikawa@gmail.com>
In-Reply-To: <20100504220418.083929bc.takuya.yoshikawa@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, x86@kernel.org, arnd@arndb.de,
	kvm@vger.kernel.org, kvm-ia64@vger.kernel.org,
	fernando@oss.ntt.co.jp, mtosatti@redhat.com,
	linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
	yoshikawa.takuya@oss.ntt.co.jp, linuxppc-dev@ozlabs.org,
	mingo@redhat.com, paulus@samba.org, avi@redhat.com,
	hpa@zytor.com, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Takuya Yoshikawa wrote:
> During the work of KVM's dirty page logging optimization, we encountered
> the need of manipulating bitmaps in user space efficiantly. To achive this,
> we introduce a uaccess function for setting a bit in user space following
> Avi's suggestion.
>
>   KVM is now using dirty bitmaps for live-migration and VGA. Although we need
>   to update them from kernel side, copying them every time for updating the
>   dirty log is a big bottleneck. Especially, we tested that zero-copy bitmap
>   manipulation improves responses of GUI manipulations a lot.
>
> We also found one similar need in drivers/vhost/vhost.c in which the author
> implemented set_bit_to_user() locally using inefficient functions: see TODO
> at the top of that.
>
> Probably, this kind of need would be common for virtualization area.
>
> So we introduce a function set_bit_user_non_atomic().
>
> Signed-off-by: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
> Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
> CC: Alexander Graf <agraf@suse.de>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> ---
>  arch/powerpc/include/asm/uaccess.h |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 3a01ce8..f878326 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -321,6 +321,25 @@ do {								\
>  	__gu_err;						\
>  })
>  
> +static inline int set_bit_user_non_atomic(int nr, void __user *addr)
> +{
> +	u8 __user *p;
> +	u8 val;
> +
> +	p = (u8 __user *)((unsigned long)addr + nr / BITS_PER_BYTE);
>   

Does C do the + or the / first? Either way, I'd like to see brackets here :)


Alex
