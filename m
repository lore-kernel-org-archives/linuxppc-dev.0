Return-Path: <SRS0=9xw0=ZF=vger.kernel.org=linux-m68k-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECD5C17441
	for <linux-m68k@archiver.kernel.org>; Wed, 13 Nov 2019 02:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77974222CA
	for <linux-m68k@archiver.kernel.org>; Wed, 13 Nov 2019 02:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfKMCDn (ORCPT <rfc822;linux-m68k@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:03:43 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39298 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfKMCDm (ORCPT
        <rfc822;linux-m68k@lists.linux-m68k.org>);
        Tue, 12 Nov 2019 21:03:42 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUhzv-0008C3-Ic; Wed, 13 Nov 2019 02:03:07 +0000
Date:   Wed, 13 Nov 2019 02:03:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v15 5/9] namei: LOOKUP_IN_ROOT: chroot-like scoped
 resolution
Message-ID: <20191113020307.GB26530@ZenIV.linux.org.uk>
References: <20191105090553.6350-1-cyphar@cyphar.com>
 <20191105090553.6350-6-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105090553.6350-6-cyphar@cyphar.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-m68k-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-m68k.vger.kernel.org>
X-Mailing-List: linux-m68k@vger.kernel.org
Message-ID: <20191113020307.xBNdv4bzO9Ow4TwM84TaKcr-t0f9_WDZIn-lwmzrCGk@z>

On Tue, Nov 05, 2019 at 08:05:49PM +1100, Aleksa Sarai wrote:

> @@ -2277,12 +2277,20 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
>  
>  	nd->m_seq = read_seqbegin(&mount_lock);
>  
> -	/* Figure out the starting path and root (if needed). */
> -	if (*s == '/') {
> +	/* Absolute pathname -- fetch the root. */
> +	if (flags & LOOKUP_IN_ROOT) {
> +		/* With LOOKUP_IN_ROOT, act as a relative path. */
> +		while (*s == '/')
> +			s++;

Er...  Why bother skipping slashes?  I mean, not only link_path_walk()
will skip them just fine, you are actually risking breakage in this:
                if (*s && unlikely(!d_can_lookup(dentry))) {
                        fdput(f);
                        return ERR_PTR(-ENOTDIR);
                }
which is downstream from there with you patch, AFAICS.
