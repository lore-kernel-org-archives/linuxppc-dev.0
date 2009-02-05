Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B0882DDEF1
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 12:12:07 +1100 (EST)
Date: Thu, 5 Feb 2009 04:12:04 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Steven Rostedt <srostedt@redhat.com>
Subject: Re: [PATCH 2/3] powerpc: Make it possible to safely select
	CONFIG_FRAME_POINTER
Message-ID: <20090205011204.GA25628@oksana.dev.rtsoft.ru>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150838.GB30027@oksana.dev.rtsoft.ru>
	<1233793889.4612.33.camel@pasglop>
	<1233794154.16878.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1233794154.16878.20.camel@localhost.localdomain>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Ingo Molnar <mingo@elte.hu>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 04, 2009 at 07:35:54PM -0500, Steven Rostedt wrote:
> 
> On Thu, 2009-02-05 at 11:31 +1100, Benjamin Herrenschmidt wrote:
> > On Wed, 2009-02-04 at 18:08 +0300, Anton Vorontsov wrote:
> > > Remove -fno-omit-frame-pointer flag from CFLAGS.
> > > Remove -fno-omit-frame-pointer workarounds.
> > 
> > But what about -pg -requires -fno-omit-frame-pointer ?
> 
> I don't think it requires -fno-omit-frame-pointer. It is just
> incompatible with -fomit-frame-pointer.

Yep, -fno-omit-frame-poiner isn't needed for -pg.

I explained this in http://lkml.org/lkml/2009/2/3/342 :

| Ah...
|
| $ gcc -pg -fomit-frame-pointer -S c.c
| gcc: -pg and -fomit-frame-pointer are incompatible
|
| It's hard-coded in gcc, in the code that don't know about
| architecture details.
|
| But on PowerPC -O1 implies -fomit-frame-pointer, that is
|
| gcc -pg -O1 -fno-omit-frame-pointer
| and
| gcc -pg -O1
|
| produce different outputs. Thus -pg -O should be the same
| as "-pg -O -fomit-framepointer".

That is,

`gcc -O -pg -fno-omit-frame-pointer -S` output:

main:
        mflr 0
        stw 0,4(1)
        bl _mcount
        stwu 1,-16(1)
        mflr 0
        stw 0,20(1)
        stw 31,12(1)
        mr 31,1
        li 3,0
        lwz 11,0(1)
        lwz 0,4(11)
        mtlr 0
        lwz 31,-4(11)
        mr 1,11
        blr

^^ -pg works (_mcount call), but r31 wasted.

Now `gcc -O -pg -S` output:

main:
        mflr 0
        stw 0,4(1)
        bl _mcount
        stwu 1,-16(1)
        mflr 0
        stw 0,20(1)
        li 3,0
        lwz 0,20(1)
        mtlr 0
        addi 1,1,16
        blr

^^ _mcount is still there, and r31 isn't used.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
