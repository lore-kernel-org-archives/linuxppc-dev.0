Return-Path: <paulus@ozlabs.org>
Date: Fri, 7 May 2010 15:40:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: Re: PPC64 2.6.34-rc6 warning - Is this expected ?
Message-ID: <20100507054034.GB25173@drongo>
References: <1273060251.13463.8.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1273060251.13463.8.camel@subratamodak.linux.ibm.com>
Cc: Linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@au1.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 05, 2010 at 05:20:51PM +0530, Subrata Modak wrote:

> I built 2.6.34-rc6 with the attached Fedora Config file
> (config-2.6.33.1-19.fc13.ppc64) on my P5 Fedora Box and got the
> following warning. Is the following expected ?
> 
> CALL    arch/powerpc/relocs_check.pl
> Building modules, stage 2.
> WARNING: 4 bad relocations
> c00000000007216e R_PPC64_ADDR16_HIGHEST  __ksymtab+0x00000000009dcec8
> c000000000072172 R_PPC64_ADDR16_HIGHER  __ksymtab+0x00000000009dcec8
> c00000000007217a R_PPC64_ADDR16_HI  __ksymtab+0x00000000009dcec8
> c00000000007217e R_PPC64_ADDR16_LO  __ksymtab+0x00000000009dcec8

No, it's not expected.  It's in iSeries code, so you could avoid it
just by disabling CONFIG_ISERIES (I don't think any distro still
supports legacy iSeries).  I'll post a patch to fix the problem
properly.

Paul.
