Return-Path: <SRS0=Fnpn=NH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC1BC46475
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 11:45:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4ED20856
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 11:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORZKyNPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4ED20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hzZ75l4CzF12l
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 22:45:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ORZKyNPn";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::141; helo=mail-lf1-x141.google.com;
 envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ORZKyNPn"; 
 dkim-atps=neutral
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hY8K504lzF3Hg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2018 05:54:57 +1100 (AEDT)
Received: by mail-lf1-x141.google.com with SMTP id w16-v6so1696830lfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=H3/rtYUf+SrLjFlYeukVasmyKDPkiWYtZfhjXv3OPmY=;
 b=ORZKyNPnrPVezXgJkrrMYib2bo794VdzE+HII45gV+qO2mjSGn9YnuP5cqCL19jn/u
 Xyi0xxsFBR1uDM2MykgB8x/ZScq6i2uMOH8HOr3ET7lC5veriVMDBfxe/gc5pKKVnCtX
 fywm6LYRp6L6p3zwb1vQlsAg2z0g281Js8JbOoK1Yqgqbu3X2vUnhrKnKm9wvmHC0YiY
 nYlAlrlOaA9t5S8EUMGmr9cKPHPKxcah26/UTR8SY8oZRachI4PbdiYbQ0zaDlsrfWiz
 qeK2IQ1c8ps0o0tCdAskHs795nATXMx+FfIswZNRPhB5oSjMcn7E/tuoNjcnPGRLv43W
 nUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=H3/rtYUf+SrLjFlYeukVasmyKDPkiWYtZfhjXv3OPmY=;
 b=TEHIEeLR6Ct9bDU1anaOEST8v4hZmKVl+VB3PQ8HUmnuKx+xhyPsvuxwxKmI3CrriH
 hkwh/EQ/vti9r0brBwMdgSp+3ly/11pXmWooHG1FUR7YwOeegn0Q1uDD0Y1Nq1R5nAGN
 kxuoSoy2fQB78tfdj9Ba85huw6IKmb7TTazrQvWwNzBoHlzCs1hqhePYEK8HOgkscvzG
 g/qaAQMb/4CnTw/8bPTc72gbtfd4ClqWwW4TjGyYLh6JsvjOZf/ALo7ONOtxLljKHAm8
 JJpPHhJCznvBYym2LsggP2nHRU6HBxMABxK5eoNVFHxukYrSLI8Ch49GQHCWKh8dfPLP
 Jzhw==
X-Gm-Message-State: AGRZ1gLNrdd6W3eb2zABPf3BzJuechGmDyi5UnhCBPnW9FknkEsLWjY1
 Yaw+3rKMou/gkyKrfZ+PSsQ+qkiFvfsuYdnU8jM=
X-Google-Smtp-Source: AJdET5eqPpX8HxT50dGk9bbcjc74e0WMlZcU+88c+0VCXcRLVWOTwkDKaj9VNAImwKujSCZAVQT2mqvr7w/YH3sxR0o=
X-Received: by 2002:a19:4bc9:: with SMTP id y192mr2911291lfa.49.1540580094890; 
 Fri, 26 Oct 2018 11:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181026172549.3628-1-colin.king@canonical.com>
 <CANiq72nFZS=3KGaQpGjRbprh8HTBiTcSpxScE2uacDmg-xqDGA@mail.gmail.com>
 <20181026184009.GV25444@bombadil.infradead.org>
 <CANiq72m-2FU7ioqj9sqsfWk4nSp2FO9S_8kYcbnGReXNAXYM2w@mail.gmail.com>
In-Reply-To: <CANiq72m-2FU7ioqj9sqsfWk4nSp2FO9S_8kYcbnGReXNAXYM2w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 26 Oct 2018 20:54:43 +0200
Message-ID: <CANiq72=4KUL60=_T_VEUZmjoRFkuRmT5WCfbXO9mJ5bZoVgZ+Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation: fix spelling mistake, EACCESS -> EACCES
To: Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 27 Oct 2018 22:38:08 +1100
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
Cc: kernel-janitors@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Dave Airlie <airlied@linux.ie>, linuxppc-dev@lists.ozlabs.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 maarten.lankhorst@linux.intel.com, linux-kernel <linux-kernel@vger.kernel.org>,
 maxime.ripard@bootlin.com, jk@ozlabs.org, colin.king@canonical.com,
 sean@poorly.run
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 26, 2018 at 8:53 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Oct 26, 2018 at 8:40 PM Matthew Wilcox <willy@infradead.org> wrot=
e:
> >
> > On Fri, Oct 26, 2018 at 08:20:12PM +0200, Miguel Ojeda wrote:
> > > On Fri, Oct 26, 2018 at 7:27 PM Colin King <colin.king@canonical.com>=
 wrote:
> > > >
> > > > From: Colin Ian King <colin.king@canonical.com>
> > > >
> > > > Trivial fix to a spelling mistake of the error access name EACCESS,
> > > > rename to EACCES
> > >
> > > ? It is not a typo, it is the name of the error (POSIX). Same thing
> > > for the rest of the patches.
> >
> > Are you sure?  From open(2):
> >
> >        EACCES The  requested access to the file is not allowed, or sear=
ch per=E2=80=90
> >               mission is denied for one of the directories in the path =
 prefix
> >               of  pathname,  or the file did not exist yet and write ac=
cess to
> >               the parent directory is not  allowed.   (See  also  path_=
resolu=E2=80=90
> >               tion(7).)
> >
> > include/uapi/asm-generic/errno-base.h:#define   EACCES          13     =
 /* Permission denied */
>
> I thought you were doing the reverse change. Never mind! :-)
>
> (Btw, the POSIX reference is
> http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html#tag=
_13_09,
> in case you want to include it or are curious)

Sorry Matthew, thought I was answering to Colin. I should go to rest.

Cheers,
Miguel
