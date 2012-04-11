Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 18FEBB7357
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2012 19:09:03 +1000 (EST)
Date: Wed, 11 Apr 2012 11:08:55 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] powerpc: Option FB_FSL_DIU is not really optional for
 mpc512x
Message-ID: <20120411110855.7473d324@wker>
In-Reply-To: <1333509300-27066-1-git-send-email-paul.gortmaker@windriver.com>
References: <1333509300-27066-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  3 Apr 2012 23:15:00 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> In powerpc randconfig builds, this keeps showing up:
> 
>   CC      arch/powerpc/platforms/512x/mpc512x_shared.o
> arch/powerpc/platforms/512x/mpc512x_shared.c:70:9: warning: 'enum fsl_diu_monitor_port' declared inside parameter list
> arch/powerpc/platforms/512x/mpc512x_shared.c:70:9: warning: its scope is only this definition or declaration, which is probably not what you want
> arch/powerpc/platforms/512x/mpc512x_shared.c:69:56: error: parameter 1 ('port') has incomplete type
> arch/powerpc/platforms/512x/mpc512x_shared.c:69:5: warning: function declaration isn't a prototype
> arch/powerpc/platforms/512x/mpc512x_shared.c:84:9: warning: 'enum fsl_diu_monitor_port' declared inside parameter list
> arch/powerpc/platforms/512x/mpc512x_shared.c:83:56: error: parameter 1 ('port') has incomplete type
> arch/powerpc/platforms/512x/mpc512x_shared.c:83:6: warning: function declaration isn't a prototype
> arch/powerpc/platforms/512x/mpc512x_shared.c:88:36: warning: 'enum fsl_diu_monitor_port' declared inside parameter list
> arch/powerpc/platforms/512x/mpc512x_shared.c:88:57: error: parameter 1 ('port') has incomplete type
> arch/powerpc/platforms/512x/mpc512x_shared.c:88:6: warning: function declaration isn't a prototype
> arch/powerpc/platforms/512x/mpc512x_shared.c:187:54: error: parameter 1 ('port') has incomplete type
> arch/powerpc/platforms/512x/mpc512x_shared.c:187:1: error: return type is an incomplete type
> arch/powerpc/platforms/512x/mpc512x_shared.c:187:1: warning: function declaration isn't a prototype
> arch/powerpc/platforms/512x/mpc512x_shared.c: In function 'mpc512x_valid_monitor_port':
> arch/powerpc/platforms/512x/mpc512x_shared.c:189:9: error: 'FSL_DIU_PORT_DVI' undeclared (first use in this function)
> arch/powerpc/platforms/512x/mpc512x_shared.c:189:9: note: each undeclared identifier is reported only once for each function it appears in
> arch/powerpc/platforms/512x/mpc512x_shared.c:189:2: warning: 'return' with a value, in function returning void
> make[2]: *** [arch/powerpc/platforms/512x/mpc512x_shared.o] Error 1
> 
> The reason is that mpc512x_shared.c has a couple token #ifdef
> on FB_FSL_DIU/FB_FSL_DIU_MODULE, but they don't come close to
> masking all the DIU dependencies, as the above fail shows.
> 
> Rather than sprinkle more pointless #ifdef in this file, just
> remove the existing two, and make FB_FSL_DIU part of the
> dependency.  The mpc512x_defconfig already has the line
> "CONFIG_FB_FSL_DIU=y" so this change should be zero impact
> on real world configs.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied, thanks.

Anatolij
