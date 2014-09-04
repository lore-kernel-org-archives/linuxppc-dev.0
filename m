Return-Path: <jakub@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C6F01A0074
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 22:29:27 +1000 (EST)
Date: Thu, 4 Sep 2014 14:29:01 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: bit fields && data tearing
Message-ID: <20140904122901.GA17454@tucnak.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20140712181328.GA8738@redhat.com>
 <54079B70.4050200@hurleysoftware.com>
 <1409785893.30640.118.camel@pasglop>
 <21512.10628.412205.873477@gargle.gargle.HOWL>
 <20140904090952.GW17454@tucnak.redhat.com>
 <540859EC.5000407@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <540859EC.5000407@hurleysoftware.com>
Cc: linux-arch@vger.kernel.org, Mikael Pettersson <mikpelinux@gmail.com>,
 Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 04, 2014 at 08:24:12AM -0400, Peter Hurley wrote:
> And I just confirmed with the Alpha cross-compiler that the fields are
> not 'padded out' if volatile either.

They can't be, struct layout is part of the ABI.
Guess you can introduce say atomic_bool and similar typedefs which would be
bool or char on most arches and on alpha int.

	Jakub
