Return-Path: <baringforge@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by ozlabs.org (Postfix) with ESMTP id 29B36B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Oct 2010 10:10:21 +1100 (EST)
Received: by fxm1 with SMTP id 1so3587367fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 16:10:18 -0700 (PDT)
MIME-Version: 1.0
Sender: baringforge@gmail.com
From: Thomas Taranowski <tom@baringforge.com>
Date: Fri, 29 Oct 2010 16:09:58 -0700
Message-ID: <AANLkTin7OeSgUgqUEnYxUnZQ0vgckg7e43gudms8NqeG@mail.gmail.com>
Subject: Support for multiple port's
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Going through the code, it looks like the rapidio driver assumes
there's only going to be a single Port implemented.

Snapshot of code assumes a single port atmu configuration block, which
is wrong for the p2020, and probably other QorIQ processors.

<snip>
priv->atmu_regs = (struct rio_atmu_regs *)(priv->regs_win
					+ RIO_ATMU_REGS_OFFSET);
priv->maint_atmu_regs = priv->atmu_regs + 1;
priv->dbell_atmu_regs = priv->atmu_regs + 2;
priv->msg_regs = (struct rio_msg_regs *)(priv->regs_win +
			((port->phy_type == RIO_PHY_SERIAL) ?
			RIO_S_MSG_REGS_OFFSET : RIO_P_MSG_REGS_OFFSET));
<snip>

On the newer QorIQ P2020 processors there are 2 sets of port
registers, so the current code lays the dbell_atmu_regs structure on
top of the second set of atmu_regs.  There are probably other issues
as well.

Are there any patch sets available that support the newer processors,
and multi-port ( multi-homed? ) RapidIO configurations?

Thanks!
