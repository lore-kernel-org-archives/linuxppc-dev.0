Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 71B5C1400AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 03:12:43 +1000 (EST)
Message-ID: <1398791552.24575.56.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/fsl-rio: Fix fsl_rio_setup error paths and
 use-after-unmap
From: Scott Wood <scottwood@freescale.com>
To: Liu Gang-B34182 <Gang.Liu@freescale.com>
Date: Tue, 29 Apr 2014 12:12:32 -0500
In-Reply-To: <dd70c20406d242b694b16e898cc2cddf@BY2PR03MB412.namprd03.prod.outlook.com>
References: <1398735103-16513-1-git-send-email-scottwood@freescale.com>
 <dd70c20406d242b694b16e898cc2cddf@BY2PR03MB412.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-04-28 at 23:04 -0500, Liu Gang-B34182 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, April 29, 2014 9:32 AM
> > To: linuxppc-dev@lists.ozlabs.org
> > Cc: Wood Scott-B07421; Liu Gang-B34182
> > Subject: [PATCH] powerpc/fsl-rio: Fix fsl_rio_setup error paths and use-
> > after-unmap
> > 
> > Several of the error paths from fsl_rio_setup are missing error messages.
> > 
> > Worse, fsl_rio_setup initializes several global pointers and does not
> > NULL them out after freeing/unmapping on error.  This caused
> > fsl_rio_mcheck_exception() to crash when accessing rio_regs_win which was
> > non-NULL but had been unmapped.
> > 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > Cc: Liu Gang <Gang.Liu@freescale.com>
> > ---
> > Liu Gang, are you sure all of these error conditions are fatal?  Why does
> > the rio driver fail if rmu is not present (e.g.  on t4240)?
> 
> Hi Scott, I think the errors you modified in the patch are serious and should
> be fixed. Thanks very much!
> And in fact, the rio driver can be used just for the submodule of the SRIO: RMU.
> It should be used with arch/powerpc/sysdev/fsl_rmu.c and there should have the
> RMU module.
> The fsl_rio.c implements some basic and needed works to support the RMU running well.

I don't quite follow -- is it expected that rio can work without rmu, or
not?  As is, fsl_rio_setup() will error out if it doesn't find an
fsl,srio-rmu-handle property.

> In addition, could you please help to apply the following patch:
> 
> http://patchwork.ozlabs.org/patch/337810/

Yes, I'll apply it when I do my next batch of patch applications.

-Scott
