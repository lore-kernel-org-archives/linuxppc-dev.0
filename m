Return-Path: <d-nishimura@mtf.biglobe.ne.jp>
Received: from rcpt-mqugw.biglobe.ne.jp (rcpt-mqugw.biglobe.ne.jp
	[133.205.19.70]) by ozlabs.org (Postfix) with ESMTP id 51C4EB7BFA
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 14:55:55 +1100 (EST)
Received: from rcpt-expgw.biglobe.ne.jp
	by rcpt-mqugw.biglobe.ne.jp (shby/1111021009) with ESMTP id
	o2F3EG3d006519
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 12:14:16 +0900
Date: Mon, 15 Mar 2010 12:16:51 +0900
From: Daisuke Nishimura <d-nishimura@mtf.biglobe.ne.jp>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [BUGFIX][PATCH] memcg: avoid use cmpxchg in swap cgroup
	maintainance (Was Re: 34-rc1-git3 build failure with
	CGROUP_MEM_RES_CTLR_SWAP=y
Message-Id: <20100315121651.23daf53f.d-nishimura@mtf.biglobe.ne.jp>
In-Reply-To: <20100315100202.eb735f59.kamezawa.hiroyu@jp.fujitsu.com>
References: <4B9CBEE6.1090509@in.ibm.com>
	<20100315100202.eb735f59.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: d-nishimura@mtf.biglobe.ne.jp,
	Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>,
	lizf@cn.fujitsu.com, linux-kernel <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
Reply-To: nishimura@mxp.nes.nec.co.jp
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 15 Mar 2010 10:02:02 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> On Sun, 14 Mar 2010 16:18:06 +0530
> Sachin Sant <sachinp@in.ibm.com> wrote:
> 
> > On a PowerPC box, latest 34-rc1 git(d89b218b8...) fails to build
> > with CGROUPS_MEM_RES_CTRL_SWAP=y. 
> > 
> > LD      init/built-in.o
> > LD      .tmp_vmlinux1
> > mm/built-in.o: In function __xchg:
> > arch/powerpc/include/asm/system.h:331: undefined reference to .__xchg_called_with_bad_pointer
> > mm/built-in.o: In function __cmpxchg:
> > arch/powerpc/include/asm/system.h:474: undefined reference to .__cmpxchg_called_with_bad_pointer
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > The code in question was added via commit 024914477e...
> > 
> > memcg: move charges of anonymous swap
> > 
> Oh..ok, powerpc (and other archs?) can't do 2byte cmpxchg and xchg.
> Then, we should use spinlock rather than that.
> 
> How about this ? Nishimura-san, could you consider something better ?
> We need a quick fix.
> 
Thank you for fixing this issue.
I think it increases the size of swap_cgroup_ctrl a bit,
but I think it's a good fix.

> ==
> swap_cgroup uses 2bytes data and uses cmpxchg in a new operation.
> 2byte cmpxchg/xchg is not available on some archs. This patch replaces
> cmpxchg/xchg with operations under lock.
> 
> Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Acked-by: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>

Thanks,
Daisuke Nishimura.
> ---
>  mm/page_cgroup.c |   20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> Index: mmotm-2.6.34-Mar11/mm/page_cgroup.c
> ===================================================================
> --- mmotm-2.6.34-Mar11.orig/mm/page_cgroup.c
> +++ mmotm-2.6.34-Mar11/mm/page_cgroup.c
> @@ -284,6 +284,7 @@ static DEFINE_MUTEX(swap_cgroup_mutex);
>  struct swap_cgroup_ctrl {
>  	struct page **map;
>  	unsigned long length;
> +	spinlock_t	lock;
>  };
>  
>  struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
> @@ -353,16 +354,22 @@ unsigned short swap_cgroup_cmpxchg(swp_e
>  	struct swap_cgroup_ctrl *ctrl;
>  	struct page *mappage;
>  	struct swap_cgroup *sc;
> +	unsigned long flags;
> +	unsigned short retval;
>  
>  	ctrl = &swap_cgroup_ctrl[type];
>  
>  	mappage = ctrl->map[idx];
>  	sc = page_address(mappage);
>  	sc += pos;
> -	if (cmpxchg(&sc->id, old, new) == old)
> -		return old;
> +	spin_lock_irqsave(&ctrl->lock, flags);
> +	retval = sc->id;
> +	if (retval == old)
> +		sc->id = new;
>  	else
> -		return 0;
> +		retval = 0;
> +	spin_unlock_irqrestore(&ctrl->lock, flags);
> +	return retval;
>  }
>  
>  /**
> @@ -383,13 +390,17 @@ unsigned short swap_cgroup_record(swp_en
>  	struct page *mappage;
>  	struct swap_cgroup *sc;
>  	unsigned short old;
> +	unsigned long flags;
>  
>  	ctrl = &swap_cgroup_ctrl[type];
>  
>  	mappage = ctrl->map[idx];
>  	sc = page_address(mappage);
>  	sc += pos;
> -	old = xchg(&sc->id, id);
> +	spin_lock_irqsave(&ctrl->lock, flags);
> +	old = sc->id;
> +	sc->id = id;
> +	spin_unlock_irqrestore(&ctrl->lock, flags);
>  
>  	return old;
>  }
> @@ -441,6 +452,7 @@ int swap_cgroup_swapon(int type, unsigne
>  	mutex_lock(&swap_cgroup_mutex);
>  	ctrl->length = length;
>  	ctrl->map = array;
> +	spin_lock_init(&ctrl->lock);
>  	if (swap_cgroup_prepare(type)) {
>  		/* memory shortage */
>  		ctrl->map = NULL;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
