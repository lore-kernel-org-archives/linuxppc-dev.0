Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 26217DDDE6
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 06:53:11 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3891855wag
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 13:53:11 -0700 (PDT)
Message-ID: <fa686aa40709281352ka6040f6w44f7a6c0ea3efda9@mail.gmail.com>
Date: Fri, 28 Sep 2007 14:52:43 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: [PATCH 06/18] [POWERPC] Fix UARTLITE reg io for little-endian
	architectures (ie. microblaze)
In-Reply-To: <fa686aa40709281350y63475e93hd18e7da497c6f1b0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181704.18608.40317.stgit@trillian.cg.shawcable.net>
	<20070928203104.GC23749@lixom.net>
	<fa686aa40709281342h4f8ff3fdv265e8098d2da6f52@mail.gmail.com>
	<20070928204749.GD23749@lixom.net>
	<fa686aa40709281350y63475e93hd18e7da497c6f1b0@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/28/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 9/28/07, Olof Johansson <olof@lixom.net> wrote:
> > On Fri, Sep 28, 2007 at 02:42:32PM -0600, Grant Likely wrote:
> > > On 9/28/07, Olof Johansson <olof@lixom.net> wrote:
> > > > Also, I'm not sure you need to cast port->membase to void*, do you? The
> > > > math will still be right since it's declared as char *.
> > >
> > > membase is now defined as u32*, so the cast is needed.
> >
> > Hm, I must have looked at a stale tree.
>
> No, wait.  You're right.  It is a char*.  I'll drop the cast.

Wait, I'm wrong again... it's in/out_be32 that expects an (unsigned*).
 The compiler complains without the cast.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
