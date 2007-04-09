Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17946.33766.593173.670008@cargo.ozlabs.ibm.com>
Date: Tue, 10 Apr 2007 04:20:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 6/6] [POWERPC] make struct property's value a void *
In-Reply-To: <1e26dd33aaeae9c55962be681b85e75e@kernel.crashing.org>
References: <65f2b2574eca0b34e7986618cfbe7a6d@kernel.crashing.org>
	<20070403.112813.35016105.davem@davemloft.net>
	<19e36144f9d496f2a9670ac889435349@kernel.crashing.org>
	<20070404.122129.45875882.davem@davemloft.net>
	<a5ebb728f4c22755d884910149e43c86@kernel.crashing.org>
	<1175814107.30879.143.camel@localhost.localdomain>
	<1e26dd33aaeae9c55962be681b85e75e@kernel.crashing.org>
Cc: sfr@canb.auug.org.au, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> Pointers never alias anything.  It's the data accesses
> that matter.  You cannot access one type as another type
> and expect it to work (unless one of those types is a
> character type); that's the one simple rule.

This is true according to the standard (as I understand it), and also
a classic example of the C standards committee stuffing up the C
language by trying to turn it into a "high-level" language.  From the
earliest days of C on the PDP-11 it was understood that memory was an
array of bytes which could be addressed and interpreted in any way the
programmer chose.  For systems programming tasks that is a very useful
facility, and one which the kernel code generally assumes.  It's a
pity IMHO that the committee chose to throw that away (and yes I
understand that throwing it away makes more optimization opportunities
available).

Paul.
