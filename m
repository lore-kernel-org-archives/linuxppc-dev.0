Return-Path: <wd@denx.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id 99A662BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Nov 2004 03:23:37 +1100 (EST)
To: "=?iso-8859-1?Q?J=F3n_Benediktsson?=" <jonb@marel.is>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 04 Nov 2004 12:32:40 GMT."
	<OF368071C2.FBC6B7BC-ON00256F42.003F3DF3-00256F42.0044E8BB@marel.is>
Date: Thu, 04 Nov 2004 17:22:57 +0100
Sender: wd@denx.de
Message-Id: <20041104162302.2B49DC1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Handling power failure - MPC5200 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <OF368071C2.FBC6B7BC-ON00256F42.003F3DF3-00256F42.0044E8BB@marel.is> you wrote:
> 
> Capacitors on the supply provide me with some milliseconds to repond to 
> power failure, which I would
> like to use to do as much cleanup as possible before power is totally 
> gone.  In particular, I am concerned

How many is "some"? If it's not >100 or so it is probably  not  worht
the effort...

> with trying to prevent damage to filesystems.  The board has Compact Flash
> and onboard flash which
> are used as filesystems.  The board will be used as an industrial 
> controller.
> 
> Can anyone point me to examples of how this can be handled ?

Use the standard methods: use the CF card read-only  (many  CF  cards
can  be  damaged  [beyond  repair]  when  you power off while a write
operation is in progress). Use a filesystem  on  the  ob-board  flash
which knows how to handle a loss of power (i. e., use JFFS2).

> Can anyone share experience of a similar setup, which filesystems to 
> select etc ?

We usually use ext2 read-only on the CF, JFFS2 for the writable parts
on the on-board flash, cramfs for all  parts  that  need  not  to  be
written  on  a  regular  base (most of your root filesystem including
application  code,  libraries  etc.),  and  a  FiST   based   overlay
filesystem in case of software patches need to be added.

Best regards,

Wolfgang Denk

-- 
See us @ Embedded/Electronica Munich, Nov 09 - 12, Hall A.6 Booth 513
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
You don't have to stay up nights to succeed; you have to  stay  awake
days.
