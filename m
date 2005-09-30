Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <20051001000001.1f1d8c48.sfr@canb.auug.org.au>
References: <20050930233602.138b6e27.sfr@canb.auug.org.au>
	<20051001000001.1f1d8c48.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <52E29A49-AAF2-4E61-AAB2-CD02ABCBE447@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 30 Sep 2005 15:52:40 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 6/9] powerpc: merge idle_power4.S and fixup traps.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(My first attempt at posting to the list failed due to size)

I really dont like the ideal of splitting up traps.c into traps32.c  
and traps64.c.  This defeats the purpose of the merge.  I expect that  
a significant portion of traps.c is common (or can be made to be)  
between all powerpc's.

- kumar


On Sep 30, 2005, at 9:00 AM, Stephen Rothwell wrote:

> Use idle_power4.S from ppc64 as we are not going to support
> 32 bit power4 in the merged tree.
>
> create traps{32,64}.c as these are hard to merge.
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>
>  arch/powerpc/Kconfig              |    4
>  arch/powerpc/kernel/Makefile      |    4
>  arch/powerpc/kernel/idle_power4.S |   78 +++
>  arch/powerpc/kernel/traps.c       | 1047
> -------------------------------------
>  arch/powerpc/kernel/traps32.c     | 1047
> +++++++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/traps64.c     |  568 ++++++++++++++++++++
>  arch/ppc64/kernel/Makefile        |   10
>  arch/ppc64/kernel/idle_power4.S   |   79 ---
>  arch/ppc64/kernel/traps.c         |  568 --------------------
>  9 files changed, 1707 insertions(+), 1698 deletions(-)
>  create mode 100644 arch/powerpc/kernel/idle_power4.S
>  delete mode 100644 arch/powerpc/kernel/traps.c
>  create mode 100644 arch/powerpc/kernel/traps32.c
>  create mode 100644 arch/powerpc/kernel/traps64.c
>  delete mode 100644 arch/ppc64/kernel/idle_power4.S
>  delete mode 100644 arch/ppc64/kernel/traps.c
>
