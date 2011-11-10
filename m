Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from blv-smtpout-01.boeing.com (blv-smtpout-01.boeing.com
 [130.76.32.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "blv-smtpout-01.boeing.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A2757100853
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 03:32:31 +1100 (EST)
From: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
To: Timur Tabi <timur@freescale.com>
Date: Thu, 10 Nov 2011 10:31:57 -0600
Subject: Re: [RFC PATCH 02/17] powerpc: Split up PHYS_64BIT config option to
 fix "select" issues
Message-ID: <501ACA94-491F-43A7-9DCF-485BEE824DD5@boeing.com>
References: <4E42AB6F.1050900@freescale.com>
 <1320883635-17194-3-git-send-email-Kyle.D.Moffett@boeing.com>
 <4EBBD9DF.6080100@freescale.com>
In-Reply-To: <4EBBD9DF.6080100@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Baruch Siach <baruch@tkos.co.il>, Sonny Rao <sonnyrao@linux.vnet.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Bolle <pebolle@tiscali.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Nov 10, 2011, at 09:04, Timur Tabi wrote:
> Kyle Moffett wrote:
>>  CONFIG_PHYS_64BIT_SUPPORTED:
>>    This hidden option should be selected by any CPU type which supports
>>    64-bit physical addresses.  This will enable the PHYS_64BIT option
>>    to be selected.  It is (obviously) always set on PPC64.
>>=20
>>  CONFIG_PHYS_64BIT_DT_REQUIRED:
>>    This hidden option should be selected by any board or platform which
>>    has >32-bit physical devices present in hardware.  If this is set
>>    then the CONFIG_PHYS_64BIT option will be forcibly enabled and
>>    hidden from the user.  It is (obviously) always set on PPC64.
>>=20
>>  CONFIG_PHYS_64BIT:
>>    This option is user-controllable, where allowed by CPU and platform
>>    settings, and should never be pointed at with a "select" statement.
>>    Due to the values of the above two options, this is never visible on
>>    PPC64.
>=20
> I'm with Kumar on this.  I don't see the point of making it so complicate=
d.

Did you look at the existing code?  It's already that complicated:

config ARCH_PHYS_ADDR_T_64BIT
	def_bool PPC64 || PHYS_64BIT

config ARCH_DMA_ADDR_T_64BIT
	def_bool ARCH_PHYS_ADDR_T_64BIT

config {P1022_DS,P2041_RDB,P3041_DS,P3060_QDS,P4080_DS,P5020_DS}
	select PHYS_64BIT

config 44x
	select PHYS_64BIT

config PTE_64BIT
	bool
	depends on 44x || E500 || PPC_86xx
	default y if PHYS_64BIT

config PHYS_64BIT
	bool 'Large physical address support' if E500 || PPC_86xx
	depends on (44x || E500 || PPC_86xx) && !PPC_83xx && !PPC_82xx

Even worse, PHYS_64BIT is not set on 64-bit processors, but there is
a lot of driver code that seems to assume PHYS_64BIT indicates the
size of "phys_addr_t".

> No kernel should ever have to care with a DT is 64-bit or 32-bit.  If
> you build a kernel with 64-bit phys support, then it will work with
> any DT.
>=20

> U-Boot already warns you if the DT and the actual physical addresses
> of the devices don't match.

The big issue is that the Kconfig docs are very clear that "select"
should not be used on user-visible options (AKA: PHYS_64BIT), and yet
half the PPC_85xx boards have this tidbit:
	select PHYS_64BIT # The DTS has 36-bit addresses

I'm totally OK with removing that from all those boards, but to preserve
the existing behavior (also used by the entire 44x platform) I added the
new config symbol PHYS_64BIT_DT_REQUIRED, which is used to control
whether or not the "PHYS_64BIT" option is even visible to the user.

I originally called it "PHYS_64BIT_REQUIRED", but since all of the
board comments talked about 36-bit DTS addresses, I added the _DT_.


> There are only two reasons to create a 32-bit kernel:
>=20
> 1) A small performance improvement on systems with 2GB or less.
> 2) Some SOC devices only support 32-bit physical addresses, so the
> easiest way to ensure a compatible address is to prohibit memory above
> 4GB.

If this is true, then why does PHYS_64BIT have that big ugly list of
dependencies right now?  I don't know about the other platforms well
enough to tell what would break by enabling PHYS_64BIT, but I assume
that something in the past caused that dependency list.

Cheers,
Kyle Moffett

--
Curious about my work on the Debian powerpcspe port?
I'm keeping a blog here: http://pureperl.blogspot.com/
