Return-Path: <paulus@ozlabs.org>
Date: Thu, 11 Aug 2011 09:58:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/3] KVM: PPC: Assemble book3s{,_hv}_rmhandlers.S
	separately
Message-ID: <20110810235818.GC5536@bloggs.ozlabs.ibm.com>
References: <20110723074111.GA17927@bloggs.ozlabs.ibm.com>
	<4E37EB8C.8040408@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E37EB8C.8040408@suse.de>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 02, 2011 at 02:20:28PM +0200, Alexander Graf wrote:
> On 07/23/2011 09:41 AM, Paul Mackerras wrote:
> >This makes arch/powerpc/kvm/book3s_rmhandlers.S and
> >arch/powerpc/kvm/book3s_hv_rmhandlers.S be assembled as
> >separate compilation units rather than having them #included in
> >arch/powerpc/kernel/exceptions-64s.S.  We no longer have any
> >conditional branches between the exception prologs in
> >exceptions-64s.S and the KVM handlers, so there is no need to
> >keep their contents close together in the vmlinux image.
> >
> >In their current location, they are using up part of the limited
> >space between the first-level interrupt handlers and the firmware
> >NMI data area at offset 0x7000, and with some kernel configurations
> >this area will overflow (e.g. allyesconfig), leading to an
> >"attempt to .org backwards" error when compiling exceptions-64s.S.
> >
> >Moving them out requires that we add some #includes that the
> >book3s_{,hv_}rmhandlers.S code was previously getting implicitly
> >via exceptions-64s.S.
> 
> So what if your kernel binary is bigger than the 24 bits we can jump
> and the KVM code happens to be at the end? Or do we just not care
> here?

Actually we can jump +/- 32MB (26 bits).  I believe that the linker
inserts trampolines if the branch target is more than 32MB away, so it
should still work if the kernel is really large and the KVM code
happens to be at the end.

Stephen Rothwell has been asking me about this patch.  He wants it in
(or something like it) so that he can get his daily linux-next powerpc
allyesconfig builds to stop failing.

Paul.
