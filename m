Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18615.35796.969180.162185@cargo.ozlabs.ibm.com>
Date: Fri, 29 Aug 2008 15:40:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 0/5] Relocatable 64-bit kernel using linker PIE support
In-Reply-To: <1219925555.7107.276.camel@pmac.infradead.org>
References: <18594.14443.340604.693747@cargo.ozlabs.ibm.com>
	<1219925555.7107.276.camel@pmac.infradead.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> Is this mature enough for us to consider putting it in Fedora? We'd
> _love_ to stop building a separate kdump kernel for ppc64...

Almost, but not quite.  We'll need some modifications to yaboot (it
refuses to accept an ET_DYN image, for instance), plus I'm currently
seeing a puzzling crash inside OF on POWER5 when the image is loaded
from yaboot but not when it's been loaded by netbooting the wrapper
(having hacked the ELF header of vmlinux to make it an ET_EXEC so
yaboot would touch it).

The main remaining substantial technical issue is how we detect very
early on that we are a kdump kernel.  I think the policy should be
that the kernel copies itself down to 0 if it's not a kdump kernel and
runs wherever it was loaded if it's a kdump kernel.  The only way to
tell whether we're a kdump kernel seems to be to look at the kernel
command line, which is a little tricky to do in head_64.S when the
command line is buried inside the DTB.

Paul.
