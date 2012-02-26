Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AC5C1B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2012 10:42:21 +1100 (EST)
Message-ID: <1330299728.20389.60.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc: Board support for GE IMP3A
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martyn Welch <martyn.welch@ge.com>
Date: Mon, 27 Feb 2012 10:42:08 +1100
In-Reply-To: <1328614121-17803-3-git-send-email-martyn.welch@ge.com>
References: <1328614121-17803-1-git-send-email-martyn.welch@ge.com>
 <1328614121-17803-3-git-send-email-martyn.welch@ge.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wim Van Sebroeck <wim@iguana.be>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-02-07 at 11:28 +0000, Martyn Welch wrote:
> +
> +       if (of_flat_dt_is_compatible(root, "fsl,MPC8572DS-CAMP")) {
> +               mpic = mpic_alloc(NULL, 0,
> +                       MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
> +                       MPIC_SINGLE_DEST_CPU,
> +                       0, 256, " OpenPIC  ");
> +       } else {
> +               mpic = mpic_alloc(NULL, 0,
> +                         MPIC_WANTS_RESET |
> +                         MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
> +                         MPIC_SINGLE_DEST_CPU,
> +                       0, 256, " OpenPIC  ");
> +       }
> + 

Can you rebase this on top of powerpc-next ? There have been some mpic
changes from Kyle Moffett that clash with this (mostly some of the flags
are gone, the remaining ones you should just put in the device-tree).

Cheers,
Ben.
