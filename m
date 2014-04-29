Return-Path: <Gang.Liu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B1F92140088
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 14:04:16 +1000 (EST)
From: "Gang.Liu@freescale.com" <Gang.Liu@freescale.com>
To: Scott Wood <scottwood@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] powerpc/fsl-rio: Fix fsl_rio_setup error paths and
 use-after-unmap
Date: Tue, 29 Apr 2014 04:04:09 +0000
Message-ID: <dd70c20406d242b694b16e898cc2cddf@BY2PR03MB412.namprd03.prod.outlook.com>
References: <1398735103-16513-1-git-send-email-scottwood@freescale.com>
In-Reply-To: <1398735103-16513-1-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, April 29, 2014 9:32 AM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: Wood Scott-B07421; Liu Gang-B34182
> Subject: [PATCH] powerpc/fsl-rio: Fix fsl_rio_setup error paths and use-
> after-unmap
>=20
> Several of the error paths from fsl_rio_setup are missing error messages.
>=20
> Worse, fsl_rio_setup initializes several global pointers and does not
> NULL them out after freeing/unmapping on error.  This caused
> fsl_rio_mcheck_exception() to crash when accessing rio_regs_win which was
> non-NULL but had been unmapped.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Cc: Liu Gang <Gang.Liu@freescale.com>
> ---
> Liu Gang, are you sure all of these error conditions are fatal?  Why does
> the rio driver fail if rmu is not present (e.g.  on t4240)?

Hi Scott, I think the errors you modified in the patch are serious and shou=
ld
be fixed. Thanks very much!
And in fact, the rio driver can be used just for the submodule of the SRIO:=
 RMU.
It should be used with arch/powerpc/sysdev/fsl_rmu.c and there should have =
the
RMU module.
The fsl_rio.c implements some basic and needed works to support the RMU run=
ning well.

In addition, could you please help to apply the following patch:

http://patchwork.ozlabs.org/patch/337810/

Thanks!
Liu Gang  =20
> ---
>  arch/powerpc/sysdev/fsl_rio.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
