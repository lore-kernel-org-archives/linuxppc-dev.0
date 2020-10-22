Return-Path: <SRS0=xaUg=D5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00544C4363A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2020 09:16:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7337222E9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2020 09:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7337222E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CH1vg1tVwzDqYK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2020 20:16:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=82.165.159.5; helo=mout-xforward.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout-xforward.kundenserver.de (mout-xforward.kundenserver.de
 [82.165.159.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CH1sg3GwrzDqDS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2020 20:15:02 +1100 (AEDT)
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MStKw-1kzjHt0uMw-00UIoc for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct
 2020 11:14:55 +0200
Received: by mail-qv1-f42.google.com with SMTP id s1so492975qvm.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2020 02:14:54 -0700 (PDT)
X-Gm-Message-State: AOAM531v+TD+BsRoNAhxb/FFR2rz+H91hIvvAbQmS8t6eE7jFJq9xl5F
 WLOFoolG3WbIlsnMlsRB3hAhEMLAafG6RADYQjY=
X-Google-Smtp-Source: ABdhPJyTQBP0dRJbJWfua3xJHbrzKFctWdjW5mWFM7znxD+V4Hq2X1+XUh9kTr1iPtXJJ6khyzLRdADy4UPQw27hWss=
X-Received: by 2002:ad4:4203:: with SMTP id k3mr1295968qvp.8.1603358093425;
 Thu, 22 Oct 2020 02:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200925045146.1283714-1-hch@lst.de>
 <20200925045146.1283714-3-hch@lst.de>
 <20201021161301.GA1196312@kroah.com>
 <20201021233914.GR3576660@ZenIV.linux.org.uk>
 <20201022082654.GA1477657@kroah.com>
In-Reply-To: <20201022082654.GA1477657@kroah.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Oct 2020 11:14:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2h1iDaqnji00jtKS8ER2KKL5Sd14BsYo5mu8E-NM7D6g@mail.gmail.com>
Message-ID: <CAK8P3a2h1iDaqnji00jtKS8ER2KKL5Sd14BsYo5mu8E-NM7D6g@mail.gmail.com>
Subject: Re: Buggy commit tracked to: "Re: [PATCH 2/9] iov_iter: move
 rw_copy_check_uvector() into lib/iov_iter.c"
To: Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:BeeWGPXuRvg147a9tUL4x7YUTvAPAsCnou/CcUgndt6+tgUpaHk
 IH88guCFyqc8ntmaDjjSOPD2MR04JV/P3VwgERUlM/S3U4IAlOOZrDq+nxa5YYzfmdgwn+R
 XwK7Z4/mGbHLi7APOq1Lo8mmuui0tzaxgM9GAhUc502FAK4K2knEaqyfVrXpb3bMr0M2gcu
 DC6HftSLR6UxGqfXTN9Uw==
X-UI-Out-Filterresults: junk:10;V03:K0:+lfnhZTqoYU=:v2jKl02qpnRxX/+tTFOoV2Sv
 wQObLrJeGg9gOVEjmMl7WBof2SYYvz3vrrt9u1R6xmOFOAzyHSk1G2fw1O7+34G30YinQhq6F
 QcT+Ts6BehOQl9QByECfonqgl4LkgaDpX4qUtsGVW21N8zQQmXy7W4TJ7veNonmypxxFDRCgA
 QW++gQCwjrLJq/yeOc7/xoV+7Apwd5z5t4gxqjp9DNdvs/C49+OIIMc1KC0PJVXSJuspGfVqc
 WkzjoENIMOzfLzn5NR7kH+Lf1N9c+fl6NZq3X4/tTkuv6RMhPzIvENJx/B9wLtUxFunA68N9K
 XzcKtNoHUogSpbneoIcxCmZGiM3iri1Ab36jUdAsPyyfaY8XlxUMavuOr1EaPP0otL3AEMQfi
 46uKHBsWsEF8S9Cnj8+XjMPJkJu2amx86/3kcqqCO9FOixXz1TqGhI1Beq5mtatEtiZ6KLKp9
 gZva4YcCT2Jat5jZH5hBDwIQB51SGxBxImjuOYkRWSu+9LkyojrRdKpWYOJ52+2vtG2u2bEp4
 LJXC5QUCgANzwoWpmFTKdUjTFKJ7EgPln4U5mpB0mTwhPzkZFTsMSvPNzpGFYSPZogrTLEXK8
 G5HLN1BeqUJ8jpZ36+V45reQOfkre3yyWeo5ME1TpnUJAjWSpx8xag==
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
Cc: linux-aio <linux-aio@kvack.org>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 David Howells <dhowells@redhat.com>, Linux-MM <linux-mm@kvack.org>,
 keyrings@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 Android Kernel Team <kernel-team@android.com>,
 linux-block <linux-block@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 io-uring@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jens Axboe <axboe@kernel.dk>, Parisc List <linux-parisc@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 David Laight <David.Laight@aculab.com>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 22, 2020 at 10:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Oct 22, 2020 at 12:39:14AM +0100, Al Viro wrote:
> > On Wed, Oct 21, 2020 at 06:13:01PM +0200, Greg KH wrote:
> > > On Fri, Sep 25, 2020 at 06:51:39AM +0200, Christoph Hellwig wrote:
> > >
> > > I can't really figure out what the regression is, only that this commit
> > > triggers a "large Android system binary" from working properly.  There's
> > > no kernel log messages anywhere, and I don't have any way to strace the
> > > thing in the testing framework, so any hints that people can provide
> > > would be most appreciated.
> >
> > It's a pure move - modulo changed line breaks in the argument lists
> > the functions involved are identical before and after that (just checked
> > that directly, by checking out the trees before and after, extracting two
> > functions in question from fs/read_write.c and lib/iov_iter.c (before and
> > after, resp.) and checking the diff between those.
> >
> > How certain is your bisection?
>
> The bisection is very reproducable.
>
> But, this looks now to be a compiler bug.  I'm using the latest version
> of clang and if I put "noinline" at the front of the function,
> everything works.
>
> Nick, any ideas here as to who I should report this to?
>
> I'll work on a fixup patch for the Android kernel tree to see if I can
> work around it there, but others will hit this in Linus's tree sooner or
> later...

I see that Christoph rewrote the function again in bfdc59701d6d
("iov_iter: refactor rw_copy_check_uvector and import_iovec"),
do you know if the current mainline version is also affected?

Do you know if it happens across multiple architectures or might
be specific to either x86 or arm64?

https://bugs.llvm.org/ is obviously the place for reporting the
issue if it does turn out to be a bug in clang, but that requires
a specific thing going wrong in the output.

One idea I have for debugging it is to sprinkle the inlined
function with lots of barrier()s to prevent a lot of the optimizations.
If that solves the issue, you can bisect through those until you
find one barrier that makes the difference between working and
broken and then look at diff of the assembler output.

        Arnd
