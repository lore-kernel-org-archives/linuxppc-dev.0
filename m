Return-Path: <SRS0=kVu9=TQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DA5C04AAF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 May 2019 15:30:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186B120657
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 May 2019 15:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="TH4z/rM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186B120657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 454b3b0CgpzDqZR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 May 2019 01:30:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=brauner.io
 (client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com;
 envelope-from=christian@brauner.io; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=brauner.io header.i=@brauner.io header.b="TH4z/rM7"; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 454b1x17rJzDqR3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2019 01:29:22 +1000 (AEST)
Received: by mail-ed1-x544.google.com with SMTP id m4so5817156edd.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2019 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brauner.io; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZqfBKUXmncS+f99++ptXSxdqupLw9zmhEoHFhOKQ3+w=;
 b=TH4z/rM7ErguN84LC3AmRg3JM/hVu0pzNCfG54H90jzb63FEyWpgQxI/RMgxJKMw0P
 YMcyNk31xsPD9o3Q8SwKVFbPkeg8kucRDIsE3yDY3iiXnyBwTwnYxeZvDW5/V+wBXU6a
 4Whkmp9tF7azl07xuKt/fN1RfMwR7c1B7epJGJ4YizDr1inzgV4yUswyquIaazuD7NSA
 +Y7PT7f4mQIjQrv4yQyYO9MGe0DD0FnBStZnFHo1gVuPfCi9qKCZU5pU6DsIxSnGA9Ik
 9SEOtQn5L4G4624dzeKPE3TTelvggQSyZJ+x/s6KcHf9L4yAiTiSgxh1JqlUq122MXzB
 4CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZqfBKUXmncS+f99++ptXSxdqupLw9zmhEoHFhOKQ3+w=;
 b=KSFUdSrjQOvOnqYJCEXKHs1rBnFyXz7wHyz5pYCnhErp5IyFZMaae01H9LAfk1JhKZ
 fzHyolpHWlr3fl9B9s94mF5AFxinwdBUFgfc2t1v4/YVrbINqBTrQWBRa/FVY5o7ittF
 Q/0wFwNGgaRua+ITDI3hnwrHrFc6qYESRWsc1CQxK0Ch3ofdzTzXnxY/DJEWVPWiqGTD
 p5uMwpv2h2axw/H3s8lgH5D1quYWJ7YkMHUP8WUisVEXF7C8Gdvj7mkArIKdwxv1Gtsw
 JOc1cme34N5RRb0jJky467pGErmD4t6sOf2TiiSsfI9uTcZ+GukgS/vMOydGg/7gar9B
 Vkkw==
X-Gm-Message-State: APjAAAV0k70YDlBLUTdfstndzSLwr2v3opYR9+c102JawQdtlPB4puc8
 NX4dXEGrppQbm1bCW+Ug4kr3Ng==
X-Google-Smtp-Source: APXvYqzND3qJO+X7rGwmXjyWOGo7yuQQOnxCqVFCr+1kxGCEKNbb6bF5poI+TQvkmuF3C5Oy1BVzkw==
X-Received: by 2002:a50:a886:: with SMTP id k6mr51048650edc.211.1558020559731; 
 Thu, 16 May 2019 08:29:19 -0700 (PDT)
Received: from brauner.io ([193.96.224.243])
 by smtp.gmail.com with ESMTPSA id b4sm1889513edf.7.2019.05.16.08.29.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 16 May 2019 08:29:19 -0700 (PDT)
Date: Thu, 16 May 2019 17:29:16 +0200
From: Christian Brauner <christian@brauner.io>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v1 1/2] pid: add pidfd_open()
Message-ID: <20190516152915.3t2wofeu3xsyhfbd@brauner.io>
References: <20190516135944.7205-1-christian@brauner.io>
 <20190516142659.GB22564@redhat.com>
 <20190516145607.j43xyj26k6l5vmbd@yavin>
 <20190516150611.GC22564@redhat.com>
 <20190516151202.hrawrx7hxllmz2di@yavin>
 <20190516152252.GD22564@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516152252.GD22564@redhat.com>
User-Agent: NeoMutt/20180716
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-mips@vger.kernel.org, dhowells@redhat.com, joel@joelfernandes.org,
 linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-api@vger.kernel.org, elena.reshetova@intel.com,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, dancol@google.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, serge@hallyn.com,
 linux-xtensa@linux-xtensa.org, keescook@chromium.org, arnd@arndb.de,
 jannh@google.com, linux-m68k@lists.linux-m68k.org, viro@zeniv.linux.org.uk,
 luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
 torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 luto@amacapital.net, ebiederm@xmission.com, linux-alpha@vger.kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, May 16, 2019 at 05:22:53PM +0200, Oleg Nesterov wrote:
> On 05/17, Aleksa Sarai wrote:
> >
> > On 2019-05-16, Oleg Nesterov <oleg@redhat.com> wrote:
> > > On 05/17, Aleksa Sarai wrote:
> > > > On 2019-05-16, Oleg Nesterov <oleg@redhat.com> wrote:
> > > > > On 05/16, Christian Brauner wrote:
> > > > > > With the introduction of pidfds through CLONE_PIDFD it is possible to
> > > > > > created pidfds at process creation time.
> > > > >
> > > > > Now I am wondering why do we need CLONE_PIDFD, you can just do
> > > > >
> > > > > 	pid = fork();
> > > > > 	pidfd_open(pid);
> > > >
> > > > While the race window would be exceptionally short, there is the
> > > > possibility that the child will die
> > >
> > > Yes,
> > >
> > > > and their pid will be recycled
> > > > before you do pidfd_open().
> > >
> > > No.
> > >
> > > Unless the caller's sub-thread does wait() before pidfd_open(), of course.
> > > Or unless you do signal(SIGCHILD, SIG_IGN).
> >
> > What about CLONE_PARENT?
> 
> I should have mentioned CLONE_PARENT ;)
> 
> Of course in this case the child can be reaped before pidfd_open(). But how often
> do you or other people use clone(CLONE_PARENT) ? not to mention you can trivially
> eliminate/detect this race if you really need this.
> 
> Don't get me wrong, I am not trying to say that CLONE_PIDFD is a bad idea.
> 
> But to me pidfd_open() is much more useful. Say, as a perl programmer I can easily
> use pidfd_open(), but not CLONE_PIDFD.

Right, but for a libc, service- or container manager CLONE_PIDFD is much
nicer when spawning processes quickly. :) I think both are very good to
have.

Thanks, Oleg. As always super helpful reviews. :)
Christian
