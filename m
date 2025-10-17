Return-Path: <linuxppc-dev+bounces-12997-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D70ECCD195
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Oct 2025 10:36:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cp1TC0Mfrz2yMh;
	Fri, 17 Oct 2025 21:36:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760697390;
	cv=none; b=FxIWpD3XOf0s/HjCaDirtERK7jiiiZnENKdz9nnRreWx3zKGgFZLJy8wjar+PbgUZCpKTfKUpDqnZbQzKcsueL5KRDLJsRR7uFzN70v0sjFDGHQCUvUU4ehA+PreZruCE7g/ioVz01z/1ViepS4l/Xp+kmtQqEi9w6K+y1Xzx4ZZ3bVV/bYijQVULpjU+caj8pmcjlHgmKVpMP9t0BRvGv3aVLJRgOpe2Vfn4wA7VGnpCA0TZHu8Bek1LL/zwr37mLKjlV+AbLvdbDXEEKGl+U4pxCpIQtEkmbSE95XuEsFgyP2QtlM9KDgOQaqwK3wZgD01tgtP4f7jjgUfAlS1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760697390; c=relaxed/relaxed;
	bh=0hEYjK4XGVjCrvoOJeg0ZEh8+ica9r/qK/NZKGu0EA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3loh73h9HzCZOXjQe19T6aFLKNkJFcdfH7JtWN57JJBSQP89PrQR7Cv8Xfs3/pCR3ydgHkzVl55PTEAJEbwSSU99O/d+372EXOiFUeAufZ+f7yVUyvFz0sPoh0qeEKTkiTppndqMs+NaGkKRNyz9+xBmXNI5Eo6eSveE5l7l8bT7RgWil7ARosAdmGxQ8lfO5q5m7lY672RFxy+4aje+BCMK9lsOuY9jIuBfQaQGKrg2mAIJOLBxFc1RiNOZ/Kj0XVyBTs3jDGCxnomQuSYxBFxnlAifbYl6/iY+Vgx8aYeab4P5zCzEUme0BAA4rfUAybnV278ch2lfbYi/EoRFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cp1T42JRLz2xQ5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2025 21:36:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0hEYjK4XGVjCrvoOJeg0ZEh8+ica9r/qK/NZKGu0EA4=; b=fWi1v8hNQkssTp7wPTCPBDiNCW
	tjfosPU8LE2dZl3bBZZN83/L6douPhSRNHcYuF//L/0kQ6A3xLfHaa9fw9YSKULC9TDbDeBzFd5QT
	o5Y82LuzrMqrLzagAtt7nAxLS5vsJ06A9OcTR+2If2BEi6ybOAste9RRdfttxtW/w32Vs6JeNYEA9
	OfmnYJcY3uH2+LkO4EeXq9GrtctUlvK8lELPMnbD2ITa7k/xEDDTaGg4sB1quZswTO2o5KohK6S8z
	XGmg8eH28de1pujpSKSj+enhHUebEceGs0B++WfyKTTQuwVClbwH0B4LxCPim6iwiepl0M2k279wY
	LdnPU2uA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9hoR-00000007TnX-3lDP;
	Fri, 17 Oct 2025 10:36:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E92A630023C; Fri, 17 Oct 2025 12:35:54 +0200 (CEST)
Date: Fri, 17 Oct 2025 12:35:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [patch V3 12/12] select: Convert to scoped masked user access
Message-ID: <20251017103554.GY4067720@noisy.programming.kicks-ass.net>
References: <20251017085938.150569636@linutronix.de>
 <20251017093030.570048808@linutronix.de>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093030.570048808@linutronix.de>

On Fri, Oct 17, 2025 at 12:09:18PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Replace the open coded implementation with the scoped masked user access
> guard.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> ---
> V3: Adopt to scope changes
> ---
>  fs/select.c |   12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> ---
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -776,17 +776,13 @@ static inline int get_sigset_argpack(str
>  {
>  	// the path is hot enough for overhead of copy_from_user() to matter
>  	if (from) {
> -		if (can_do_masked_user_access())
> -			from = masked_user_access_begin(from);
> -		else if (!user_read_access_begin(from, sizeof(*from)))
> -			return -EFAULT;
> -		unsafe_get_user(to->p, &from->p, Efault);
> -		unsafe_get_user(to->size, &from->size, Efault);
> -		user_read_access_end();
> +		scoped_masked_user_rw_access(from, Efault) {

Should this not be: scoped_masked_user_read_access() ?

> +			unsafe_get_user(to->p, &from->p, Efault);
> +			unsafe_get_user(to->size, &from->size, Efault);
> +		}
>  	}
>  	return 0;
>  Efault:
> -	user_read_access_end();
>  	return -EFAULT;
>  }
>  
> 

