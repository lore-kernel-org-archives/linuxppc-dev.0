To: "Montgomery, Tim" <timm@artesyncp.com>
Cc: "'Eugene Surovegin'" <ebs@ebshome.net>,
	"Johnson,     Stephen" <stevebj@artesyncp.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Opps...with ELDK-2.1.0 (ppc_4xx) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 23 Apr 2003 12:18:15 CDT."
             <F9102D41F595D311ACA7009027DE2C8406AB8214@c3po.heurikon.com>
Date: Wed, 23 Apr 2003 21:18:40 +0200
Message-Id: <20030423191845.51D3EC5E29@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <F9102D41F595D311ACA7009027DE2C8406AB8214@c3po.heurikon.com> you wrote:
>
> Wolfgang:
> I know you had some examples of i2c-based rtc support in your tree.  Assuming the above is the cause behind the oops, does your driver preclude rtc updates from the timer interrupt context?

So far we used the RTC just to set the system date&time when booting.
No interrupt involved here.

Last year we added support for NTP to the ELDK, but  missed  to  test
this on systems with a I2C based RTC (another lesson learned). It was
only  now  when I was about to officially announce the new ELDK (main
new feature: suppoort for MIPS) when we ran into the problem.

> Some time ago I queried the list on the best way to support an i2c-based RTC; at that time, there was no consensus.
> Any more thoughts along these lines?

I still feel the whole I2C layer is overkill for embedded systems. In
some projects we decided to ignore it in favour of smaller code  with
a finer granularity of control.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Nobody goes to that restaurant anymore. It's too crowded.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
