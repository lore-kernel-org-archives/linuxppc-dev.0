Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0134.outbound.protection.outlook.com [65.55.169.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 35B8B1A0E74
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 11:43:59 +1100 (AEDT)
Message-ID: <1421973825.4961.253.camel@freescale.com>
Subject: Re: [PATCH] powerpc/fsl_pci: Fix pci stack build bug with FRAME_WARN
From: Scott Wood <scottwood@freescale.com>
To: Kim Phillips <kim.phillips@freescale.com>
Date: Thu, 22 Jan 2015 18:43:45 -0600
In-Reply-To: <20150122182056.cc3436bd90a6cbba70da538a@freescale.com>
References: <20150120140349.a7a9885065c241b555b91717@freescale.com>
 <1421800292.4961.215.camel@freescale.com>
 <20150121204844.fda3d4ab23a8226b6cdfdaf6@freescale.com>
 <1421895747.4961.232.camel@freescale.com>
 <20150122182056.cc3436bd90a6cbba70da538a@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wang Dongsheng <dongsheng.wang@freescale.com>, linux-kernel@vger.kernel.org,
 Himangi Saraogi <himangi774@gmail.com>, Anton Blanchard <anton@samba.org>,
 Paul Mackerras <paulus@samba.org>, Aaron Sierra <asierra@xes-inc.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-01-22 at 18:20 -0600, Kim Phillips wrote:
> On Wed, 21 Jan 2015 21:02:27 -0600
> Scott Wood <scottwood@freescale.com> wrote:
> 
> > On Wed, 2015-01-21 at 20:48 -0600, Kim Phillips wrote:
> > > fake_pci_bus()' version is static, so it's not on the stack.
> > > 
> > > given that, maybe fsl_pcie_check_link()'s should be static too?
> > 
> > Oh.  How would you ensure that it's only called once at a time?  It
> > doesn't look like this is only called during early boot.
> > fsl_pcie_check_link() is called every time we do any config read through
> > the normal interface.  This is also a concern for the call to
> > early_read_config_dword().
> 
> I really don't know how that works: that code has been there since
> before linux was maintained in git.

Regardless, now that it's been noticed we should figure it out.
fsl_pcie_check_link() is using the early_*() functions in a context that
is not early and thus appears to be breaking the assumption that
fake_pci_bus() makes.

fsl_pcie_check_link() is fairly recent, FWIW.

> Below is the v2.

Please send as a standalone patch so I don't have to edit all the
discussion out of the commit message.

-Scott
