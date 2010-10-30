Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 06CE9B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 31 Oct 2010 06:17:09 +1100 (EST)
Subject: Re: [PATCH v2] powerpc: kvm: powerpc: fix information leak to userland
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1288464922-8812-1-git-send-email-segooon@gmail.com>
Date: Sat, 30 Oct 2010 12:16:57 -0700
Message-Id: <1480CDBF-0A4A-49EC-AF4C-CED1D63BB911@suse.de>
References: <1288464922-8812-1-git-send-email-segooon@gmail.com>
To: Vasiliy Kulikov <segooon@gmail.com>
Cc: kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Avi Kivity <avi@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 30.10.2010, at 11:55, Vasiliy Kulikov wrote:

> Structure kvm_ppc_pvinfo is copied to userland with "flags" and "pad"
> fields unitialized.  It leads to leaking of contents of kernel stack
> memory.  We have to initialize them to zero.
>=20
> In patch v1 Jan Kiszka suggested to fill reserved fields with zeros
> instead of memset'ting the whole struct.  It makes sense as these
> fields are explicitly marked as padding.  No more fields need zeroing.
>=20
> Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
> ---
> arch/powerpc/kvm/powerpc.c |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 2f87a16..5962336 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -604,6 +604,8 @@ static int kvm_vm_ioctl_get_pvinfo(struct =
kvm_ppc_pvinfo *pvinfo)
> 	pvinfo->hcall[1] =3D inst_ori | (KVM_SC_MAGIC_R0 & =
inst_imm_mask);
> 	pvinfo->hcall[2] =3D inst_sc;
> 	pvinfo->hcall[3] =3D inst_nop;
> +	pvinfo->flags =3D 0;
> +	memset(&pvinfo->pad, 0, sizeof(pvinfo->pad));

This should only be memset(pvinfo->pad), no? It's an array after all =
which automatically translates to a pointer when referenced.

Alex
