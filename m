Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0A8202C008C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 12:00:39 +1000 (EST)
Message-ID: <1372730420.4820.21.camel@pasglop>
Subject: Re: linux-next: build failure after merge of the powerpc tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 02 Jul 2013 12:00:20 +1000
In-Reply-To: <20130702105415.8579055c3539bbb3e3cacfbc@canb.auug.org.au>
References: <20130702105415.8579055c3539bbb3e3cacfbc@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-07-02 at 10:54 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the powerpc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> fs/pstore/ftrace.c: In function 'pstore_ftrace_call':
> fs/pstore/ftrace.c:47:6: warning: passing argument 7 of 'psinfo->write_buf' makes integer from pointer without a cast [enabled by default]
>       sizeof(rec), psinfo);
>       ^
> fs/pstore/ftrace.c:47:6: note: expected 'size_t' but argument is of type 'struct pstore_info *'
> fs/pstore/ftrace.c:47:6: error: too few arguments to function 'psinfo->write_buf'
> 
> Caused by commit 6bbbca735936 ("pstore: Pass header size in the pstore
> write callback").
> 
> I have used the version from next-20130701 for today.

Interestingly enough I didn't see that when testing a x86_64 build, I
might have failed to test with ftrace enabled.

Aruna, please send a fix ASAP.

Cheers,
Ben.
