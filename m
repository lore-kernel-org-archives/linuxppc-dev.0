Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13F9FDDE1D
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 02:54:26 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8RGsDUk029628
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 12:54:13 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8RGsDat467934
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 10:54:13 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8RGsCua007377
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 10:54:13 -0600
Date: Thu, 27 Sep 2007 11:54:12 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/7] Celleb: Supports VFD on Celleb 2
Message-ID: <20070927165412.GD7970@austin.ibm.com>
References: <20070927.165631.-1300533671.kouish@swc.toshiba.co.jp>
	<200709271107.33696.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200709271107.33696.arnd@arndb.de>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 27, 2007 at 11:07:33AM +0200, Arnd Bergmann wrote:
> On Thursday 27 September 2007, Ishizaki Kou wrote:
> > This is a patch to support VFD on Celleb 2.
> > VFD is a small LCD to show miscellaneous messages.
> > 
> > Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>
> 
>   My feeling is that your interface should better be
>   implemented as a character device, or be integrating into some other
>   existing message interface, if we can find one.
> 
> * The firmware seems to implement the generic rtas interface for
>   display-character and set-indicator, but your driver is celleb specific.
>   I'd be feel more comfortable if we could come up with a driver that also
>   works on other systems that implement the same rtas calls.

Yep, I think I agree. Most pseries systems have a small two-line
LCD display.  Right now, the code that talks to it is implemented in
rtas_progress(). It has this name because its used only for printing
out boot progress messages. This is great for debugging hangs, but 
its not othrewise used.

I suppose it would be nice to have a "geeric" interface to the thing, 
and, after a quickie skim of the code, the celleb display looks similar
enogh that this abstraction could be made.

--linas
