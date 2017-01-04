Return-Path: <mbenes@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttv6d1HL3zDqN4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 01:57:13 +1100 (AEDT)
Date: Wed, 4 Jan 2017 15:57:09 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>,
 Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>,
 Chris J Arges <chris.j.arges@canonical.com>,
 Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 15/15] livepatch: allow removal of a disabled patch
In-Reply-To: <21cb19ed5a44e876aeb830fdea1fad2c795a63f5.1481220077.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.20.1701041554270.6852@pobox.suse.cz>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <21cb19ed5a44e876aeb830fdea1fad2c795a63f5.1481220077.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> diff --git a/samples/livepatch/livepatch-sample.c b/samples/livepatch/livepatch-sample.c
> index bb61c65..0625f38 100644
> --- a/samples/livepatch/livepatch-sample.c
> +++ b/samples/livepatch/livepatch-sample.c
> @@ -89,7 +89,6 @@ static int livepatch_init(void)
>  
>  static void livepatch_exit(void)
>  {
> -	WARN_ON(klp_disable_patch(&patch));
>  	WARN_ON(klp_unregister_patch(&patch));
>  }

Btw, we remove the only call to klp_disable_patch() here. Maybe we can 
remove the function completely. It is not needed anywhere.

Miroslav
