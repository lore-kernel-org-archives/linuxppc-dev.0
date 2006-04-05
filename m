Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A4C5C67A40
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Apr 2006 00:28:32 +1000 (EST)
In-Reply-To: <11442138494042-git-send-email-sfr@canb.auug.org.au>
References: <11442138494042-git-send-email-sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C40B1083-7953-4104-8FA3-5B9B4EBE1A77@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 00/15] powerpc: move some header files
Date: Wed, 5 Apr 2006 09:28:55 -0500
To: sfr@canb.auug.org.au
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 5, 2006, at 12:10 AM, sfr@canb.auug.org.au wrote:

> This patch set moves sufficient include files from include/asm-ppc
> to include/asm-powerpc to allow us to remove the include hack in the
> arch/powerpc/Makefile.
>
>  b/arch/powerpc/Makefile           |   21 ++------------
>  b/include/asm-powerpc/amigappc.h  |    9 ++----
>  b/include/asm-powerpc/bootinfo.h  |    8 ++---
>  b/include/asm-powerpc/highmem.h   |   11 +++----
>  b/include/asm-powerpc/hydra.h     |    8 ++---
>  b/include/asm-powerpc/mpc83xx.h   |    7 ++--
>  b/include/asm-powerpc/mpc85xx.h   |    9 ++----
>  b/include/asm-powerpc/mpc8xx.h    |   10 +++---
>  b/include/asm-powerpc/ocp.h       |    7 ++--
>  b/include/asm-powerpc/ocp_ids.h   |    6 ++--
>  b/include/asm-powerpc/open_pic.h  |   10 +++---
>  b/include/asm-powerpc/pnp.h       |    8 ++---
>  b/include/asm-powerpc/reg_booke.h |   55 ++++++++++++++++++ 
> +-------------------
>  b/include/asm-powerpc/residual.h  |    6 ++--
>  b/include/asm-powerpc/suspend.h   |   17 +++++++++++
>  include/asm-ppc/suspend.h         |   12 --------
>  16 files changed, 95 insertions(+), 109 deletions(-)

How about we do the following to remove the include hack:

don't move the following (determine what needs them to build and  
fixup, I dont believe any of these need to exist at this point in  
arch/powerpc for it to build any supported arch/powerpc platform:

  b/include/asm-powerpc/amigappc.h  |    9 ++----
  b/include/asm-powerpc/bootinfo.h  |    8 ++---
  b/include/asm-powerpc/mpc8xx.h    |   10 +++---
  b/include/asm-powerpc/ocp.h       |    7 ++--
  b/include/asm-powerpc/ocp_ids.h   |    6 ++--
  b/include/asm-powerpc/open_pic.h  |   10 +++---

Duplicate these headers (then I'll go through and clean them up,  
removing arch/ppc'ism):

  b/include/asm-powerpc/mpc83xx.h   |    7 ++--
  b/include/asm-powerpc/mpc85xx.h   |    9 ++----

- kumar
