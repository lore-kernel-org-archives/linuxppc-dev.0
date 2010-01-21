Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D343DB7CE8
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2010 20:34:02 +1100 (EST)
Date: Thu, 21 Jan 2010 10:33:52 +0100
From: Anatolij Gustschin <agust@denx.de>
To: David Miller <davem@davemloft.net>
Subject: Re: [net-next-2.6 PATCH 2/3] fs_enet: Add support for MPC512x to
	fs_enet driver
Message-ID: <20100121103352.788a6f80@wker>
In-Reply-To: <20100121.012235.161201297.davem@davemloft.net>
References: <1264039999-25731-1-git-send-email-agust@denx.de>
	<1264039999-25731-3-git-send-email-agust@denx.de>
	<20100121.012235.161201297.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: wd@denx.de, dzu@denx.de, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	kosmo@semihalf.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 21 Jan 2010 01:22:35 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: Anatolij Gustschin <agust@denx.de>
> Date: Thu, 21 Jan 2010 03:13:18 +0100
> 
> >  struct fec_info {
> > -	fec_t __iomem *fecp;
> > +	void __iomem *fecp;
>  ...
> >  /* write */
> > -#define FW(_fecp, _reg, _v) __fs_out32(&(_fecp)->fec_ ## _reg, (_v))
> > +#define FW(_regp, _reg, _v) __fs_out32((_regp)->fec_ ## _reg, (_v))
>  ...
> > +/* register address macros */
> > +#define fec_reg_addr(_type, _reg) \
> > +	(fep->fec.rtbl->fec_##_reg = (u32 __iomem *)((u32)fep->fec.fecp + \
> > +				(u32)&((__typeof__(_type) *)NULL)->fec_##_reg))
> > +
> > +#define fec_reg_mpc8xx(_reg) \
> > +	fec_reg_addr(struct mpc8xx_fec, _reg)
> > +
> > +#define fec_reg_mpc5121(_reg) \
> > +	fec_reg_addr(struct mpc5121_fec, _reg)
> 
> This is a step backwards in my view.
> 
> If you use the "fec_t __iomem *" type for the register
> pointer, you simply use &p->fecp->XXX to get the I/O
> address of register XXX and that's what you pass to
> the appropriate I/O accessor routines.
> 
> Now you've made it typeless, and then you have to walk
> through all of these contortions to get the offset.
 
OK, i give up
