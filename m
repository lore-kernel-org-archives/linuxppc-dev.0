Return-Path: <stephen@networkplumber.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 270102C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2013 01:11:10 +1000 (EST)
Received: by mail-pa0-f42.google.com with SMTP id kl13so901809pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 May 2013 08:11:08 -0700 (PDT)
Date: Wed, 1 May 2013 08:10:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH net-next] af_unix: fix a fatal race with bit fields
Message-ID: <20130501081054.267a7851@nehalam.linuxnetplumber.net>
In-Reply-To: <1367384672.11020.34.camel@edumazet-glaptop>
References: <1367370761.11020.22.camel@edumazet-glaptop>
 <20130501115103.58e40f37@kryten>
 <1367375060.11020.24.camel@edumazet-glaptop>
 <20130501035425.GD5221@bubble.grove.modra.org>
 <1367384672.11020.34.camel@edumazet-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Alan Modra <amodra@gmail.com>, netdev <netdev@vger.kernel.org>,
 Ambrose Feinstein <ambrose@google.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 30 Apr 2013 22:04:32 -0700
Eric Dumazet <eric.dumazet@gmail.com> wrote:

> On Wed, 2013-05-01 at 13:24 +0930, Alan Modra wrote:
> > On Tue, Apr 30, 2013 at 07:24:20PM -0700, Eric Dumazet wrote:
> > > 	li 11,1
> > > 	ld 0,0(9)
> > > 	rldimi 0,11,31,32
> > > 	std 0,0(9)
> > > 	blr
> > > 	.ident	"GCC: (GNU) 4.6.3"
> > > 
> > > You can see "ld 0,0(9)" is used : its a 64 bit load.
> > 
> > Yup.  This is not a powerpc64 specific problem.  See
> > http://gcc.gnu.org/bugzilla/show_bug.cgi?id=52080
> > Fixed in 4.8.0 and 4.7.3.
> 
> Ah thanks.
> 
> This seems a pretty serious issue, is it documented somewhere that
> ppc64, sparc64 and others need such compiler version ?
> 
> These kind of errors are pretty hard to find, its a pity to spend time
> on them.

There is a checkbin target inside arch/powerpc/Makefile
Shouldn't a check be added there to block building kernel with known
bad GCC versions?
