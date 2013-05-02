Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 939432C00D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2013 21:17:47 +1000 (EST)
Subject: Re: [PATCH -next] kvm/ppc/mpic: fix missing unlock in set_base_addr()
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <CAPgLHd9S4JbRpB9ipzDyysWqAkismVMu2W=Z2mhuVHzJXv4NrQ@mail.gmail.com>
Date: Thu, 2 May 2013 13:17:37 +0200
Message-Id: <59415357-8C42-4269-91F4-33AB69C35B93@suse.de>
References: <CAPgLHd9S4JbRpB9ipzDyysWqAkismVMu2W=Z2mhuVHzJXv4NrQ@mail.gmail.com>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: kvm@vger.kernel.org, gleb@redhat.com, mtosatti@redhat.com,
 kvm-ppc@vger.kernel.org, yongjun_wei@trendmicro.com.cn, paulus@samba.org,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 02.05.2013, at 07:17, Wei Yongjun wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Add the missing unlock before return from function set_base_addr()
> when disables the mapping.
>=20
> Introduced by commit 5df554ad5b7522ea62b0ff9d5be35183494efc21
> (kvm/ppc/mpic: in-kernel MPIC emulation)
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks, applied to kvm-ppc-queue.


Alex

> ---
> arch/powerpc/kvm/mpic.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
> index f3148f8..0047a70 100644
> --- a/arch/powerpc/kvm/mpic.c
> +++ b/arch/powerpc/kvm/mpic.c
> @@ -1475,8 +1475,8 @@ static int set_base_addr(struct openpic *opp, =
struct kvm_device_attr *attr)
>=20
> 	map_mmio(opp);
>=20
> -	mutex_unlock(&opp->kvm->slots_lock);
> out:
> +	mutex_unlock(&opp->kvm->slots_lock);
> 	return 0;
> }
>=20
>=20
