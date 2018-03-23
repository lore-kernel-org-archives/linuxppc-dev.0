Return-Path: <diana.craciun@nxp.com>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20064.outbound.protection.outlook.com [40.107.2.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4077Xj5m2VzF0W1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2018 02:59:58 +1100 (AEDT)
From: Diana Madalina Craciun <diana.craciun@nxp.com>
To: Michal Suchanek <msuchanek@suse.de>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: Kate Stewart <kstewart@linuxfoundation.org>, Madhavan Srinivasan
 <maddy@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Paul Mackerras <paulus@samba.org>, Michael
 Neuling <mikey@neuling.org>, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Daniel Axtens
 <dja@axtens.net>, Nicholas Piggin <npiggin@gmail.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Sergey Senozhatsky
 <sergey.senozhatsky@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Joe Perches <joe@perches.com>, Oliver O'Halloran
 <oohall@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Tobin C.
 Harding" <me@tobin.cc>
Subject: Re: [PATCH RFC rebase 9/9] powerpc/64: barrier_nospec: Add
 commandline trigger
Date: Fri, 23 Mar 2018 15:59:50 +0000
Message-ID: <HE1PR0401MB2634FE1189DA2E7B8C405FECFFA80@HE1PR0401MB2634.eurprd04.prod.outlook.com>
References: <cover.1521141122.git.msuchanek@suse.de>
 <1dcf7403042daddcdb8109f6b852b9bb9d768f89.1521141122.git.msuchanek@suse.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/15/2018 9:34 PM, Michal Suchanek wrote:=0A=
> Add commandline options spectre_v2 and nospectre_v2=0A=
>=0A=
> These are named same as similar x86 options regardless of actual effect=
=0A=
> to not require platform-specific configuration.=0A=
>=0A=
> Supported options:=0A=
> nospectre_v2 or spectre_v2=3Doff - speculation barrier not used=0A=
> spectre_v2=3Don or spectre_v2=3Dauto - speculation barrier used=0A=
=0A=
Why the barrier is enabled only for spectre variant 2 mitigations? It=0A=
can be used as well for variant 1 mitigations. In fact I am not sure=0A=
that the places where it is used fall under spectre 2 at all.=0A=
=0A=
>=0A=
> Changing the settings after boot is not supported and VM migration may=0A=
> change requirements so auto is same as on.=0A=
>=0A=
> Based on s390 implementation=0A=
>=0A=
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>=0A=
> ---=0A=
>  arch/powerpc/kernel/setup_64.c | 22 ++++++++++++++++++++++=0A=
>  1 file changed, 22 insertions(+)=0A=
>=0A=
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_6=
4.c=0A=
> index f6678a7b6114..c74e656265df 100644=0A=
> --- a/arch/powerpc/kernel/setup_64.c=0A=
> +++ b/arch/powerpc/kernel/setup_64.c=0A=
> @@ -840,6 +840,28 @@ static int __init handle_no_pti(char *p)=0A=
>  }=0A=
>  early_param("nopti", handle_no_pti);=0A=
>  =0A=
> +static int __init nospectre_v2_setup_early(char *str)=0A=
> +{=0A=
> +	no_nospec =3D true;=0A=
> +	return 0;=0A=
> +}=0A=
> +early_param("nospectre_v2", nospectre_v2_setup_early);=0A=
> +=0A=
> +static int __init spectre_v2_setup_early(char *str)=0A=
> +{=0A=
> +	if (str && !strncmp(str, "on", 2))=0A=
> +		no_nospec =3D false;=0A=
> +=0A=
> +	if (str && !strncmp(str, "off", 3))=0A=
> +		no_nospec =3D true;=0A=
> +=0A=
> +	if (str && !strncmp(str, "auto", 4))=0A=
> +		no_nospec =3D false;=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +early_param("spectre_v2", spectre_v2_setup_early);=0A=
> +=0A=
>  static void do_nothing(void *unused)=0A=
>  {=0A=
>  	/*=0A=
=0A=
Thanks,=0A=
=0A=
Diana=0A=
=0A=
