Return-Path: <julian.calaby@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.226])
	by ozlabs.org (Postfix) with ESMTP id B3D4BDDF27
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 11:50:35 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so3087940rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 16:50:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <496A89A1.8050302@gmail.com>
References: <496A89A1.8050302@gmail.com>
Date: Tue, 20 Jan 2009 11:50:33 +1100
Message-ID: <646765f40901191650v5320f5e4tcc5fb7da0555ade1@mail.gmail.com>
Subject: Re: [PATCH] mb862xx: Restrict compliation of platform driver to PPC
From: Julian Calaby <julian.calaby@gmail.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matteo Fortini <m.fortini@selcomgroup.com>,
	Krzysztof Helt <krzysztof.h1@poczta.fm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ping?

Does anyone maintain this driver?

(akpm: Sorry for cc'ing you on this, I'm not sure who else to send it to)

On Mon, Jan 12, 2009 at 11:06, Julian Calaby <julian.calaby@gmail.com> wrote:
> mb862xx: Restrict compliation of platform driver to PPC
>
> The OpenFirmware part of this driver is uncompilable on SPARC due to it's dependance on several PPC specific functions.
>
> Restricting this to PPC to prevent these build errors.
>
> This was found using randconfig builds.
>
> Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
>
> ---
>
> A couple of notes:
>
> 1. After looking at the includes used by this driver, the OF part may not compile cleanly on PPC either as it doesn't appear to pull in the required headers for all the functions and constants it uses.
>
> 2. Also, this bug will *not* show up in allmodconfigs or allyesconfigs as the OF part of this driver is prevented from building when the PCI driver is built, and the PCI driver appears first.
>
> 3. This patch is over DaveM's sparc-2.6 git tree as of today.
>
> 4. I apologise for the massive cross-posting - I am not sure where exactly to send this patch.
>
> 5. Please note that I am not a member of any of these lists, so please keep me CC'd.
>
> Thanks,
>
> Julian Calaby
>
> ---
>  drivers/video/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 6372f8b..8f18169 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2111,6 +2111,7 @@ config FB_MB862XX_LIME
>        bool "Lime GDC"
>        depends on FB_MB862XX
>        depends on OF && !FB_MB862XX_PCI_GDC
> +       depends on PPC
>        select FB_FOREIGN_ENDIAN
>        select FB_LITTLE_ENDIAN
>        ---help---
>
>



-- 
Julian Calaby

Email: julian.calaby@gmail.com
.Plan: https://sites.google.com/site/juliancalaby/
