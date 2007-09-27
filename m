Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 684CDDDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 19:21:43 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/7] Celleb: Supports VFD on Celleb 2
Date: Thu, 27 Sep 2007 11:07:33 +0200
References: <20070927.165631.-1300533671.kouish@swc.toshiba.co.jp>
In-Reply-To: <20070927.165631.-1300533671.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709271107.33696.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 27 September 2007, Ishizaki Kou wrote:
> This is a patch to support VFD on Celleb 2.
> VFD is a small LCD to show miscellaneous messages.
> 
> Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>

The implementation looks fine, but I'm not sure if /proc/ppc64/rtas is the
right way to do it. The two problems I have with this are:

* /proc files are generally not a good idea for new stuff. We carry around
  the existing /proc/ppc64/rtas files because we can't change the interface
  for existing stuff. My feeling is that your interface should better be
  implemented as a character device, or be integrating into some other
  existing message interface, if we can find one.

* The firmware seems to implement the generic rtas interface for
  display-character and set-indicator, but your driver is celleb specific.
  I'd be feel more comfortable if we could come up with a driver that also
  works on other systems that implement the same rtas calls.

	Arnd <><
