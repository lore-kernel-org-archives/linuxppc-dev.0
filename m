Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 91939DE3C4
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 04:48:55 +1100 (EST)
Date: Fri, 28 Mar 2008 20:48:53 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2 v4] Driver for Freescale 8610 and 5121 DIU
Message-ID: <20080328174853.GA1438@localhost.localdomain>
References: <12066720572512-git-send-email-yorksun@freescale.com>
	<12066720572314-git-send-email-yorksun@freescale.com>
	<47ED2B35.4030601@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47ED2B35.4030601@freescale.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, a.p.zijlstra@chello.nl,
	linux-kernel@vger.kernel.org, Timur Tabi <timur@freescale.com>,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	York Sun <yorksun@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 28, 2008 at 12:30:29PM -0500, Scott Wood wrote:
> York Sun wrote:
> >+static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
> >+		       unsigned long arg)
> >+{
> >+	struct mfb_info *mfbi = info->par;
> >+	struct diu_ad *ad = mfbi->ad;
> >+	struct mfb_chroma_key ck;
> >+	unsigned char global_alpha;
> >+	struct aoi_display_offset aoi_d;
> >+	__u32 pix_fmt;
> >+
> >+	switch (cmd) {
> >+	case MFB_SET_PIXFMT:
> >+		if (!arg)
> >+			return -EINVAL;
> >+		if (copy_from_user(&pix_fmt, (void __user *)arg,
> >+				sizeof(pix_fmt)))
> 
> OK, you fixed the cast here...

Maybe better would be to define "buf" at the top of this function as
void __user *buf = (void __user *)arg;, i.e. just once?

> 
> >+			return -EFAULT;
> >+		ad->pix_fmt = pix_fmt;
> >+		pr_debug("Set pixel format to 0x%08x\n", ad->pix_fmt);
> >+		break;
> >+	case MFB_GET_PIXFMT:
> >+		if (!arg)
> >+			return -EINVAL;

This if (!arg) appears to be everywhere except default: label, maybe
this could be placed on top too?

> >+		pix_fmt = ad->pix_fmt;
> >+		if (copy_to_user((void *)arg, &pix_fmt, sizeof(pix_fmt)))
> >+			return -EFAULT;
> >+		pr_debug("get pixel format 0x%08x\n", ad->pix_fmt);
> >+		break;
> >+	case MFB_SET_AOID:
> >+		if (!arg)
> >+			return -EINVAL;
> >+		if (copy_from_user(&aoi_d, (void *)arg, sizeof(aoi_d)))
> >+			return -EFAULT;
> 
> ...but not anywhere else.  All user pointers should have a __user 
> annotation.

-- 
Anton Vorontsov
email: cboumailru@gmail.com
irc://irc.freenode.net/bd2
