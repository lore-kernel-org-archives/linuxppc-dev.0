Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44E481A04E5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 19:37:13 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Marc Dietrich <marvin24@gmx.de>, Geoff Levand <geoff@infradead.org>
Subject: Re: Time to remove platforms/cell?
Date: Thu, 17 Sep 2015 11:31:21 +0200
Message-ID: <7144823.dIR0EDXkmx@wuerfel>
In-Reply-To: <2023345.Irprl084gX@fb07-iapwap2>
References: <1442467727.25483.0.camel@ellerman.id.au>
 <2023345.Irprl084gX@fb07-iapwap2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 17 September 2015 10:43:39 Marc Dietrich wrote:
> Am Donnerstag, 17. September 2015, 15:28:47 schrieb Michael Ellerman:
> > Discuss ...
> 
> as long as Geoff still maintains the ps3 port - why?
> 
We already removed celleb a while ago, which was arguably the least
commonly used one.

Within platforms/cell, we have three separate portions that we need
to look at:

a) Common ps3/ibm parts: spufs, oprofile
   We should not remove them before we plan to also remove platforms/ps3
   support, which doesn't seem likely in the near term. We can move them
   to platforms/ps3 if we decide to remove the rest.

b) Support for IBM blades:
   It is unlikely that there are QS20 blades still around and being used
   at all, but there is very little code specific to them.
   For QS21/QS22, there are probably still a few in existence, but
   I have no idea whether anybody would consider running a 4.x kernel
   on them. There are also some customer-specific Cell machines that
   are vaguely related to QS22 and that are in a similar state.
   I don't mind removing the code, but if anybody is still using it
   on new kernels, we should be prepared to put it back.

c) QPACE. We know who the three users were, and they have upgraded to
   QPACE2 (based on Intel Xeon Phi) this year. Removing this would be
   appreciated as it lets us clean up one of the ugly corners of the
   8250 uart driver.

	Arnd
