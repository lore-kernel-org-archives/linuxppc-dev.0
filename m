Return-Path: <mikey@neuling.org>
To: subrata@linux.vnet.ibm.com
Subject: Re: [PPC64/Power7 - 2.6.35-rc5] Bad relocation warnings while
	Building a CONFIG_RELOCATABLE kernel with CONFIG_ISERIES enabled
In-reply-to: <1279193743.10707.5.camel@subratamodak.linux.ibm.com>
References: <1273060251.13463.8.camel@subratamodak.linux.ibm.com>
	<20100507054034.GB25173@drongo>
	<1279193743.10707.5.camel@subratamodak.linux.ibm.com>
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 16 Jul 2010 12:04:59 +1000
Message-ID: <4635.1279245899@neuling.org>
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
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

> commit e62cee42e66dcca83aae02748535f62e0f564a0c solved the problem for
> 2.6.34-rc6. However some other bad relocation warnings generated against
> 2.6.35-rc5 on Power7/ppc64 below:
> 
> MODPOST 2004 modules^M
> WARNING: 2 bad relocations^M
> c000000000008590 R_PPC64_ADDR32    .text+0x4000000000008460^M
> c000000000008594 R_PPC64_ADDR32    .text+0x4000000000008598^M

I can't replicate this with your config with gcc 4.4.4 and binutils
2.20.  What are you using?

Mikey

> 
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
