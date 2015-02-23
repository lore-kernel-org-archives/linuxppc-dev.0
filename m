Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0230.hostedemail.com
 [216.40.44.230])
 by lists.ozlabs.org (Postfix) with ESMTP id B2C951A0C13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 17:42:17 +1100 (AEDT)
Message-ID: <1424673731.20944.24.camel@perches.com>
Subject: Re: [PATCH] cxl: Remove useless precision specifiers
From: Joe Perches <joe@perches.com>
To: Ian Munsie <imunsie@au1.ibm.com>
Date: Sun, 22 Feb 2015 22:42:11 -0800
In-Reply-To: <1424662685-sup-6648@delenn.ozlabs.ibm.com>
References: <1424438782-31545-1-git-send-email-linux@rasmusvillemoes.dk>
 <1424662685-sup-6648@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Neuling <mikey@neuling.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-02-23 at 14:40 +1100, Ian Munsie wrote:
> Excerpts from Rasmus Villemoes's message of 2015-02-21 00:26:22 +1100:
> > C99 says that a precision given as simply '.' with no following digits
> > or * should be interpreted as 0. The kernel's printf implementation,
> > however, treats this case as if the precision was omitted. C99 also
> > says that if both the precision and value are 0, no digits should be
> > printed. Even if the kernel followed C99 to the letter, I don't think
> > that would be particularly useful in these cases, so just remove the
> > precision specifiers.
> 
> Nice catch Rasmus, but I think a better patch would be one that adds the
> missing precision (%.16llx).

The kernel much more commonly uses %016llx

$ git grep "%016llx" | grep -v staging | wc -l
792
$ git grep "%\.16llx" | grep -v staging | wc -l
36
