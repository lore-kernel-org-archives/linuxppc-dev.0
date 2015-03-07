Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0139.outbound.protection.outlook.com [157.56.111.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BEBF1A0198
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Mar 2015 12:21:41 +1100 (AEDT)
Date: Fri, 6 Mar 2015 19:16:17 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Martin Hicks <mort@bork.org>
Subject: Re: [PATCH 2/2] crypto: talitos: Add AES-XTS Support
Message-ID: <20150306191617.bbc38506ae2242dc20fdfee4@freescale.com>
In-Reply-To: <CAJUS3XmfcJCiBMnsiXKpc=QXE-YxTQy67wZyAXgKjtY_DN0CDQ@mail.gmail.com>
References: <1424451610-5786-1-git-send-email-mort@bork.org>
 <1424451610-5786-3-git-send-email-mort@bork.org>
 <20150305181615.493b173d43249548fae29203@freescale.com>
 <CAJUS3XmfcJCiBMnsiXKpc=QXE-YxTQy67wZyAXgKjtY_DN0CDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 6 Mar 2015 11:49:43 -0500
Martin Hicks <mort@bork.org> wrote:

> On Thu, Mar 5, 2015 at 7:16 PM, Kim Phillips <kim.phillips@freescale.com> wrote:
> > On Fri, 20 Feb 2015 12:00:10 -0500
> > Martin Hicks <mort@bork.org> wrote:
> >
> >> The newer talitos hardware has support for AES in XTS mode.
> >
> > Assuming it's the same thing, AES-XCBC gets added with SEC v3.0
> > h/w.  Assuming hw_supports() doesn't already support this algorithm
> 
> AES-XCBC isn't the same thing as AES-XTS.

Thanks.

> > combination (technically via the mode bit), this needs to be
> > reflected in the patch so the driver doesn't think SEC 2.x devices
> > can do XTS, too.
> 
> Right.  I hadn't looked into how exactly hw_supports() works.  It only
> indicates which execution units are present (in this case the AES
> unit).  I actually think XTS gets introduced in SEC v3.3.2.  I also
> have an MPC8379 (sec3.3) and it does not have XTS.
> 
> Can you look internally to find out in which hardware it was
> introduced?  Is there a SEC 3.3.1 that also has XTS?

later MPC8315Es had a SEC v3.3.1, but AFAICT, it doesn't support
XTS, so, yes, it's likely v3.3.2 and above (if any).

> I guess I just need a ->features flag to conditionally register the
> XTS algorithm for 3.3.x and newer.  Adding anything more complicated
> doesn't seem warranted at this time, although that could change if
> someone came along and needed to add a whole whack more of the AES
> modes that were introduced at various times in the different SEC
> revisions.

OK.  Note: there's some SEC node fixup code in u-boot that could be
used for this job, too.

> >> +             .desc_hdr_template = DESC_HDR_TYPE_COMMON_NONSNOOP_NO_AFEU |
> >> +                                     DESC_HDR_SEL0_AESU |
> >> +                                     DESC_HDR_MODE0_AESU_XTS,
> >
> > ...
> >
> >>  /* primary execution unit mode (MODE0) and derivatives */
> >>  #define      DESC_HDR_MODE0_ENCRYPT          cpu_to_be32(0x00100000)
> >>  #define      DESC_HDR_MODE0_AESU_CBC         cpu_to_be32(0x00200000)
> >> +#define      DESC_HDR_MODE0_AESU_XTS         cpu_to_be32(0x04200000)
> >
> > I'd prefer these defines be kept as single bit definitions, and keep
> > their names from the manual.  An XTS-specific definition can be
> > composed from them either after this, or manually in the
> > desc_hdr_template assignment above.
> 
> It doesn't look like there are divisible single-bit definitions for
> the MODE0 bits. The AES Cipher modes are composed of 5 bits called
> CipherMode, Extended CipherMode and Aux2.  Individually they don't
> seem to mean anything.  Unless you want something like:
> 
> #define AES_MODE(cm, ecm, aux2)   cpu_to_be32(((ecm<<6) | (aux2<<5) |
> (cm<<1)) << 20)
> 
> #define DESC_HDR_MODE0_AESU_CBC  AES_MODE(1, 0, 0)
> #define DESC_HDR_MODE0_AESU_XTS   AES_MODE(1, 1, 0)

the way you had it seems to be ok for now.

Kim
