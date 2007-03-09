Return-Path: <ralf@linux-mips.org>
Received: from ftp.linux-mips.org (ftp.linux-mips.org [194.74.144.162])
	by ozlabs.org (Postfix) with ESMTP id 43743DDEB8
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 23:09:17 +1100 (EST)
Received: from localhost.localdomain ([127.0.0.1]:31946 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021453AbXCIMBK (ORCPT <rfc822;linuxppc-dev@ozlabs.org>);
	Fri, 9 Mar 2007 12:01:10 +0000
Date: Fri, 9 Mar 2007 11:59:02 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] [POWERPC] Wire up sys_sync_file_range
Message-ID: <20070309115901.GA29723@linux-mips.org>
References: <20070309152201.027c2bf5.sfr@canb.auug.org.au>
	<1173423341.3461.548.camel@pmac.infradead.org>
	<20070308.231341.41635421.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070308.231341.41635421.davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org,
	paulus@samba.org, dwmw2@infradead.org, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 08, 2007 at 11:13:41PM -0800, David Miller wrote:

> > On Fri, 2007-03-09 at 15:22 +1100, Stephen Rothwell wrote:
> > > This requires an architecture specific compat routine as u64s are passed
> > > in odd/even (high/low) register pairs on ppc32.
> > > 
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > 
> > Doesn't that apply to ARM and to 32-bit MIPS too? And perhaps others?
> 
> Unfortunately in the MIPS case you'll have to do some ifdef'ing because
> the order of the "high" and "low" sub-part arguments is dependant upon
> endianness and MIPS can be both big and little endian.

I'd rather let the C compiler sort it out:

asmlinkage long compat_sys_sync_file_range(int fd, int dummy,
	loff_t offset, loff_t nbytes, unsigned int flags)
{
	sys_sync_file_range(fd, offset, nbytes, flags);
}

Which looks like it could be portable to PPC even, so maybe a little cpp
magic like:

#ifdef CONFIG_ABI_NEEDS_PADDING_
#define PAD_64BIT_ARG(x)	unsigned int x,
#else
#define PAD_64BIT_ARG(x)
#endif

[...]
asmlinkage long sys_sync_file_range(int fd,  PAD_64BIT_ARG(pad1)
	loff_t offset, loff_t nbytes, unsigned int flags)

  Ralf
