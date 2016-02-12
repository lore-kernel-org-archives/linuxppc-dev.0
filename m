Return-Path: <computersforpeace@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC1AB1A006B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 06:44:16 +1100 (AEDT)
Received: by mail-pa0-x241.google.com with SMTP id yy13so4184322pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 11:44:16 -0800 (PST)
Date: Fri, 12 Feb 2016 11:44:11 -0800
From: Brian Norris <computersforpeace@gmail.com>
To: Li Yang <leoli@freescale.com>
Cc: Raghav Dogra <raghav@freescale.com>, linux-mtd@lists.infradead.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, oss@buserror.net,
 prabhakar.kushwaha@nxp.com, Jaiprakash Singh <b44839@freescale.com>
Subject: Re: [PATCH] mtd/ifc: Add support for IFC controller version 2.0
Message-ID: <20160212194411.GF21465@google.com>
References: <1454481372-10288-1-git-send-email-raghav@freescale.com>
 <CADRPPNTKFA8rkynJR4wCNgAmqvmiwYwTi2Uk9hDUMB4+N7ST_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADRPPNTKFA8rkynJR4wCNgAmqvmiwYwTi2Uk9hDUMB4+N7ST_Q@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 04, 2016 at 05:07:16PM -0600, Li Yang wrote:
> On Wed, Feb 3, 2016 at 12:36 AM, Raghav Dogra <raghav@freescale.com> wrote:
> > The new IFC controller version 2.0 has a different memory map page.
> > Upto IFC 1.4 PAGE size is 4 KB and from IFC2.0 PAGE size is 64KB.
> > This patch segregates the IFC global and runtime registers to appropriate
> > PAGE sizes.
> 
> If the global registers and the runtime registers are so independent
> that they have to be on different page boundaries, it would make more
> sense for them to be defined as separate reg regions in the device
> tree at the very beginning.  Then we would only need to change the
> device tree now and it would be future proof for any page size.

To be clear: Scott, you were NACK'ing the DT binding change request,
right? I though we had an Ack on the previous revision (that Raghav
failed to carry).

> >
> > Signed-off-by: Jaiprakash Singh <b44839@freescale.com>
> > Signed-off-by: Raghav Dogra <raghav@freescale.com>
> 
> The patch cannot apply on latest 4.5-rc cleanly either.  Otherwise,

Yeah... neither this patch nor its (allegedly) dependent patch [1] apply
cleanly.

If you expect me to take this patch via MTD, please rebase to
l2-mtd.git as stated here:

http://linux-mtd.infradead.org/source.html

> Acked-by: Li Yang <leoyang.li@nxp.com>

Brian

[1] https://patchwork.ozlabs.org/patch/564785/
