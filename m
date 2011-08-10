Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3D1FDB6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Aug 2011 00:59:03 +1000 (EST)
Message-ID: <4E429CAD.5050000@suse.de>
Date: Wed, 10 Aug 2011 16:58:53 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH] powerpc/kvm: fix build errors with older toolchains
References: <1312397755-15737-1-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1312397755-15737-1-git-send-email-nacc@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Avi Kivity <avi@redhat.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/03/2011 08:55 PM, Nishanth Aravamudan wrote:
> On a box with gcc 4.3.2, I see errors like:
>
> arch/powerpc/kvm/book3s_hv_rmhandlers.S:1254: Error: Unrecognized opcode: stxvd2x
> arch/powerpc/kvm/book3s_hv_rmhandlers.S:1316: Error: Unrecognized opcode: lxvd2x

Paul, mind to ack?


Alex

> Signed-off-by: Nishanth Aravamudan<nacc@us.ibm.com>
> ---
>   arch/powerpc/kvm/book3s_hv_rmhandlers.S |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index 6dd3358..de29501 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -1251,7 +1251,7 @@ BEGIN_FTR_SECTION
>   	reg = 0
>   	.rept	32
>   	li	r6,reg*16+VCPU_VSRS
> -	stxvd2x	reg,r6,r3
> +	STXVD2X(reg,r6,r3)
>   	reg = reg + 1
>   	.endr
>   FTR_SECTION_ELSE
> @@ -1313,7 +1313,7 @@ BEGIN_FTR_SECTION
>   	reg = 0
>   	.rept	32
>   	li	r7,reg*16+VCPU_VSRS
> -	lxvd2x	reg,r7,r4
> +	LXVD2X(reg,r7,r4)
>   	reg = reg + 1
>   	.endr
>   FTR_SECTION_ELSE
