Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: 64K page support for kexec
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Luke Browning <lukebr@linux.vnet.ibm.com>
In-Reply-To: <1177529739.24866.34.camel@luke-laptop>
References: <1177439513.24866.5.camel@luke-laptop>
	<20070424194348.GA8371@lixom.net>
	<1177455014.14873.144.camel@localhost.localdomain>
	<1177529739.24866.34.camel@luke-laptop>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 08:19:45 +1000
Message-Id: <1177539585.14873.202.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-04-25 at 16:35 -0300, Luke Browning wrote:
> This patch fixes a couple of kexec problems related to 64K page 
> support in the kernel.  kexec issues a tlbie for each pte.  The 
> parameters for the tlbie are the page size and the virtual address.
> Support was missing for the computation of these two parameters
> for 64K pages.  This patch adds that support.  
> 
> Signed-off-by: Luke Browning <lukebrowning@us.ibm.com>

Quick look: looks good to me. I suppose you verified it works well
too :-)

(Have you added some debug to check we get the 16M case right ?)

Note that Milton is against using BUG_ON's in here since that code is
used for crash dumps.

Appart from that,

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cheers,
Ben.
