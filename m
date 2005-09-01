Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id A20426808E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Sep 2005 18:28:18 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 6C7AB4057
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Sep 2005 10:09:34 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 25734-05 for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Sep 2005 10:09:34 +0200 (CEST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 1E1B74046
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Sep 2005 10:09:34 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 1 Sep 2005 10:09:23 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200509011009.24114.david.jander@protonic.nl>
Subject: Question about ELDK and i18n...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

I am using ELDK-3.1, and I am not getting i18n to work. I have looked at 
recent changelog of ELDK and newer (CVS) versions don't seem to fix any bug 
in that direction.
The installation seems ok, the locale-files are all there as it seems.
I have tried this as a test:

# LANG=es_ES strace tar

in the output, I can see these relevant lines:

open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No 
such file or directory)

- This does not matter.

open("/usr/share/locale/locale.alias", O_RDONLY) = 3

- OK, good. locale.alias is read

open("/usr/lib/locale/es_ES/LC_IDENTIFICATION", O_RDONLY) = 3

- Also looks fine, read the locales identification.

open("/usr/lib/locale/es/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT (No such 
file or directory)

- Here I am puzzled. Why? Maybe this is not important.

Then there are no more calls to open or stat with files in "/usr/lib/locale" 
nor "/usr/share/locale" as argument, and I can't figure out why. What am I 
doing wrong? Is this version of glibc in ELDK broken?

Best regards,

-- 
David Jander
