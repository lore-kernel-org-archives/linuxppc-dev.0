Date: Tue, 5 Mar 2002 15:47:39 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: David Ashley <dash@xdr.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mmap wrapping around to 0 revisited
Message-ID: <20020305154739.C432@redhat.com>
References: <200203041605.g24G5Ts15070@xdr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200203041605.g24G5Ts15070@xdr.com>; from dash@xdr.com on Mon, Mar 04, 2002 at 08:05:29AM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Mar 04, 2002 at 08:05:29AM -0800, David Ashley wrote:
> The fix is in
> arch/ppc/kernel/syscalls.c
> in the sys_mmap function, change this line:
> 	err = do_mmap2(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
> to
> 	err = do_mmap2(addr, len, prot, flags, fd, (unsigned long)offset >> PAGE_SHIFT);
>
> Possibly it would be better to have the argument as an unsigned long instead
> of an off_t.

Wrong fix.  sys_mmap on ppc should really be using do_mmap which already
includes the cast to unsigned long and checks for overflow.  Arguably,
it could well check for -'ve offsets and reject them, but traditionally
Linux has accepted up to 4GB offsets with its 32 bit APIs and changing
this would break a few things like X.

		-ben

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
