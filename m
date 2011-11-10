Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
 [216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C653AB6F82
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 01:04:29 +1100 (EST)
Message-ID: <4EBBD9DF.6080100@freescale.com>
Date: Thu, 10 Nov 2011 08:04:15 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Subject: Re: [RFC PATCH 02/17] powerpc: Split up PHYS_64BIT config option
 to fix "select" issues
References: <4E42AB6F.1050900@freescale.com>
 <1320883635-17194-3-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <1320883635-17194-3-git-send-email-Kyle.D.Moffett@boeing.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Baruch Siach <baruch@tkos.co.il>, Sonny Rao <sonnyrao@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 Paul Bolle <pebolle@tiscali.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kyle Moffett wrote:
>   CONFIG_PHYS_64BIT_SUPPORTED:
>     This hidden option should be selected by any CPU type which supports
>     64-bit physical addresses.  This will enable the PHYS_64BIT option
>     to be selected.  It is (obviously) always set on PPC64.
> 
>   CONFIG_PHYS_64BIT_DT_REQUIRED:
>     This hidden option should be selected by any board or platform which
>     has >32-bit physical devices present in hardware.  If this is set
>     then the CONFIG_PHYS_64BIT option will be forcibly enabled and
>     hidden from the user.  It is (obviously) always set on PPC64.
> 
>   CONFIG_PHYS_64BIT:
>     This option is user-controllable, where allowed by CPU and platform
>     settings, and should never be pointed at with a "select" statement.
>     Due to the values of the above two options, this is never visible on
>     PPC64.

I'm with Kumar on this.  I don't see the point of making it so complicated.  No kernel should ever have to care with a DT is 64-bit or 32-bit.  If you build a kernel with 64-bit phys support, then it will work with any DT.

U-Boot already warns you if the DT and the actual physical addresses of the devices don't match.

There are only two reasons to create a 32-bit kernel:

1) A small performance improvement on systems with 2GB or less.
2) Some SOC devices only support 32-bit physical addresses, so the easiest way to ensure a compatible address is to prohibit memory above 4GB.

Item #2 is not something that we really worry about.  It's only a real problem on true 64-bit kernels, and in those cases, we cannot build a kernel with 32-bit phys support, so the driver needs to handle it internally.

-- 
Timur Tabi
Linux kernel developer at Freescale
