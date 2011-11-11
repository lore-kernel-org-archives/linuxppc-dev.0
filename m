Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
 [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 91C161007DA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2011 00:12:43 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 02/17] powerpc: Split up PHYS_64BIT config option to
 fix "select" issues
Date: Fri, 11 Nov 2011 13:12:31 +0000
Message-ID: <4EBD1F3E.2040402@freescale.com>
References: <4E42AB6F.1050900@freescale.com>
 <1320883635-17194-3-git-send-email-Kyle.D.Moffett@boeing.com>
 <4EBBD9DF.6080100@freescale.com>
 <501ACA94-491F-43A7-9DCF-485BEE824DD5@boeing.com>
 <4EBC00D2.2030208@freescale.com> <1320987054.21206.55.camel@pasglop>
In-Reply-To: <1320987054.21206.55.camel@pasglop>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>, Baruch Siach <baruch@tkos.co.il>,
 Sonny Rao <sonnyrao@linux.vnet.ibm.com>,
 Tabi Timur-B04825 <B04825@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, "Moffett,
 Kyle D" <Kyle.D.Moffett@boeing.com>, Anatolij Gustschin <agust@denx.de>,
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

Benjamin Herrenschmidt wrote:

> For PHYS_64BIT, I'm not 100% certain at this point what the best
> approach it. It should clearly be fixed and hidden for real 64-bit. As
> for the rest, should it be user selectable ?

I have been unable to convince our BSP teams that the minor performance=20
improvement of a 32-bit kernel vs 36-bit is not worth the hassle.  We ship=
=20
a lot of lower-end e500 systems that will never have more than 2GB of memor=
y.

The P1022DS is an example.  We ship 32-bit and 36-bit versions of U-Boot,=20
the kernel, and the device tree.  I recently added code to U-boot to=20
detect if you have a mismatched U-Boot and device tree, because it is so=20
easy to mess that up.  I would like nothing more than to abandon 32-bit=20
for all e500, but I don't see Freescale allowing that any time soon.

--=20
Timur Tabi
Linux kernel developer at Freescale=
