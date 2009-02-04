Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id EB78CDDE0A
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 08:52:31 +1100 (EST)
Date: Wed, 4 Feb 2009 16:52:28 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Dynamic-ftrace not working in PlayStation3
In-Reply-To: <200901311125.34755.arnd@arndb.de>
Message-ID: <alpine.DEB.1.10.0902041650240.18695@gandalf.stny.rr.com>
References: <a25370a30901260639u3ab97112qf6688667d39e6706@mail.gmail.com>
	<alpine.DEB.1.10.0901292234520.6222@gandalf.stny.rr.com>
	<4983BFA2.9010703@am.sony.com> <200901311125.34755.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Remis Lima Baima <remis.developer@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 31 Jan 2009, Arnd Bergmann wrote:

> On Saturday 31 January 2009, Geoff Levand wrote:
> > > 
> > > So I take it that the above showed that the code worked for some?
> > 
> > In my trials it blows up on the first load_module() call, and for my
> > config that was usbcore:
> 
> I looked into it some more with Remis yesterday, and we got ftrace
> working by building usbcore and alsa into the kernel. Incidentally,
> usbcore is the largest module in this installation (~3MB), which
> indicates that it is in some way either related to the size of the
> module.
> 
> > This ptr of 5f666f725f726573 seems bogus.  I think this code is not
> > working correctly:
> 
> This is an ascii string "_for_res", probably part of
> usb_lock_device_for_reset. We saw the same behaviour, but
> a different string.

OK, I've been able to reproduce it. It looks like the assumptions of the 
trampoline that I've made is not correct if the size of the module is over 
some limit.  I had to make usb-core into a module, and I see the same 
bug.

I'll take a deeper look into it.

-- Steve
