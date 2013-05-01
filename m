Return-Path: <amodra@gmail.com>
Received: from mail-da0-x233.google.com (mail-da0-x233.google.com
 [IPv6:2607:f8b0:400e:c00::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 48F472C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 May 2013 13:54:36 +1000 (EST)
Received: by mail-da0-f51.google.com with SMTP id g27so520401dan.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 20:54:32 -0700 (PDT)
Date: Wed, 1 May 2013 13:24:25 +0930
From: Alan Modra <amodra@gmail.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH net-next] af_unix: fix a fatal race with bit fields
Message-ID: <20130501035425.GD5221@bubble.grove.modra.org>
References: <1367370761.11020.22.camel@edumazet-glaptop>
 <20130501115103.58e40f37@kryten>
 <1367375060.11020.24.camel@edumazet-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367375060.11020.24.camel@edumazet-glaptop>
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

On Tue, Apr 30, 2013 at 07:24:20PM -0700, Eric Dumazet wrote:
> 	li 11,1
> 	ld 0,0(9)
> 	rldimi 0,11,31,32
> 	std 0,0(9)
> 	blr
> 	.ident	"GCC: (GNU) 4.6.3"
> 
> You can see "ld 0,0(9)" is used : its a 64 bit load.

Yup.  This is not a powerpc64 specific problem.  See
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=52080
Fixed in 4.8.0 and 4.7.3.

-- 
Alan Modra
Australia Development Lab, IBM
