Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A24C10F12
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 09:28:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4090E2073F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 09:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4090E2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kcP66k2zzDqLy
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 19:28:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.196; helo=mail-qt1-f196.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kcMG4jzmzDqLy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 19:27:06 +1000 (AEST)
Received: by mail-qt1-f196.google.com with SMTP id h39so26575534qte.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 02:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4u4xhfWbf3XY4Y+pcpPS6MedsvDzFzM06IvHIQZgNXk=;
 b=Yry2wuvQ7wlRsCAWci3UExe+qm8sR3IFtn7T1nQImddRrNm+JOGol1TzU/7VK8tJ3J
 butbXor2XBGWyO8KfkKwQePY//ZHAqsQtegPhRokPFBlL2Hvx8VjHDFxB2nbVmCxCG+L
 fUxw3RlxPvybh/iTkHUrbvlWeix1dUXZD7oL2bjvf0YB20ojGM8kTUVaSBgY/KCTA8jM
 Ul7zThq3glQQ+sFJZEho0P+gJOW1NlD0S+ynwpnuYvbVZ/wXDR0HQ0pS8JN7murZL5d1
 SpMFyy/zxi7cp3AKrpU/cXVEXNz+w5qdxH9RGKJH7Mv9I41vSoImoo92y3GY1bD6UJhT
 6zEQ==
X-Gm-Message-State: APjAAAXRK1/DeGQXzXmXRwluLX046GhCd2gxqrznhA7iFjHwlnB7peFW
 DmcS9oaR6hYohlv3Sfv9dJ4jRtu9LNB6cge5u/8=
X-Google-Smtp-Source: APXvYqxMYD0WkcBhH5KMGg2GQrC8NQiLbvHHqXdWUyYN5FOPcRa84ZlsyMKbaUX6bPKbS+XpMs+SLZ47T6LYOQj2jl4=
X-Received: by 2002:ac8:276b:: with SMTP id h40mr71421815qth.319.1555493223409; 
 Wed, 17 Apr 2019 02:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190416202013.4034148-1-arnd@arndb.de>
 <c379ed8d-1f33-e391-a1b5-810da77605f2@interlog.com>
In-Reply-To: <c379ed8d-1f33-e391-a1b5-810da77605f2@interlog.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Apr 2019 11:26:46 +0200
Message-ID: <CAK8P3a31L4isqsG_qPwjOhNZdxyu2KHLg11p9kFC=gtPNS0_UQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/26] compat_ioctl: cleanups
To: dgilbert@interlog.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org, linux-iio@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 IDE-ML <linux-ide@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>,
 sparclinux <sparclinux@vger.kernel.org>, linux1394-devel@lists.sourceforge.net,
 driverdevel <devel@driverdev.osuosl.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 Bluez mailing list <linux-bluetooth@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, qat-linux@intel.com,
 amd-gfx@lists.freedesktop.org,
 "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 linux-rtc@vger.kernel.org,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 ceph-devel <ceph-devel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Karsten Keil <isdn@linux-pingi.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 linux-integrity@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, linux-ppp@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 17, 2019 at 12:33 AM Douglas Gilbert <dgilbert@interlog.com> wrote:
>
> On 2019-04-16 4:19 p.m., Arnd Bergmann wrote:
> > Hi Al,
> >
> > It took me way longer than I had hoped to revisit this series, see
> > https://lore.kernel.org/lkml/20180912150142.157913-1-arnd@arndb.de/
> > for the previously posted version.
> >
> > I've come to the point where all conversion handlers and most
> > COMPATIBLE_IOCTL() entries are gone from this file, but for
> > now, this series only has the parts that have either been reviewed
> > previously, or that are simple enough to include.
> >
> > The main missing piece is the SG_IO/SG_GET_REQUEST_TABLE conversion.
> > I'll post the patches I made for that later, as they need more
> > testing and review from the scsi maintainers.
>
> Perhaps you could look at the document in this url:
>      http://sg.danny.cz/sg/sg_v40.html
>
> It is work-in-progress to modernize the SCSI generic driver. It
> extends ioctl(sg_fd, SG_IO, &pt_obj) to additionally accept the sg v4
> interface as defined in include/uapi/linux/bsg.h . Currently only the
> bsg driver uses the sg v4 interface. Since struct sg_io_v4 is all
> explicitly sized integers, I'm guessing it is immune "compat" problems.
> [I can see no reference to bsg nor struct sg_io_v4 in the current
> fs/compat_ioctl.c file.]

Ok, I've taken a brief look at your series now. Unfortunately it clashes
quite hard with my series, but it's probably for the better to have your
stuff get merged first.

A few (unsorted) comments from going through your patches:

- the added ioctls are all compatible when using the v4 structures
  and mostly don't need handlers for compat mode, but they need to be
  called from .compat_ioctl to actually be usable in compat mode.
  With my patches you get that.
- One exception for the v4 layout is the use of iovec pointers, as
  'struct iovec' is incompatible. We should probably merge the
  generic compat_import_iovec() into import_iovec() with a
  'in_compat_syscall()' check, which would be helpful in general.
  bsg.c does not iovec, so it is not affected by this at the moment,
  maybe it would be better to stay compatible with that and also
  not support them in sg.c?
- Is there a need for the new sg_ioctl_iosubmit/sg_ioctl_ioreceive
  to support the v3 structures? Those are /not/ compatible, so
  you need extra code to handle the v3-compat layout as well.
  Supporting only v4 would simplify this.
- the lack of changeset descriptions is a bit irritating and makes
  it much harder to understand what you are doing.
- try to keep patches that move code around separate from those
  that change it in any other way, for better reviewing.
- in "sg: preparation for request sharing", you seem to inadvertently
  change the size of "struct sg_extended_info", making it 4 bytes
  longer by adding two members.
- You should never use IS_ERR_OR_NULL() in normal code, that
  is just a sign of a bad API. Make each function have consistent
  error behavior.
- The "#if 0  /* temporary to shorten big patch */" trick breaks
  bisection, that is probably worse than the larger patch.
- The split access_ok()/__copy_from_user() has fallen out of
  favor because it has caused too many bugs in the past, just
  use the combined copy_from_user() instead.
- ktime_to_ns(ktime_get_with_offset(TK_OFFS_BOOT)) followed
  by a 64-bit division won't work on 32-bit machines, use
  ktime_get_boottime_ts64() instead.

> Other additions described in the that document are these new ioctls:
>    - SG_IOSUBMIT    ultimately to replace write(sg_fd, ...)
>    - SG_IORECEIVE              to replace read(sg_fd, ...)
>    - SG_IOABORT     abort SCSI cmd in progress; new functionality
>    - SG_SET_GET_EXTENDED   has associated struct sg_extended_info
>
> The first three take a pointer to a struct sg_io_hdr (v3 interface) or
> a struct sg_io_v4 object. Both objects start with a 32 bit integer:
> 'S' identifies the v3 interface while 'Q' identifies the v4 interface.

I think the magic character was a mistake in the original design,
just like versioned interfaces in general. If you are extending an
interface in an incompatible way, the normal way would be to
have separate command codes, like SG_IORECEIVE_V3
and SG_IORECEIVE_V4, if you absolutely have to maintain
compatiblity with the old interface (which I think you don't in
case of SG_IORECEIVE).

For SG_IO, I can see  why you want to support both the v3
and v4 structures plus the compat-v3 version, but I'd try to keep
them as separate as possible, and do something like

static int  sg_ctl_sg_io(struct file *filp, struct sg_device *sdp,
struct sg_fd *sfp,
                                 void __user *p)
{
       int ret;

      ret = sg_io_v4(filp, sdp, sfp, (struct sg_io_v4 __user *)p);

      if (ret != -ENOIOCTLCMD || !S_ENABLED(CONFIG_SG_IO_V3))
            return ret;

     if (in_compat_syscall())
           ret = sg_io_compat_(filp, sdp, sfp, (struct
compat_sg_io_hdr __user *)p);
     else
           ret = sg_io_v3(filp, sdp, sfp, (struct sg_io_hdr __user *)p);
}

In my patch series, I combined the latter two cases and used a shared
get_sg_io_hdr()/put_sg_io_hdr() helper as well as a wrapper for the iovec
issue.

> The SG_SET_GET_EXTENDED ioctl takes a pointer to a struct
> sg_extended_info object which contains explicitly sized integers so it
> may also be immune from "compat" problems. The ioctls section (13) of
> that document referenced above has a table showing how many "sets and
> gets" are hiding in the SG_SET_GET_EXTENDED ioctl.

Agreed, SG_SET_GET_EXTENDED looks fine to me from a compat
perspective.

I've uploaded my patches to
git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
compat-ioctl-v3
This contains both the series I posted here, and my scsi ioctl rework.

Maybe you can take the bits you need from that to handle the v3-compat
structures and integrate it into your series?

     Arnd
