Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 93E6B1400C6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Apr 2014 22:43:15 +1000 (EST)
Date: Mon, 7 Apr 2014 14:42:59 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: cscope: issue with symlinks in
 tools/testing/selftests/powerpc/copyloops/
Message-ID: <20140407124259.GZ11339@book.gsilab.sittig.org>
References: <1396530975.4361.28.camel@localhost.localdomain>
 <20140407104216.GB5287@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140407104216.GB5287@hmsreliant.think-freely.org>
Cc: Yann Droneaud <ydroneaud@opteya.com>, linux-kernel@vger.kernel.org,
 Neil Horman <nhorman@users.sourceforge.net>,
 cscope-devel@lists.sourceforge.net, Anton Blanchard <anton@samba.org>,
 Hans-Bernhard Broeker <broeker@physik.rwth-aachen.de>,
 linuxppc-dev@lists.ozlabs.org,
 Hans-Bernhard =?iso-8859-1?Q?Br=F6ker?= <broeker@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-04-07 at 06:42 -0400, Neil Horman wrote:
> 
> On Thu, Apr 03, 2014 at 03:16:15PM +0200, Yann Droneaud wrote:
> > 
> > [ ... ]
> > 
> > cscope reports error when generating the cross-reference database:
> > 
> >     $ make ALLSOURCE_ARCHS=all O=./obj-cscope/ cscope
> >       GEN     cscope
> >     cscope: cannot find
> > file /home/ydroneaud/src/linux/tools/testing/selftests/powerpc/copyloops/copyuser_power7.S
> >     cscope: cannot find
> > file /home/ydroneaud/src/linux/tools/testing/selftests/powerpc/copyloops/memcpy_64.S
> >     cscope: cannot find
> > file /home/ydroneaud/src/linux/tools/testing/selftests/powerpc/copyloops/memcpy_power7.S
> >     cscope: cannot find
> > file /home/ydroneaud/src/linux/tools/testing/selftests/powerpc/copyloops/copyuser_64.S
> > 
> > And when calling cscope from ./obj-cscope/ directory, it reports errors
> > too.
> > 
> > Hopefully it doesn't stop it from working, so I'm still able to use
> > cscope to browse kernel sources.
> > 
> No, it won't stop it from working, it just won't search those files.  I don't
> recall exactly the reason, but IIRC there was a big discussion long ago about
> symlinks and our ability to support them (around version 1.94 I think).  We
> decided to not handle symlinks, as they would either point outside our search
> tree, which we didn't want to include, or would point to another file in the
> search tree, which made loading them pointless (as we would cover the search in
> the pointed file).

So there are valid reasons to not process those filesystem
entries.  Would it be useful to not emit the warnings then?  Or
to silent those warnings when the user knows it's perfectly legal
to skip those filesytem entries?  Like what you can do with the
ctags(1) command and its --links option.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
