Message-ID: <3F16CCA6.30905@earthlink.net>
Date: Thu, 17 Jul 2003 09:19:50 -0700
From: Dean Matsen <deanmatsen@earthlink.net>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8xx SCC's as uart
References: <75DF04AC5ED4D511A9810090273CB4163F5DEB@rokonet-e.rokonet.co.il>
In-Reply-To: <75DF04AC5ED4D511A9810090273CB4163F5DEB@rokonet-e.rokonet.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format="flowed"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If anyone has interest, I have a patch against the 2.4.22-pre4/5
kernels that allows SCC1 to be a console (but still without
handshaking, in accord with this discussion thread) on 8xx builds.

We have a device where SCC1 is the only port connected to a DB-9, so
I had to do it.  The patch is modeled after the 8260 SCC console
stuff.

Problem is, the boot/8xx_io/boot/simple/m8xx_tty.c is kind of
messy because of an intertwined if/else and #ifdef/#else (we call
it a "conditional curly brace" at our office), so I do not know that
my patch is appropriate for all platforms.  It works on the one
device of ours that needs it...

Dean

Eli Brin wrote:

>Dear Wolfgang,
>
>Thanks, but I prefer to try it on the FADS.  I don't want anything "bad" to
>happen to the TQM860L.  The FADS is expendable...
>
>Thank you,
>Eli Brin
>
>
>-----Original Message-----
>From: Wolfgang Denk [mailto:wd@denx.de]
>Sent: Thursday, July 17, 2003 4:08 PM
>To: Eli Brin
>Cc: 'Steven Scholz'; 'linuxppc-embedded@lists.linuxppc.org'
>Subject: Re: 8xx SCC's as uart
>
>
>Dear Eli,
>
>in message <75DF04AC5ED4D511A9810090273CB4163F5DE9@rokonet-e.rokonet.co.il>
>you wrote:
>
>
>>When I will get our target, I will be able to test the HW flow control
>>of the 8xx and find a working mode with mgetty.  Our development
>>targets (TQM860L and FADS) don't have an SCC uart port...Perhaps I
>>will try to rewire the FADS that has SCC2 connected to an IRDA port...
>>
>>
>
>You can easily connect a UART port on a free SCC on the TQM860L - all 4 SCCs
>are available on  the  headers,  and  all  required  pins  are available  on
>the  STK8xxL  starter  kit board, too. You just need a RS232 line driver.
>
>
>Best regards,
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>Thought for the day: What if there were no hypothetical situations?
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
