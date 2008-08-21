Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 13AD3DEA31
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Aug 2008 20:10:06 +1000 (EST)
To: rmcguire@videopresence.com
From: Wolfgang Denk <wd@denx.de>
Subject: Re: ELDK Fedora Core 9
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <2EA59411B5534D8893C7CB74569C2DC2@absolutdaddy>
References: <mailman.1.1217383202.19379.linuxppc-embedded@ozlabs.org>
	<2EA59411B5534D8893C7CB74569C2DC2@absolutdaddy>
Date: Thu, 21 Aug 2008 12:10:04 +0200
Sender: wd@denx.de
Message-Id: <20080821101004.29A82243AB@gemini.denx.de>
Cc: eldk@lists.denx.de, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear "Russell McGuire",

In message <2EA59411B5534D8893C7CB74569C2DC2@absolutdaddy> you wrote:
> 
> I know that DENX doesn't list ELDK 4.1 with FC9 as officially supported, but
> has anyone tried to install it with FC9?
> 
> Attempts last night resulted in the install script freezing during install,
> and no apparent error messages.

Where exactly did it hang? What was the command you used, and what was the exact output?

> 1) Has anyone tried this? Success?

I tried it now, and it got stuck indeed:

...
Preparing...                ########################################### [100%]
   1:db4-devel-ppc_4xx      ########################################### [100%]
Preparing...                ########################################### [100%]
   1:db4-utils-ppc_4xx      ########################################### [100%]
Preparing...                ########################################### [100%]
   1:glib2-ppc_4xx          ########################################### [100%]
Preparing...                ########################################### [100%]
   1:glib2-devel-ppc_4xx    ########################################### [100%]
Preparing...                ########################################### [100%]

<hangs here>

> 2) Does anyone have suggestion on how turn on debugging with the install
> script?

It's not a a script, but a binary, so you are limited to  tools  like
strace, ltrace etc.

In my case I see this:

# strace -p 21197
Process 21197 attached - interrupt to quit
futex(0x96fe17c, FUTEX_WAIT_PRIVATE, 1, NULL

i. e. it's hanging in a futex call. [Futextes have often before  been
a major PITA].

A quick workaround seems to be to build the installer on  the  native
(Fedora  9) system; download the source and the Makefile from the git
repository:

http://git.denx.de/?p=eldk/build.git;a=tree;f=install;h=5f1a9bb9ca5757f4efbca7ff4f48bf869a2ef949;hb=90ed3ca5e1163d771badf1c26f76e95d95e13990

and run:

$ make TARGET_ARCH=ppc

Then use this "install" binary to replace 

Then reboot, and then try again.  Note  that  the  reboot  is  really
necessary,  or  at least I do not know of any other way to get rid of
the stuck futexes.


BTW: ELDK related questions are better posted on the ELDK mailing
list, see http://lists.denx.de/mailman/listinfo/eldk

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
People seldom know what they want until you give them what  they  ask
for.
