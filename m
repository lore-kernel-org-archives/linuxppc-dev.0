Return-Path: <SRS0=QDwo=C3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B671C43463
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2020 14:07:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CEA020717
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2020 14:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEA020717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BtFz04n0kzDqvK
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2020 00:07:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=212.227.126.133; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BtFp24tkHzDq9k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2020 23:59:52 +1000 (AEST)
Received: from mail-qv1-f54.google.com ([209.85.219.54]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MjgfT-1kmW533gGx-00lHpM for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep
 2020 15:59:47 +0200
Received: by mail-qv1-f54.google.com with SMTP id di5so2873344qvb.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2020 06:59:46 -0700 (PDT)
X-Gm-Message-State: AOAM532hZaCKsag3m9+YydhC+nwqyqBvSx4zhzSOXFaYXPHS1M8GQ/8R
 VJ2Gaa6m/QT5ersNOFftJIbkmhGjQ4ipahyzE0o=
X-Google-Smtp-Source: ABdhPJyPq7mySMvROlaNxuZFtqLj9tUV6q55niOILmDEkx6ztioH5FRFrOH6npOQU7X7q9Cy/nZY2UELvp9CUKm70dc=
X-Received: by 2002:a0c:b39a:: with SMTP id t26mr2701457qve.19.1600437585347; 
 Fri, 18 Sep 2020 06:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200918124533.3487701-1-hch@lst.de>
 <20200918124533.3487701-2-hch@lst.de>
 <20200918134012.GY3421308@ZenIV.linux.org.uk> <20200918134406.GA17064@lst.de>
In-Reply-To: <20200918134406.GA17064@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Sep 2020 15:59:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3_DL0T33e7CAuyRxgpRy8LaJO9h1sER7sebcX26hVVjA@mail.gmail.com>
Message-ID: <CAK8P3a3_DL0T33e7CAuyRxgpRy8LaJO9h1sER7sebcX26hVVjA@mail.gmail.com>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:J5znauqPu/gw3CIygMpF05gkNzhOU4wqyyQ1VdHtgGirsy+Z4yJ
 +ntf3hQkYMRna6+EmuQ8LdsrAMxEiZ3sV77P56z1QiEOKWtIubNutKNd+vL0OjkTSNxZ3Lg
 /MNfg3iE+kKYQ6UlC4Svxd4fWCsfy8lICF1qnD1tQok55ypaVuiRxwla/SO8inkdnc/tiD9
 WWbfQFlRqS4xce0UTXwGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EvdUfPhQkgg=:C6SLmKRG/L21nfA6vWbkdr
 dNQKNBbRWivPpJtpONYW3jn8adzKvmeIpOlO2UNbsw7wRZcDLFDRbAhRn1qe4GsV2TaIRwTxZ
 XMZWUsw/ElT2vR9Kw461dc8S2VzAPwNjt4d4037XYJt8eSKtk0PYdLvayHnN5qfMBeXQ/bvHh
 euFHEwxxYgadx6ls9zy8MFNxCMdatrkIgt6//T4TiJG5P5j/B5nw/qailDU+R8mVpgCCW4AvC
 JdU6J0sQXFG1xYz9+nT8oHM+HCwKPNNhh0JvKxmCzzzq/eRPhVKEHSC5A9zGaI1VNWPsX1BtM
 YDVTjFAWVAAg28hicciQsa6s70YxzFTsqeByqDVCeOTxYBsVt8un7l5+E84blrl8bvvR/no+T
 dnsG2lj5ALvcil79D+GKlLi7OSYBnHyD/trb+Loc18JsIUNngAAtfSrwqZSWsEWDv5FHymArG
 RwQ26xNjBajX1O3NlG1VR9mUBNiR6cbLykRTAQC5CkNecy2JjT/lt7xCnlcFnr9gUVI0/B8le
 qXbT8/4Y22DjP0p7psiTm8MZkSlckZUejfVLDsvRaTgE05xfTR3Ocig+VHQy3BjzUPiiK67bw
 c8J5S9PdSAM5T3SOmpcnuI9lNqMAkgJ7xxvdNIlWKCRPMiemPwp4wvoNQ3Ej297GXiG7Ys/X2
 8wxaIGbzG9B+LOVvKtUh89dCt1HF5z1wUlVGDei0CplKM1w5IN88o9UKt5b8VxxuhHLY6U+q4
 gdJ8AujYptzg3lzaAl1JWIjOSJINzLi+l96gFL/L8LkhejuXhtVG5LzaoUrNti10mK0ofarxZ
 GHjqbqUBImOF+tfPpGQCoWDYmv7SPU3nwSCTIKqoV98NJw+A1O742M4yQ/wyw1n3VptKKGMaa
 ELxn2eidpMrC/oqP2gJvsBz8NwoHROif/dSan9mHXt9NJjenVj9Txt8T9fo8SMNsPYtEs7/10
 UFz4TspkksjFCqYRKlcYl8NCILrGQQ7NZs7H2VqxtKD8oS5802R6F
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
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 linux-block <linux-block@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 io-uring@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jens Axboe <axboe@kernel.dk>, Parisc List <linux-parisc@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Sep 18, 2020 at 3:44 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Sep 18, 2020 at 02:40:12PM +0100, Al Viro wrote:
> > >     /* Vector 0x110 is LINUX_32BIT_SYSCALL_TRAP */
> > > -   return pt_regs_trap_type(current_pt_regs()) == 0x110;
> > > +   return pt_regs_trap_type(current_pt_regs()) == 0x110 ||
> > > +           (current->flags & PF_FORCE_COMPAT);
> >
> > Can't say I like that approach ;-/  Reasoning about the behaviour is much
> > harder when it's controlled like that - witness set_fs() shite...
>
> I don't particularly like it either.  But do you have a better idea
> how to deal with io_uring vs compat tasks?

Do we need to worry about something other than the compat_iovec
struct for now? Regarding the code in io_import_iovec(), it would
seem that can easily be handled by exposing an internal helper.
Instead of

#ifdef CONFIG_COMPAT
     if (req->ctx->compat)
            return compat_import_iovec(rw, buf, sqe_len, UIO_FASTIOV,
iovec, iter);
#endif
        return import_iovec(rw, buf, sqe_len, UIO_FASTIOV, iovec, iter);

This could do

    __import_iovec(rw, buf, sqe_len, UIO_FASTIOV, iovec,
                     iter, req->ctx->compat);

With the normal import_iovec() becoming a trivial wrapper around
the same thing:

ssize_t import_iovec(int type, const struct iovec __user * uvector,
                 unsigned nr_segs, unsigned fast_segs,
                 struct iovec **iov, struct iov_iter *i)
{
     return __import_iovec(type, uvector, nr_segs, fast_segs, iov,
              i, in_compat_syscall());
}


         Arnd
