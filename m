Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181]) by ozlabs.org (Postfix) with ESMTP id 0FC6FB7D66
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 13:33:09 +1100 (EST)
Received: by ywh11 with SMTP id 11so162345ywh.9
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 18:33:08 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1265377377-29327-3-git-send-email-agust@denx.de>
References: <1265377377-29327-1-git-send-email-agust@denx.de>
	<1265377377-29327-3-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 19:32:47 -0700
Message-ID: <fa686aa41002091832y671c3cci4125b1923d535876@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] powerpc/mpc5121: Add machine restart support
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 5, 2010 at 6:42 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Add reset module registers representation and
> machine restart callback for mpc5121 platform.
>
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>
> ---
> Changes since v2:
> =A0- call mpc512x_restart_init() explicitely from platform
> =A0 init code
>
> Changes since v1:
> =A0- use 'struct mpc512x_reset_module *' type for 'reset_module_base'
> =A0- remove empty line
> =A0- remove leftover colon and use pr_err() instead of printk.
>
> =A0arch/powerpc/include/asm/mpc5xxx.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 14 +++=
++++++-
> =A0arch/powerpc/platforms/512x/mpc5121_ads.c =A0 =A0 | =A0 =A01 +
> =A0arch/powerpc/platforms/512x/mpc5121_generic.c | =A0 =A01 +
> =A0arch/powerpc/platforms/512x/mpc512x.h =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/powerpc/platforms/512x/mpc512x_shared.c =A0| =A0 34 +++++++++++++=
++++++++++++
> =A05 files changed, 50 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mpc5xxx.h b/arch/powerpc/include/as=
m/mpc5xxx.h
> index 5ce9c5f..0004986 100644
> --- a/arch/powerpc/include/asm/mpc5xxx.h
> +++ b/arch/powerpc/include/asm/mpc5xxx.h
> @@ -18,5 +18,17 @@
>
> =A0extern unsigned long mpc5xxx_get_bus_frequency(struct device_node *nod=
e);
>
> -#endif /* __ASM_POWERPC_MPC5xxx_H__ */
> +/* MPC512x Reset module registers */
> +struct mpc512x_reset_module {
> + =A0 =A0 =A0 u32 =A0 =A0 rcwlr; =A0/* Reset Configuration Word Low Regis=
ter */
> + =A0 =A0 =A0 u32 =A0 =A0 rcwhr; =A0/* Reset Configuration Word High Regi=
ster */
> + =A0 =A0 =A0 u32 =A0 =A0 reserved1;
> + =A0 =A0 =A0 u32 =A0 =A0 reserved2;
> + =A0 =A0 =A0 u32 =A0 =A0 rsr; =A0 =A0/* Reset Status Register */
> + =A0 =A0 =A0 u32 =A0 =A0 rmr; =A0 =A0/* Reset Mode Register */
> + =A0 =A0 =A0 u32 =A0 =A0 rpr; =A0 =A0/* Reset Protection Register */
> + =A0 =A0 =A0 u32 =A0 =A0 rcr; =A0 =A0/* Reset Control Register */
> + =A0 =A0 =A0 u32 =A0 =A0 rcer; =A0 /* Reset Control Enable Register */
> +};

This isn't useful for 5200.  Create a new file.
arch/powerpc/include/asm/mpc5121.h

g.
