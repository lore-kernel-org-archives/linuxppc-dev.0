Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH 12/15] arch/powerpc/sysdev/fsl_pci.c: add missing iounmap
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1326362117-29371-12-git-send-email-Julia.Lawall@lip6.fr>
Date: Tue, 17 Jan 2012 16:41:59 -0600
Message-Id: <7BBF25FC-7FFA-4B35-A064-04D616327F12@kernel.crashing.org>
References: <1326362117-29371-12-git-send-email-Julia.Lawall@lip6.fr>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 12, 2012, at 3:55 AM, Julia Lawall wrote:

> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Add missing iounmap in error handling code, in a case where the function
> already preforms iounmap on some other execution path.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression e;
> statement S,S1;
> int ret;
> @@
> e = \(ioremap\|ioremap_nocache\)(...)
> ... when != iounmap(e)
> if (<+...e...+>) S
> ... when any
>    when != iounmap(e)
> *if (...)
>   { ... when != iounmap(e)
>     return ...; }
> ... when any
> iounmap(e);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
> arch/powerpc/sysdev/fsl_pci.c |    5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)

applied to merge

- k
