To: robdlg@att.net
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: popt, ELDK 2.0.2 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 06 Oct 2003 10:51:44 -0000."
             <200310061051.FAA10075@lists.linuxppc.org>
Date: Mon, 06 Oct 2003 19:10:46 +0200
Message-Id: <20031006171051.926E0C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200310061051.FAA10075@lists.linuxppc.org> you wrote:
>
> I was experimenting with the popt library in the ELDK 2.0.2, and I received
> the following errors.  The same compiler invocation is successful when used
> with gcc under Red Hat Linux 7.3.  The source code follows the error
> messages.  How do I properly compile and link this file?
>
> ppc_82xx-gcc -Wall -lpopt -o popt_test main.c

You must specify the linked objects in the correct order. This  means
(among  other  things)  that  you have to put the libraries AFTER the
object files that have references to symbols provided by these libs.

Try:

	ppc_82xx-gcc -Wall -o popt_test main.c -lpopt

And RTFM.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Vulcans believe peace should not depend on force.
	-- Amanda, "Journey to Babel", stardate 3842.3

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
