Return-Path: <amodra@gmail.com>
Received: from mail-pb0-x22e.google.com (mail-pb0-x22e.google.com
 [IPv6:2607:f8b0:400e:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 544362C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 11:31:49 +1000 (EST)
Received: by mail-pb0-f46.google.com with SMTP id rq8so630877pbb.33
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 May 2013 18:31:45 -0700 (PDT)
Date: Fri, 3 May 2013 11:01:36 +0930
From: Alan Modra <amodra@gmail.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH net-next] af_unix: fix a fatal race with bit fields
Message-ID: <20130503013136.GN5221@bubble.grove.modra.org>
References: <1367370761.11020.22.camel@edumazet-glaptop>
 <20130501115103.58e40f37@kryten>
 <1367375060.11020.24.camel@edumazet-glaptop>
 <20130501035425.GD5221@bubble.grove.modra.org>
 <1367384672.11020.34.camel@edumazet-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367384672.11020.34.camel@edumazet-glaptop>
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

On Tue, Apr 30, 2013 at 10:04:32PM -0700, Eric Dumazet wrote:
> These kind of errors are pretty hard to find, its a pity to spend time
> on them.

Well, yes.  From the first comment in gcc PR52080.  "For the following
testcase we generate a 8 byte RMW cycle on IA64 which causes locking
problems in the linux kernel btrfs filesystem."

Did someone fix btrfs, but not check other kernel locks?  Having now
hit the same problem again, have you checked that other kernel locks
don't have adjacent bit fields in the same 64-bit word?  And comment
the struct to ensure someone doesn't optimize those unsigned chars
back to bit fields.

-- 
Alan Modra
Australia Development Lab, IBM
