Return-Path: <SRS0=9qWD=TP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D03C04E53
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 14:22:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB352070D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 14:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="gAJyzptk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB352070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 453xbC2xpWzDqSt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 May 2019 00:22:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=brauner.io
 (client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com;
 envelope-from=christian@brauner.io; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=brauner.io header.i=@brauner.io header.b="gAJyzptk"; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 453xSW34LLzDqVS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2019 00:16:42 +1000 (AEST)
Received: by mail-ed1-x544.google.com with SMTP id a8so76722edx.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2019 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brauner.io; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=5teuJo4XSRrnL6XxnC+QODipuz2WCzByYGo45sEdpQE=;
 b=gAJyzptkeah2CnPVHf8ki6Ey+Aje7kt4hiLFQY/UoXftAeb5KMt9kDcge1dL70700f
 v4lzCF24qKMgoDDJqK48PCIsuOAEIEWh56QloYL0Zx1Ytcl8wEHGZj2FHlHTDjeh1xHN
 qgtG9Lh2tYpVWiUdw1UsD0iGHta3lP4Ta8QIkzIE14Ud+jGfSqHpCDEAvWIr2Z7unvQT
 7zkggOJrHmZj/c4eERJMnDK2ju7392d0B+Atitgv36pLJz4hMjFGB1lnPt+6SoqUGyah
 IPYOEdYPIgWXRHQq6puWtz6SFEJeqqmkoJuWNHfimIVIYgR96+2ydELKuFEvw/jF51Hq
 +B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=5teuJo4XSRrnL6XxnC+QODipuz2WCzByYGo45sEdpQE=;
 b=aa5TPVPB43Cfe5FL3X2Gz0td2tAGGiPExMIdaqwIUsCt6xYFP5cXm6b9pNKHLLTHlQ
 UseJ7qgNy/0sGJHcv1T2FW0yMuHjO7GeQ8hzHPwgcwfQmXkqshXXIKOeoiRmlAdvRU0A
 5qnlG2HdAq0UI3Nn/HWoBpr8RMX4xhrvkkKrzQ79hWkydXNTGPGlKTmcyeYSt8Ah1fIB
 QceKo5ZdTRbVk71YuPj/Ja18mBLw/MKJL/KfPxAZW5MUgia8lii40mTgUMJYjE8id8RT
 eW1j5YKF74AVaPhzwvTmU9NvTgG7Djvd5GF8fUaiyyxuHWT3j3SVzKu9+sLXfykIQ6Qt
 lVbg==
X-Gm-Message-State: APjAAAW7kdeggIoVQ0GeWRTDXiEMizXbwlK3xmYGBflas0m1MrzvIoiU
 atyqZhXci+5BuZY60IcMFB3PLw==
X-Google-Smtp-Source: APXvYqz/5w9Bko49z66nfUW8rJGtWbKGmV1irTYSDrNlaxrZSh+Ve4PPN0bCyixGXoTczpolwiOJ2g==
X-Received: by 2002:a50:8bbb:: with SMTP id m56mr44288042edm.230.1557929797459; 
 Wed, 15 May 2019 07:16:37 -0700 (PDT)
Received: from brauner.io ([178.19.218.101])
 by smtp.gmail.com with ESMTPSA id h13sm493114ejs.3.2019.05.15.07.16.35
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 15 May 2019 07:16:36 -0700 (PDT)
Date: Wed, 15 May 2019 16:16:35 +0200
From: Christian Brauner <christian@brauner.io>
To: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH 1/2] pid: add pidfd_open()
Message-ID: <20190515141634.lrc5ynllcmjr64mn@brauner.io>
References: <20190515100400.3450-1-christian@brauner.io>
 <4c5ae46657e1931a832def5645db61eb0bf1accd.camel@opteya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c5ae46657e1931a832def5645db61eb0bf1accd.camel@opteya.com>
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
 linux-kernel@vger.kernel.org, dhowells@redhat.com,
 linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-api@vger.kernel.org, elena.reshetova@intel.com,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, keescook@chromium.org, arnd@arndb.de,
 jannh@google.com, linux-m68k@lists.linux-m68k.org, viro@zeniv.linux.org.uk,
 luto@kernel.org, oleg@redhat.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 cyphar@cyphar.com, torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
 luto@amacapital.net, ebiederm@xmission.com, linux-alpha@vger.kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, May 15, 2019 at 04:00:20PM +0200, Yann Droneaud wrote:
> Hi,
> 
> Le mercredi 15 mai 2019 à 12:03 +0200, Christian Brauner a écrit :
> > 
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index 20881598bdfa..237d18d6ecb8 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -451,6 +452,53 @@ struct pid *find_ge_pid(int nr, struct
> > pid_namespace *ns)
> >  	return idr_get_next(&ns->idr, &nr);
> >  }
> >  
> > +/**
> > + * pidfd_open() - Open new pid file descriptor.
> > + *
> > + * @pid:   pid for which to retrieve a pidfd
> > + * @flags: flags to pass
> > + *
> > + * This creates a new pid file descriptor with the O_CLOEXEC flag set for
> > + * the process identified by @pid. Currently, the process identified by
> > + * @pid must be a thread-group leader. This restriction currently exists
> > + * for all aspects of pidfds including pidfd creation (CLONE_PIDFD cannot
> > + * be used with CLONE_THREAD) and pidfd polling (only supports thread group
> > + * leaders).
> > + *
> 
> Would it be possible to create file descriptor with "restricted"
> operation ?
> 
> - O_RDONLY: waiting for process completion allowed (for example)
> - O_WRONLY: sending process signal allowed

Yes, something like this is likely going to be possible in the future.
We had discussion around this. But mapping this to O_RDONLY and O_WRONLY
is not the right model. It makes more sense to have specialized flags
that restrict actions.

> 
> For example, a process could send over a Unix socket a process a pidfd,
> allowing this to only wait for completion, but not sending signal ?
> 
> I see the permission check is not done in pidfd_open(), so what prevent
> a user from sending a signal to another user owned process ?

That's supposed to be possible. You can do the same right now already
with pids. Tools like LMK need this probably very much.
Permission checking for signals is done at send time right now.
And if you can't signal via a pid you can't signal via a pidfd as
they're both subject to the same permissions checks.

> 
> If it's in pidfd_send_signal(), then, passing the socket through
> SCM_RIGHT won't be useful if the target process is not owned by the
> same user, or root.
> 
> > + * Return: On success, a cloexec pidfd is returned.
> > + *         On error, a negative errno number will be returned.
> > + */
> > +SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
> > +{
> > +	int fd, ret;
> > +	struct pid *p;
> > +	struct task_struct *tsk;
> > +
> > +	if (flags)
> > +		return -EINVAL;
> > +
> > +	if (pid <= 0)
> > +		return -EINVAL;
> > +
> > +	p = find_get_pid(pid);
> > +	if (!p)
> > +		return -ESRCH;
> > +
> > +	rcu_read_lock();
> > +	tsk = pid_task(p, PIDTYPE_PID);
> > +	if (!tsk)
> > +		ret = -ESRCH;
> > +	else if (unlikely(!thread_group_leader(tsk)))
> > +		ret = -EINVAL;
> > +	else
> > +		ret = 0;
> > +	rcu_read_unlock();
> > +
> > +	fd = ret ?: pidfd_create(p);
> > +	put_pid(p);
> > +	return fd;
> > +}
> > +
> >  void __init pid_idr_init(void)
> >  {
> >  	/* Verify no one has done anything silly: */
> 
> Regards.
> 
> -- 
> Yann Droneaud
> OPTEYA
> 
> 
