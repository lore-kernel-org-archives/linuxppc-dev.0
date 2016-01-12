Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 934741A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 09:43:29 +1100 (AEDT)
Message-ID: <1452638609.14097.0.camel@ellerman.id.au>
Subject: Re: [PATCH 1/2] scripts/recordmcount.pl: support data in text
 section on powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>,
 amodra@gmail.com, ulrich.weigand@de.ibm.com
Date: Wed, 13 Jan 2016 09:43:29 +1100
In-Reply-To: <20160112104223.4317df9c@gandalf.local.home>
References: <1452600863-6294-1-git-send-email-mpe@ellerman.id.au>
 <20160112104223.4317df9c@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-01-12 at 10:42 -0500, Steven Rostedt wrote:
> On Tue, 12 Jan 2016 23:14:22 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> > From: Ulrich Weigand <ulrich.weigand@de.ibm.com>
> > 
> > If a text section starts out with a data blob before the first
> > function start label, disassembly parsing doing in recordmcount.pl
> > gets confused on powerpc, leading to creation of corrupted module
> > objects.
> > 
> > This was not a problem so far since the compiler would never create
> > such text sections.  However, this has changed with a recent change
> > in GCC 6 to support distances of > 2GB between a function and its
> > assoicated TOC in the ELFv2 ABI, exposing this problem.
> > 
> > There is already code in recordmcount.pl to handle such data blobs
> > on the sparc64 platform.  This patch uses the same method to handle
> > those on powerpc as well.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ulrich Weigand <ulrich.weigand@de.ibm.com>
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > ---
> >  scripts/recordmcount.pl | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > Steve can we get an ack for this one, to go via powerpc? cheers
> 
> Acked-by: Steven Rostedt <rostedt@goodmis.org>

Thanks.
