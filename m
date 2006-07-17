Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: simplify dma_ops bug conditions
References: <20060713063252.1D35867B58@ozlabs.org>
	<20060713063947.GD5096@rhun.ibm.com>
In-Reply-To: <20060713063947.GD5096@rhun.ibm.com>
MIME-Version: 1.0
Date: Mon, 17 Jul 2006 13:55:41 +1000
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607171355.42465.jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Muli,

> Is the BUG_ON() necessary? the next line just goes and deref's it,
> which should lead to a shiny NULL pointer deref.

No, it's not really necessary, more a style thing. The BUG_ON only adds 
an extra 3 instructions (subfic, addi and tdnei), which should be tiny 
compared to the indirect branch.

Also, it makes it a little easier for a user to understand: "there's a 
bug in the kernel" vs. "invalid memory access".


Jeremy
