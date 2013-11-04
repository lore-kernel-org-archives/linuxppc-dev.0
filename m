Return-Path: <paulus@ozlabs.org>
Date: Mon, 4 Nov 2013 13:43:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Tom <tommusta@gmail.com>
Subject: Re: [V2 PATCH 2/3] powerpc: Fix Unaligned Fixed Point Loads and Stores
Message-ID: <20131104024329.GB32010@drongo>
References: <1383244738-5986-1-git-send-email-tommusta@gmail.com>
 <1383244738-5986-3-git-send-email-tommusta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383244738-5986-3-git-send-email-tommusta@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 31, 2013 at 01:38:57PM -0500, Tom wrote:
> From: Tom Musta <tommusta@gmail.com>
> 
> This patch modifies the unaligned access routines of the sstep.c
> module so that it properly reverses the bytes of storage operands
> in the little endian kernel kernel.

This has rather a lot of #ifdefs inside function definitions, and for
little-endian it does the unaligned accesses one byte at a time.  You
could avoid all the #ifdefs if you define the combining function in an
endian-dependant way and make read_mem_unaligned look something like
this:

#ifdef __LITTLE_ENDIAN__
#define combine_pieces(x, b, c, nd)	((x) + ((b) << (8 * (nd))))
#else
#define combine_pieces(x, b, c, nd)	(((x) << (8 * (c))) + (b))
#endif

static int __kprobes read_mem_unaligned(unsigned long *dest, unsigned long ea,
					int nb, struct pt_regs *regs)
{
	int err;
	int nd;
	unsigned long x, b, c;

	/* unaligned, do this in pieces */
	x = 0;
	for (nd = 0; nd < nb; nd += c) {
		c = max_align(ea);
		if (c > nb - nd)
			c = max_align(nb - nd);
		err = read_mem_aligned(&b, ea, c);
		if (err)
			return err;
		x = combine_pieces(x, b, c, nd);
		ea += c;
	}
	*dest = x;
	return 0;
}

and do something analogous for write_mem_unaligned().

Paul.
