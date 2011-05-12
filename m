Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1305152704-4864-8-git-send-email-nacc@us.ibm.com>
References: <1305152704-4864-1-git-send-email-nacc@us.ibm.com>
	<1305152704-4864-8-git-send-email-nacc@us.ibm.com>
Date: Thu, 12 May 2011 07:51:32 +0200
Message-ID: <BANLkTi=eL9uwvNSdEnY4S=k1kjSgH4Q5xg@mail.gmail.com>
Subject: Re: [PATCH 7/8] powerpc: use the newly added get_required_mask
	dma_map_ops hook
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>, Milton Miller <miltonm@bga.com>
Content-Type: text/plain; charset=UTF-8
Cc: cbe-oss-dev@lists.ozlabs.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Greg Kroah-Hartman <gregkh@suse.de>, Arnd Bergmann <arnd@arndb.de>,
	Geoff Levand <geoff@infradead.org>,
	Sean MacLennan <smaclennan@pikatech.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Will Schmidt <will_schmidt@vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 12, 2011 at 00:25, Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platf=
orms/ps3/system-bus.c
> index 23083c3..688141c 100644
> --- a/arch/powerpc/platforms/ps3/system-bus.c
> +++ b/arch/powerpc/platforms/ps3/system-bus.c
> @@ -695,12 +695,18 @@ static int ps3_dma_supported(struct device *_dev, u=
64 mask)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return mask >=3D DMA_BIT_MASK(32);
> =C2=A0}
>
> +static u64 ps3_dma_get_required_mask(struct device *_dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return DMA_BIT_MASK(32);

Why 32 and not 64?

> +}
> +
> =C2=A0static struct dma_map_ops ps3_sb_dma_ops =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.alloc_coherent =3D ps3_alloc_coherent,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.free_coherent =3D ps3_free_coherent,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.map_sg =3D ps3_sb_map_sg,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.unmap_sg =3D ps3_sb_unmap_sg,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.dma_supported =3D ps3_dma_supported,
> + =C2=A0 =C2=A0 =C2=A0 .get_required_mask =3D ps3_dma_get_required_mask,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.map_page =3D ps3_sb_map_page,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.unmap_page =3D ps3_unmap_page,
> =C2=A0};
> @@ -711,6 +717,7 @@ static struct dma_map_ops ps3_ioc0_dma_ops =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.map_sg =3D ps3_ioc0_map_sg,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.unmap_sg =3D ps3_ioc0_unmap_sg,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.dma_supported =3D ps3_dma_supported,
> + =C2=A0 =C2=A0 =C2=A0 .get_required_mask =3D ps3_dma_get_required_mask,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.map_page =3D ps3_ioc0_map_page,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.unmap_page =3D ps3_unmap_page,
> =C2=A0};

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
