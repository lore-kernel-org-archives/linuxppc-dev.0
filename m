Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id 619DA6816F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Sep 2005 19:18:10 +1000 (EST)
To: David Jander <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Sep 2005 10:09:23 +0200."
	<200509011009.24114.david.jander@protonic.nl>
Date: Thu, 01 Sep 2005 11:18:01 +0200
Sender: wd@denx.de
Message-Id: <20050901091801.CD09F352B7C@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Question about ELDK and i18n... 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear David,

in message <200509011009.24114.david.jander@protonic.nl> you wrote:
> 
> I am using ELDK-3.1, and I am not getting i18n to work. I have looked at 
> recent changelog of ELDK and newer (CVS) versions don't seem to fix any bug 
> in that direction.

There is no fix yet, but the problem is known :-(

> The installation seems ok, the locale-files are all there as it seems.

No.

> I have tried this as a test:
> 
> # LANG=es_ES strace tar
> 
> in the output, I can see these relevant lines:
> 
> open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No 
> such file or directory)
> 
> - This does not matter.

It does. For the setlocale() call to succeed, an additional file is
needed, apart from the locale files themselves. It is a
locale-archive file in the /usr/lib/locale directory on the target.
This file is still missing in the ELDK glibc RPM.

> open("/usr/share/locale/locale.alias", O_RDONLY) = 3
> 
> - OK, good. locale.alias is read
> 
> open("/usr/lib/locale/es_ES/LC_IDENTIFICATION", O_RDONLY) = 3
> 
> - Also looks fine, read the locales identification.
> 
> open("/usr/lib/locale/es/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT (No such 
> file or directory)
> 
> - Here I am puzzled. Why? Maybe this is not important.
> 
> Then there are no more calls to open or stat with files in "/usr/lib/locale" 
> nor "/usr/share/locale" as argument, and I can't figure out why. What am I 
> doing wrong? Is this version of glibc in ELDK broken?

There  is  a  problem  with  locale  support.  The  contents  of  the
'locale-archive'  file  is endian-dependent. This means that we can't
use the existing tools on the x86 (= little endian) ELDK  build  host
to generate it for a big-endian target.

As a workaround, the locale files can be generated  natively  on  the
target, using for example the following command:

# localedef -i de_DE -f ISO-8859-1 de_DE


Hope this helps.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There is, however, a strange, musty smell in the air that reminds  me
of something...hmm...yes...I've got it...there's a VMS nearby, or I'm
a Blit.          - Larry Wall in Configure from the perl distribution
