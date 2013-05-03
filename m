Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F3D662C00D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 00:14:24 +1000 (EST)
Received: by mail-pa0-f50.google.com with SMTP id fb10so944738pad.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 May 2013 07:14:22 -0700 (PDT)
Message-ID: <1367590455.29805.30.camel@edumazet-glaptop>
Subject: Re: [PATCH net-next] af_unix: fix a fatal race with bit fields
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Alan Modra <amodra@gmail.com>
Date: Fri, 03 May 2013 07:14:15 -0700
In-Reply-To: <20130503013136.GN5221@bubble.grove.modra.org>
References: <1367370761.11020.22.camel@edumazet-glaptop>
 <20130501115103.58e40f37@kryten>
 <1367375060.11020.24.camel@edumazet-glaptop>
 <20130501035425.GD5221@bubble.grove.modra.org>
 <1367384672.11020.34.camel@edumazet-glaptop>
 <20130503013136.GN5221@bubble.grove.modra.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: netdev <netdev@vger.kernel.org>, Ambrose Feinstein <ambrose@google.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-05-03 at 11:01 +0930, Alan Modra wrote:
> On Tue, Apr 30, 2013 at 10:04:32PM -0700, Eric Dumazet wrote:
> > These kind of errors are pretty hard to find, its a pity to spend time
> > on them.
> 
> Well, yes.  From the first comment in gcc PR52080.  "For the following
> testcase we generate a 8 byte RMW cycle on IA64 which causes locking
> problems in the linux kernel btrfs filesystem."
> 
> Did someone fix btrfs, but not check other kernel locks?  Having now
> hit the same problem again, have you checked that other kernel locks
> don't have adjacent bit fields in the same 64-bit word?  And comment
> the struct to ensure someone doesn't optimize those unsigned chars
> back to bit fields.

Not only spinlock, but atomic_t followed by bit fields.

BTW, if a spinlock is followed by bit fields, but bit fields
only changed when this spinlock is held, there is no problem, unless
spinlock is a ticket spinlock.

In af_unix, bug happens because the bit fields were changed without
spinlock being held (another global spinlock is used instead)

(ppc64 doesnt use ticket spinlocks yet)
