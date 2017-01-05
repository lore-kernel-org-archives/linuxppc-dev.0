Return-Path: <mbenes@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tvMwR6vzCzDqJn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 20:35:03 +1100 (AEDT)
Date: Thu, 5 Jan 2017 10:34:57 +0100 (CET)
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
Subject: Re: [PATCH v3 13/15] livepatch: change to a per-task consistency model
In-Reply-To: <eeda3a8cf83bcbb569db4774c646ad739b8db415.1481220077.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.20.1701051031170.11208@pobox.suse.cz>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <eeda3a8cf83bcbb569db4774c646ad739b8db415.1481220077.git.jpoimboe@redhat.com>
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


> @@ -740,6 +809,14 @@ int klp_register_patch(struct klp_patch *patch)
>  		return -ENODEV;
>  
>  	/*
> +	 * Architectures without reliable stack traces have to set
> +	 * patch->immediate because there's currently no way to patch kthreads
> +	 * with the consistency model.
> +	 */
> +	if (!klp_have_reliable_stack() && !patch->immediate)
> +		return -ENOSYS;
> +

I think an error message (pr_err) would be appropriate here. 

$ insmod patch_1.ko
insmod: ERROR: could not insert module patch_1.ko: Function not implemented

is not helpful much :)

Miroslav
