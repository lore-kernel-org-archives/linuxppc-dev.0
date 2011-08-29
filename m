Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 1/2] arch/powerpc/platforms/cell/iommu.c: add missing
	of_node_put
Date: Mon, 29 Aug 2011 13:26:49 +0200
References: <1313943001-12884-1-git-send-email-julia@diku.dk>
In-Reply-To: <1313943001-12884-1-git-send-email-julia@diku.dk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201108291326.49561.arnd@arndb.de>
Cc: cbe-oss-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 21 August 2011, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> np is initialized to the result of calling a function that calls
> of_node_get, so of_node_put should be called before the pointer is dropped.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression e,e1,e2;
> @@
> 
> * e = \(of_find_node_by_type\|of_find_node_by_name\)(...)
>   ... when != of_node_put(e)
>       when != true e == NULL
>       when != e2 = e
>   e = e1
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
Acked-by: Arnd Bergmann <arnd@arndb.de>
