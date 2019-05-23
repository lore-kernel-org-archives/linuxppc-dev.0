Return-Path: <SRS0=w0cb=TX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106C4C282DD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 May 2019 11:52:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8404321019
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 May 2019 11:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="S/Ixtxvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8404321019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 458ntm35k4zDqkJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 May 2019 21:52:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=brauner.io
 (client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com;
 envelope-from=christian@brauner.io; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=brauner.io header.i=@brauner.io header.b="S/Ixtxvc"; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 458nsC3K0xzDqdT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2019 21:51:26 +1000 (AEST)
Received: by mail-ed1-x544.google.com with SMTP id e24so8835694edq.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2019 04:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brauner.io; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=DxrwlFYynfpKWcnso1ASEMJy1QePVih8VzbqwCBkVwk=;
 b=S/Ixtxvc2rCTBfYbzQGiR2W1gdfRhjumXOGgdu6z5ZJn93UKfws6k6ee18PWPXzlDD
 34VNSUVl1F53yAPBVRFXImrLpe7sp1R3RWU6ueWOjvI6M8sU1iNP4im0skwaqTuQRUI3
 sJIA+/8okDM6QZIbI5rbYpsc3IcvP6Y2vT3m/sqm3D8RJWvk/pCqLrz+0Bww9JTf0nJB
 iYoTll8Maxv4hlDHAWHuPjFK29juGO9XVC/XtHjE4Ia93dBRDXi9FTYBwym4yIuDO3bU
 KpK6X02jkldIOkbi8+Z06PuUo/TGQJMyBrB/dAr/0sdCeNd8eYTqTlNcvQeNZ+q4dvvT
 hkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DxrwlFYynfpKWcnso1ASEMJy1QePVih8VzbqwCBkVwk=;
 b=Pyd/cDdQs/j6FlV+TZ/csAAVWxgTuv+OzUT/g3O+uVlYExEbBuqMkrh+YP4rvyYLHT
 Kr3XqrvJoBaCH+YWprh6D93ubJgwBaqG6zla4U6mrxw36eVwmZed4Q8TgoGNeYeaNdtl
 +CGHO5wnTT3HHwYmfGuueg0FEXWhlAohPCa+450jvxtcehArPEh5/sFxaR3kcd/VPga3
 Yz+nDFt/VTQvv9jyDdttbG15NywY7sC0tir7veoMlxE7yeGSTkBOpiEanoLR2rj7qxos
 W/65vsspm00fXwd9W/vhGzU2BiYF2qfY8VhpcmssgSknI0OeXY6aQelJgNZFLkiD6QCf
 nMZw==
X-Gm-Message-State: APjAAAXtbHR40PqZD0Mg3PZNYK2x5fazBfZpUvkvYH4+lAuMBhiqBPP/
 tPFyBcs5HFn0KjLvbOK6wO/4fg==
X-Google-Smtp-Source: APXvYqx7/y/DNnexBZOnXkDyT0N3tMuirzQAMafDXHp1AgKt73Se0dTImjP3o0mVoffNMpPelxEu9Q==
X-Received: by 2002:a50:84a1:: with SMTP id 30mr95678372edq.105.1558612282526; 
 Thu, 23 May 2019 04:51:22 -0700 (PDT)
Received: from brauner.io (178-197-142-46.pool.kielnet.net. [46.142.197.178])
 by smtp.gmail.com with ESMTPSA id
 h23sm4406908ejc.34.2019.05.23.04.51.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 23 May 2019 04:51:22 -0700 (PDT)
Date: Thu, 23 May 2019 13:51:20 +0200
From: Christian Brauner <christian@brauner.io>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v1 1/2] open: add close_range()
Message-ID: <20190523115118.pmscbd6kaqy37dym@brauner.io>
References: <20190522155259.11174-1-christian@brauner.io>
 <20190522165737.GC4915@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190522165737.GC4915@redhat.com>
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, ldv@altlinux.org,
 dhowells@redhat.com, linux-kselftest@vger.kernel.org,
 sparclinux@vger.kernel.org, shuah@kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, miklos@szeredi.hu, x86@kernel.org,
 torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, tkjos@android.com, arnd@arndb.de,
 jannh@google.com, linux-m68k@lists.linux-m68k.org, viro@zeniv.linux.org.uk,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, fweimer@redhat.com,
 linux-parisc@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, May 22, 2019 at 06:57:37PM +0200, Oleg Nesterov wrote:
> On 05/22, Christian Brauner wrote:
> >
> > +static struct file *pick_file(struct files_struct *files, unsigned fd)
> >  {
> > -	struct file *file;
> > +	struct file *file = NULL;
> >  	struct fdtable *fdt;
> >  
> >  	spin_lock(&files->file_lock);
> > @@ -632,15 +629,65 @@ int __close_fd(struct files_struct *files, unsigned fd)
> >  		goto out_unlock;
> >  	rcu_assign_pointer(fdt->fd[fd], NULL);
> >  	__put_unused_fd(files, fd);
> > -	spin_unlock(&files->file_lock);
> > -	return filp_close(file, files);
> >  
> >  out_unlock:
> >  	spin_unlock(&files->file_lock);
> > -	return -EBADF;
> > +	return file;
> 
> ...
> 
> > +int __close_range(struct files_struct *files, unsigned fd, unsigned max_fd)
> > +{
> > +	unsigned int cur_max;
> > +
> > +	if (fd > max_fd)
> > +		return -EINVAL;
> > +
> > +	rcu_read_lock();
> > +	cur_max = files_fdtable(files)->max_fds;
> > +	rcu_read_unlock();
> > +
> > +	/* cap to last valid index into fdtable */
> > +	if (max_fd >= cur_max)
> > +		max_fd = cur_max - 1;
> > +
> > +	while (fd <= max_fd) {
> > +		struct file *file;
> > +
> > +		file = pick_file(files, fd++);
> 
> Well, how about something like
> 
> 	static unsigned int find_next_opened_fd(struct fdtable *fdt, unsigned start)
> 	{
> 		unsigned int maxfd = fdt->max_fds;
> 		unsigned int maxbit = maxfd / BITS_PER_LONG;
> 		unsigned int bitbit = start / BITS_PER_LONG;
> 
> 		bitbit = find_next_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
> 		if (bitbit > maxfd)
> 			return maxfd;
> 		if (bitbit > start)
> 			start = bitbit;
> 		return find_next_bit(fdt->open_fds, maxfd, start);
> 	}

> 
> 	unsigned close_next_fd(struct files_struct *files, unsigned start, unsigned maxfd)
> 	{
> 		unsigned fd;
> 		struct file *file;
> 		struct fdtable *fdt;
> 	
> 		spin_lock(&files->file_lock);
> 		fdt = files_fdtable(files);
> 		fd = find_next_opened_fd(fdt, start);
> 		if (fd >= fdt->max_fds || fd > maxfd) {
> 			fd = -1;
> 			goto out;
> 		}
> 
> 		file = fdt->fd[fd];
> 		rcu_assign_pointer(fdt->fd[fd], NULL);
> 		__put_unused_fd(files, fd);
> 	out:
> 		spin_unlock(&files->file_lock);
> 
> 		if (fd == -1u)
> 			return fd;
> 
> 		filp_close(file, files);
> 		return fd + 1;
> 	}

Thanks, Oleg!

I kept it dumb and was about to reply that your solution introduces more
code when it seemed we wanted to keep this very simple for now.
But then I saw that find_next_opened_fd() already exists as
find_next_fd(). So it's actually not bad compared to what I sent in v1.
So - with some small tweaks (need to test it and all now) - how do we
feel about?:

/**
 * __close_next_open_fd() - Close the nearest open fd.
 *
 * @curfd: lowest file descriptor to consider
 * @maxfd: highest file descriptor to consider
 *
 * This function will close the nearest open fd, i.e. it will either
 * close @curfd if it is open or the closest open file descriptor
 * c greater than @curfd that
 * is smaller or equal to maxfd.
 * If the function found a file descriptor to close it will return 0 and
 * place the file descriptor it closed in @curfd. If it did not find a
 * file descriptor to close it will return -EBADF.
 */
static int __close_next_open_fd(struct files_struct *files, unsigned *curfd, unsigned maxfd)
{
        struct file *file = NULL;
	unsigned fd;
	struct fdtable *fdt;

	spin_lock(&files->file_lock);
	fdt = files_fdtable(files);
	fd = find_next_fd(fdt, *curfd);
	if (fd >= fdt->max_fds || fd > maxfd)
		goto out_unlock;

	file = fdt->fd[fd];
	rcu_assign_pointer(fdt->fd[fd], NULL);
	__put_unused_fd(files, fd);

out_unlock:
	spin_unlock(&files->file_lock);

	if (!file)
		return -EBADF;

	*curfd = fd;
	filp_close(file, files);
	return 0;
}

int __close_range(struct files_struct *files, unsigned fd, unsigned max_fd)
{
	if (fd > max_fd)
		return -EINVAL;

	while (fd <= max_fd) {
		if (__close_next_fd(files, &fd, maxfd))
			break;

		cond_resched();
		fd++;
	}

	return 0;
}

SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
		unsigned int, flags)
{
	if (flags)
		return -EINVAL;

	return __close_range(current->files, fd, max_fd);
}
