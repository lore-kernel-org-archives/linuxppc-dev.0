Return-Path: <SRS0=+ktb=TT=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id A1253DDE35
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 22:33:09 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [POWERPC] 40X: Add Default Restart Machdep Method to 40X
	Platforms
Date: Sat, 1 Mar 2008 12:32:54 +0100
References: <C3E49AAC.D8E4%erick205@umn.edu>
In-Reply-To: <C3E49AAC.D8E4%erick205@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803011232.54392.sr@denx.de>
Cc: Grant Erickson <erick205@umn.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 23 February 2008, Grant Erickson wrote:
> This patch restores the reset on restart functionality to 40x-based
> platforms that was formerly provided--but not used in arch/powerpc--by
> abort() in head_40x.S. This functionality is now provided by
> ppc40x_reset_system(char *) in a fashion similar to that of the 44x-based
> platforms.
>
> Compiled, linked and tested against the AMCC Haleakala board.

Instead of duplicating this code in platform/40x/ which is already present in 
platforms/44x/misc_44x.S, why not move this misc_44x.S code into a common 
place for all 4xx (40x and 44x) PPC's? There seems to be nothing 44x 
specific.

I suggest to introduce platforms/4xx/misc.S or sysdev/ppc4xx_misc.S with these 
functions and change the code referencing it accordingly.

Comments/thoughts?

Best regards,
Stefan
