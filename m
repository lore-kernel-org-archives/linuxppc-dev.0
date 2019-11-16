Return-Path: <SRS0=4rLT=ZI=vger.kernel.org=linux-m68k-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF3DC432C3
	for <linux-m68k@archiver.kernel.org>; Sat, 16 Nov 2019 00:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB1620748
	for <linux-m68k@archiver.kernel.org>; Sat, 16 Nov 2019 00:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfKPAiK (ORCPT <rfc822;linux-m68k@archiver.kernel.org>);
        Fri, 15 Nov 2019 19:38:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:43390 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfKPAiJ (ORCPT
        <rfc822;linux-m68k@lists.linux-m68k.org>);
        Fri, 15 Nov 2019 19:38:09 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVm5G-00041D-QH; Sat, 16 Nov 2019 00:37:02 +0000
Date:   Sat, 16 Nov 2019 00:37:02 +0000
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
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        dev@opencontainers.org, containers@lists.linux-foundation.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v16 02/12] namei: allow nd_jump_link() to produce errors
Message-ID: <20191116003702.GX26530@ZenIV.linux.org.uk>
References: <20191116002802.6663-1-cyphar@cyphar.com>
 <20191116002802.6663-3-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191116002802.6663-3-cyphar@cyphar.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-m68k-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-m68k.vger.kernel.org>
X-Mailing-List: linux-m68k@vger.kernel.org
Message-ID: <20191116003702.McgxEvzNl1Bb8PU-e59ecn0wvaGQxeTmDJ-Z8BLSeJM@z>

On Sat, Nov 16, 2019 at 11:27:52AM +1100, Aleksa Sarai wrote:
> +	error = nd_jump_link(&path);
> +	if (error)
> +		path_put(&path);

> +	error = nd_jump_link(&ns_path);
> +	if (error)
> +		path_put(&ns_path);

> +	error = nd_jump_link(&path);
> +	if (error)
> +		path_put(&path);

3 calls.  Exact same boilerplate in each to handle a failure case.
Which spells "wrong calling conventions"; it's absolutely clear
that we want that path_put() inside nd_jump_link().

The rule should be this: reference that used to be held in
*path is consumed in any case.  On success it goes into
nd->path, on error it's just dropped, but in any case, the
caller has the same refcounting environment to deal with.

If you need the same boilerplate cleanup on failure again and again,
the calling conventions are wrong and need to be fixed.

And I'm not sure that int is the right return type here, to be honest.
void * might be better - return ERR_PTR() or NULL, so that the value
could be used as return value of ->get_link() that calls that thing.
