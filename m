Return-Path: <cecolong@yahoo.com>
Received: from web33402.mail.mud.yahoo.com (web33402.mail.mud.yahoo.com
	[68.142.206.134]) by ozlabs.org (Postfix) with SMTP id EBAB768268
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Sep 2005 01:30:30 +1000 (EST)
Message-ID: <20050910153028.69910.qmail@web33402.mail.mud.yahoo.com>
Date: Sat, 10 Sep 2005 08:30:28 -0700 (PDT)
From: goog long <cecolong@yahoo.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20050909213220.GC5034@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Serial driver problem from 2.6.12 kernel
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I cat /proc/interrupt and see the receiving interrupts
number increases, but the driver can only receive big
messages. Therefore, you first option is right. The
mpsc reciever will not timeout. I changed max_idle to
40 and it works perfect. Thanks a lot Mark.

cecolong

--- "Mark A. Greer" <mgreer@mvista.com> wrote:

> On Fri, Sep 09, 2005 at 08:17:14AM -0700, goog long
> wrote:
> > Hi all,
> > 
> > I backported MPSC driver from 2.6.12 to my kernel
> > 2.6.10. However, the driver can send characters,
> but
> > cannot receive any characters. Have anyone seen
> this
> > before?
> > 
> > Please also send your feedback to
> cecolong@yahoo.com
> 
> Hmm, a little sparse on info here so its hard to
> guess.
> 
> The mpsc driver is very much influenced by the
> platform_data that you
> pass to it (since there are so many options).  One
> possibility
> is that you have the max_idle platform_data field
> set to 0 which means
> that the mpsc reciever will not timeout and
> therefore the mpsc will not
> pass to the driver whatever you've typed until your
> receive buffer fills up
> (which you may not have done in your testing).  Try
> a max_idle value of 40
> which seems to work fine for me.  Another
> possibility, of course, is that
> you passed in the wrong irq in the platform_data and
> therefore are not
> getting recieving interrupts.
> 
> Mark
> 



	
		
______________________________________________________
Click here to donate to the Hurricane Katrina relief effort.
http://store.yahoo.com/redcross-donate3/
