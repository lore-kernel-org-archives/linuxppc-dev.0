To: rajendra.mishra@timesys.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Unable to locate request_8xxirq() ! 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 01 May 2002 15:19:25 +0530."
             <200205010949.g419nPI11057@localhost.localdomain>
Date: Wed, 01 May 2002 18:50:48 +0200
Message-Id: <20020501165053.8BB39FF6C@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200205010949.g419nPI11057@localhost.localdomain> you wrote:
>
>    I am unable to locate request_8xxirq() function in the 2.4.18 source code.

You shoudl install an update of "grp" on  your  system,  it  must  be
broken if ir doesn;t find the definition in the kernel sources..

> Can anyone tell me where is this function located and what does it do ?
> I  did a search in "lxr.linux.no" , but still i was not able to locate the
> function it is invisible  :( .

"arch/ppc/kernel/irq.c":

...
#if (defined(CONFIG_8xx) || defined(CONFIG_8260))
/* Name change so we can catch standard drivers that potentially mess up
 * the internal interrupt controller on 8xx and 8260.  Just bear with me,
 * I don't like this either and I am searching a better solution.  For
 * now, this is what I need. -- Dan
 */
#define request_irq     request_8xxirq
#elif defined(CONFIG_APUS)
#define request_irq     request_sysirq
#define free_irq        sys_free_irq
#endif
...

Next question, please...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You can observe a lot just by watching.                  - Yogi Berra

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
