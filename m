Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id ABB092C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 18:21:30 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 31411-10 for <linuxppc-dev@lists.ozlabs.org>;
 Fri,  3 May 2013 09:21:19 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH net-next] af_unix: fix a fatal race with bit fields
Date: Fri, 3 May 2013 09:20:21 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7222@saturn3.aculab.com>
In-Reply-To: <20130503013136.GN5221@bubble.grove.modra.org>
References: <1367370761.11020.22.camel@edumazet-glaptop>
 <20130501115103.58e40f37@kryten> <1367375060.11020.24.camel@edumazet-glaptop>
 <20130501035425.GD5221@bubble.grove.modra.org>
 <1367384672.11020.34.camel@edumazet-glaptop>
 <20130503013136.GN5221@bubble.grove.modra.org>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Alan Modra" <amodra@gmail.com>,
	"Eric Dumazet" <eric.dumazet@gmail.com>
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

> Did someone fix btrfs, but not check other kernel locks?  Having now
> hit the same problem again, have you checked that other kernel locks
> don't have adjacent bit fields in the same 64-bit word?  And comment
> the struct to ensure someone doesn't optimize those unsigned chars
> back to bit fields.

Seems a good reason to have a general policy of not using
bit fields!

Separate char fields normally generate faster code - possibly
at the expense of an increase in the allocated size of a
structure.

	David
