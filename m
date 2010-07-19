Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PPC64/Power7 - 2.6.35-rc5] Bad relocation warnings while
	Building a CONFIG_RELOCATABLE kernel with CONFIG_ISERIES enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: subrata@linux.vnet.ibm.com
In-Reply-To: <1279193743.10707.5.camel@subratamodak.linux.ibm.com>
References: <1273060251.13463.8.camel@subratamodak.linux.ibm.com>
	<20100507054034.GB25173@drongo>
	<1279193743.10707.5.camel@subratamodak.linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 19 Jul 2010 11:11:29 +1000
Message-ID: <1279501889.10390.1834.camel@pasglop>
Mime-Version: 1.0
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Paul Mackerras <paulus@au1.ibm.com>, divya.vikas@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-15 at 17:05 +0530, Subrata Modak wrote:
> commit e62cee42e66dcca83aae02748535f62e0f564a0c solved the problem for
> 2.6.34-rc6. However some other bad relocation warnings generated against
> 2.6.35-rc5 on Power7/ppc64 below:
> 
> MODPOST 2004 modules^M
> WARNING: 2 bad relocations^M
> c000000000008590 R_PPC64_ADDR32    .text+0x4000000000008460^M
> c000000000008594 R_PPC64_ADDR32    .text+0x4000000000008598^M

I think this is KVM + CONFIG_RELOCATABLE. Caused by:

.global kvmppc_trampoline_lowmem
kvmppc_trampoline_lowmem:
	.long kvmppc_handler_lowmem_trampoline - CONFIG_KERNEL_START

.global kvmppc_trampoline_enter
kvmppc_trampoline_enter:
	.long kvmppc_handler_trampoline_enter - CONFIG_KERNEL_START

Alex, can you turn these into 64-bit on ppc64 so the relocator
can grok them ?

Cheers,
Ben.

> Config file attached.
> 
> Regards--
> Subrata
> 
> On Fri, 2010-05-07 at 15:40 +1000, Paul Mackerras wrote:
> > On Wed, May 05, 2010 at 05:20:51PM +0530, Subrata Modak wrote:
> > 
> > > I built 2.6.34-rc6 with the attached Fedora Config file
> > > (config-2.6.33.1-19.fc13.ppc64) on my P5 Fedora Box and got the
> > > following warning. Is the following expected ?
> > > 
> > > CALL    arch/powerpc/relocs_check.pl
> > > Building modules, stage 2.
> > > WARNING: 4 bad relocations
> > > c00000000007216e R_PPC64_ADDR16_HIGHEST  __ksymtab+0x00000000009dcec8
> > > c000000000072172 R_PPC64_ADDR16_HIGHER  __ksymtab+0x00000000009dcec8
> > > c00000000007217a R_PPC64_ADDR16_HI  __ksymtab+0x00000000009dcec8
> > > c00000000007217e R_PPC64_ADDR16_LO  __ksymtab+0x00000000009dcec8
> > 
> > No, it's not expected.  It's in iSeries code, so you could avoid it
> > just by disabling CONFIG_ISERIES (I don't think any distro still
> > supports legacy iSeries).  I'll post a patch to fix the problem
> > properly.
> > 
> > Paul.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
