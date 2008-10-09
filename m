Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18669.38794.476429.103254@cargo.ozlabs.ibm.com>
Date: Thu, 9 Oct 2008 16:32:58 +1100
From: Paul Mackerras <paulus@samba.org>
To: mohan@in.ibm.com
Subject: Re: [PATCH] Fix kdump kernel hang issue with relocatable kernel
	patches
In-Reply-To: <20081001182501.GA20319@in.ibm.com>
References: <20081001182501.GA20319@in.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mohan Kumar M writes:

> One of the relocatable kernel support patches assumes that the target
> address will be 0. But for kdump kernels (without relocation support) it
> will be 32MB. The following patch fixes this issue.
> 
> Fix kdump kernel issue
> 
> Kdump kernel without relocation support needs to be moved to
> PHYSICAL_START (ie 32MB) instead of 0. This patch fixes this
> issue.

Hmmm.  Is there any reason to continue to support non-relocatable
64-bit kernels being kdump kernels?  In other words, for 64-bit,
couldn't we make CONFIG_CRASH_DUMP depend on CONFIG_RELOCATABLE?

I don't think we want to try to support two different modes of
operation for a kdump kernel, and I don't see any value in continuing
to support PHYSICAL_START > 0 for 64-bit non-relocatable kernels.
(And when we can make 32-bit PIE kernels, I'll be making the same
statement about 32-bit. :)

Paul.
