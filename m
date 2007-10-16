Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18196.20112.728499.256646@cargo.ozlabs.ibm.com>
Date: Tue, 16 Oct 2007 15:39:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Merge dtc
In-Reply-To: <B17BEF48-34FC-44E0-AC23-1DB7522EB198@kernel.crashing.org>
References: <20071016050217.GA9052@localhost.localdomain>
	<B17BEF48-34FC-44E0-AC23-1DB7522EB198@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Dare I ask why we are including dtc in the kernel source tree?  We  
> don't really have precedence for this and there are users outside of  
> linux for dtc.

You must have missed the thread where various people where complaining
about how powerpc is the only architecture where they can't build
kernels without some external tool that they don't have, etc., etc.

We thought about shipping compiled DTBs for various platforms, but the
problem there is that they can't be updated with a patch, so whoever
commits a patch to the relevant .dts would have to remember to run dtc
and commit the updated .dtb as well, which seems a bit error-prone.

In the end, dtc isn't all that much code.  We already have several
other programs that run on the host in the process of making a zImage,
such as wrapper, hack-coff, and addnote, not to mention the various C
programs that are part of Kbuild, and unifdef, kallsyms, etc.

So I think there definitely is a precedent for including dtc.

Paul.
