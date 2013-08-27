Return-Path: <paulus@ozlabs.org>
Date: Tue, 27 Aug 2013 19:03:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH] powerpc: Work around gcc miscompilation of __pa() on
 64-bit
Message-ID: <20130827090325.GA30336@iris.ozlabs.ibm.com>
References: <20130827060749.GA16462@drongo>
 <20130827071235.GQ3430@bubble.grove.modra.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130827071235.GQ3430@bubble.grove.modra.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 27, 2013 at 04:42:35PM +0930, Alan Modra wrote:
> On Tue, Aug 27, 2013 at 04:07:49PM +1000, Paul Mackerras wrote:
> > On 64-bit, __pa(&static_var) gets miscompiled by recent versions of
> > gcc as something like:
> > 
> >         addis 3,2,.LANCHOR1+4611686018427387904@toc@ha
> >         addi 3,3,.LANCHOR1+4611686018427387904@toc@l
> 
> I might argue that this isn't a miscompilation, since -mcmodel=medium
> assumes everything can be accessed within +/-2G of the toc pointer,

And there's the bug right there... the assumption that this number
that I want to compute is the address of something that can be
accessed.  It isn't, and gcc shouldn't treat it as such (not unless I
do something like subsequently casting it back to a pointer and
dereferencing that).

> but it's definitely a problem since gas and/or ld don't give an
> overflow error.  They would except for the fact that our ABI has a
> hole in it.

Well, that and the fact that the code in gcc that generates
instructions to compute addresses blindly uses addis; addi even when
the offset involved is way too large for that to possibly work.

Paul.
