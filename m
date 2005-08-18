Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17157.7275.960362.923238@cargo.ozlabs.ibm.com>
Date: Fri, 19 Aug 2005 09:40:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <A4C8B92D-B390-4BF8-A6D5-106ACBD0E716@freescale.com>
References: <E1E5KpP-0004dy-00@dorka.pomaz.szeredi.hu>
	<A4C8B92D-B390-4BF8-A6D5-106ACBD0E716@freescale.com>
Cc: akpm@osdl.org, zach@vmware.com, Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org, hch@infradead.org, linuxppc-dev@ozlabs.org,
	"Gala Kumar K.-galak" <galak@freescale.com>, davem@davemloft.net
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> So after all of this its not clear to me if its acceptable to kill  
> all users of <asm/segment.h> in the kernel and to move code that  
> exists in <asm/segment.h> to <asm/uaccess.h> for arch's that need it.

<asm/segment.h> doesn't describe any part of the user/kernel ABI, so
we should be OK to kill it.  I would say we should remove the ppc and
ppc64 versions of it once 2.6.13 is out, and offer the other arch
maintainers a patch that moves their stuff as you suggest.  I think
also we could submit patches to remove the places where it is included
in generic kernel code post 2.6.13.

Paul.
