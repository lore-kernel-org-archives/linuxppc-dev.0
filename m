Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 515681007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 23:54:03 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1ON4Le-0006yj-NO
	for linuxppc-dev@ozlabs.org; Fri, 11 Jun 2010 06:32:38 -0700
Message-ID: <28855222.post@talk.nabble.com>
Date: Fri, 11 Jun 2010 06:32:38 -0700 (PDT)
From: "acrux@cruxppc.org" <acrux@linuxmail.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: "event-scan failed" logflood
In-Reply-To: <1274233162.29980.13.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <loom.20100517T145602-17@post.gmane.org>
	<1274185991.26143.1.camel@concordia>
	<loom.20100518T182547-195@post.gmane.org>
	<1274233162.29980.13.camel@concordia>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Michael Ellerman wrote:
> 
> On Tue, 2010-05-18 at 16:30 +0000, nello martuscielli wrote:
>> Michael Ellerman <michael <at> ellerman.id.au> writes:
>> 
>> _omissis__
>> > > 
>> > > hi, is there available that patch?
>> > > With the fresh new 2.6.34 the logflood problem is still present.
>> > 
>> > You could try this, completely untested:
>> > 
>> > diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
>> > index 4190eae..fd68bed 100644
>> > --- a/arch/powerpc/kernel/rtasd.c
>> > +++ b/arch/powerpc/kernel/rtasd.c
>> > @@ -490,6 +490,12 @@ static int __init rtas_init(void)
>> >                 return -ENODEV;
>> >         }
>> > 
>> > +       if (!rtas_event_scan_rate) {
>> > +               /* Broken firmware: take a rate of zero to mean don't
>> scan */
>> > +               printk(KERN_DEBUG "rtasd: scan rate is 0, not
>> scanning\n");
>> > +               return 0;
>> > +       }
>> > +
>> >         /* Make room for the sequence number */
>> >         rtas_error_log_max = rtas_get_error_log_max();
>> >         rtas_error_log_buffer_max = rtas_error_log_max + sizeof(int);
>> > 
>> 
>> 
>> hi Michael, thanks for pointing me to that patch, now my Pegasos2 G4
>> seems to
>> work fine.
> 
> Great. Can I add Tested-by you?
> 
> 

hi Michael,
thanks, this patch seems to solve that problem on my Pegasos2 too.


thanks,
Nico

-- 
View this message in context: http://old.nabble.com/Re%3A-%22event-scan-failed%22-logflood-tp28585064p28855222.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
