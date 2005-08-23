Return-Path: <wd@denx.de>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com
	[194.25.134.80]) by ozlabs.org (Postfix) with ESMTP id 5D35A68182
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 03:20:41 +1000 (EST)
To: =?UTF-8?Q?=E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84EMAIL?= <rober@opnet.com.tw>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 23 Aug 2005 13:16:13 +0800."
	<1124774174.5945.15.camel@banana>
Date: Tue, 23 Aug 2005 10:57:56 +0200
Sender: wd@denx.de
Message-Id: <20050823085756.5AAE1353D18@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How to run ELDK 3.1.1 's snmp ? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <1124774174.5945.15.camel@banana> you wrote:
> 
>      I want to know how to used ELDK 3.1.1's snmpd at ppc_8xx
> environment.I used 2.4.25 Linux  and uRamdisk (from denx's ftp site) at
> my MPC852T custom board. When  I mount /opt/eldk/ppc_88x to my linux and

There is no ppc_88x in the ELDK. Mounting the NFS root file system on
top of the ramdisk root is probably not a good idea.  Why  don;t  you
run  with  root  file  system over NFS directlty as all documentation
shows in detail?

> I got following error message.
> 
>  # ./snmpd --version
> ./snmpd: No such file or directory

snmpd is not in your current directory.

Are you sure this is the realk error message?

> The found if i compiler snmp source code with LDFLAGS +ÿ-static,
> although file is bigger than ELDK's snmpd (almost 3M byte), but it can
> run very well. I want to know what's the different between LDFLAGS
> static and LDFLAGS

You are missing some of the needed shared libraries  in  the  ramdisk
image; just mounting the NFS root file system on some other directory
does  not  automatically  provide  access to the additional (mounted)
shared libraries. Correctly setting "LD_LIBRARY_PATH" may  help,  but
seems overly complicated.

Just user the root file system over NFS directly.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"An organization dries up if you don't challenge it with growth."
       - Mark Shepherd, former President and CEO of Texas Instruments
