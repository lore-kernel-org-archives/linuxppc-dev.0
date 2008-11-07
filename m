Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18707.53757.132643.518167@cargo.ozlabs.ibm.com>
Date: Fri, 7 Nov 2008 16:28:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Sonny Rao <sonnyrao@us.ibm.com>
Subject: Re: [PATCH] Fix BSR to allow mmap of small BSR on 64k kernel
In-Reply-To: <20081107003841.GE7533@us.ibm.com>
References: <20081107003841.GE7533@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sonny Rao writes:

> Fix the BSR driver to allow small BSR devices, which are limited to a
> single 4k space, on a 64k page kernel.  Previously the driver would
> reject the mmap since the size was smaller than PAGESIZE (or because
> the size was greater than the size of the device).  Now, we check for
> this case use remap_4k_pfn(). Also, take out code to set vm_flags,
> as the remap_pfn functions will do this for us.

Thanks.

Do we know that the BSR size will always be 4k if it's not a multiple
of 64k?  Is it possible that we could get 8k, 16k or 32k or BSRs?
If it is possible, what does the user need to be able to do?  Do they
just want to map 4k, or might then want to map the whole thing?

Paul.
