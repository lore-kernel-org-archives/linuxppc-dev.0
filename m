Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 599E0B6F5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 17:09:35 +1000 (EST)
Subject: Re: linux-next: build failure after merge of the final tree
	(powerpc tree related)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20110630163659.374db7f9.sfr@canb.auug.org.au>
References: <20110630163659.374db7f9.sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 30 Jun 2011 17:09:21 +1000
Message-ID: <1309417761.14501.206.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-06-30 at 16:36 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the final tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> drivers/tty/hvc/hvsi.c:701:12: error: conflicting types for 'hvsi_put_chars'
> arch/powerpc/include/asm/hvsi.h:92:12: note: previous declaration of 'hvsi_put_chars' was here
> drivers/tty/hvc/hvsi.c:736:12: error: conflicting types for 'hvsi_open'
> arch/powerpc/include/asm/hvsi.h:86:12: note: previous declaration of 'hvsi_open' was here
> drivers/tty/hvc/hvsi.c:802:13: error: conflicting types for 'hvsi_close'
> arch/powerpc/include/asm/hvsi.h:87:13: note: previous declaration of 'hvsi_close' was here
> drivers/tty/hvc/hvsi.c:1083:19: error: conflicting types for 'hvsi_init'
> arch/powerpc/include/asm/hvsi.h:81:13: note: previous declaration of 'hvsi_init' was here
> 
> Caused by commit 17bdc6c0e979 ("powerpc/pseries: Move hvsi support into a
> library").
> 
> I have reverted that commit for today.

Ooops, that seems to be entirely my fault, not sure what happened, I
might have merged the wrong patch version (I had some problem locally
with screwing up the git repo where those patches were originally).

I'll push a fix tomorrow.

Cheers,
Ben.
