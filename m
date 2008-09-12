Return-Path: <prodyuth@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.227])
	by ozlabs.org (Postfix) with ESMTP id 546E1DDE0D
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 15:29:29 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so415114wra.1
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 22:29:27 -0700 (PDT)
Message-ID: <49c0ff980809112229n346209dcnf34002e052d101f3@mail.gmail.com>
Date: Thu, 11 Sep 2008 22:29:26 -0700
From: "prodyut hazarika" <prodyuth@gmail.com>
To: "Ilya Yanok" <yanok@emcraft.com>, linuxppc-dev@ozlabs.org, dzu@denx.de,
	wd@denx.de
Subject: Re: [PATCH] mm: fix ENTRIES_PER_PAGEPAGE overflow with 256KB pages
In-Reply-To: <20080912035006.GF22288@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
	<1221083587-8091-3-git-send-email-yanok@emcraft.com>
	<20080912035006.GF22288@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Thu, Sep 11, 2008 at 01:53:07AM +0400, Ilya Yanok wrote:
>> ENTRIES_PER_PAGEPAGE define in mm/shmem.c becomes zero if page size is
>> 256KB. This patch fixes this.
>
> This looks.. dubious.  You're making a change to generic code for a
> powerpc feature.  Plus it's not entirely clear that simply increasing
> the variable size is a good fix here.  Again, I think since this is a
> 256k page special case it will simplify things to get the <=64k stuff
> first, then handle this in another patch.

16KB/64KB patch would not really need any hacks like the 256KB. The
changes for 16/64KB can be totally hidden under 4xx specific files. So
I too think that this patch should be split into 2 patches.
