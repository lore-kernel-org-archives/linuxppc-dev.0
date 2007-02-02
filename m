Return-Path: <cdumoulin@ics-ltd.com>
Received: from mx4.magma.ca (mx4-3.spamtrap.magma.ca [209.217.78.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D67ADDF51
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Feb 2007 01:32:55 +1100 (EST)
Received: from mail3.magma.ca (mail3.internal.magma.ca [10.0.10.13])
	by mx4-3.spamtrap.magma.ca (8.13.1/8.13.1) with ESMTP id l12EAaxE019081
	for <linuxppc-embedded@ozlabs.org>; Fri, 2 Feb 2007 09:10:36 -0500
Received: from randa ([64.26.174.130])
	by mail3.magma.ca (Magma's Mail Server) with ESMTP id l12EAY18012539
	for <linuxppc-embedded@ozlabs.org>; Fri, 2 Feb 2007 09:10:35 -0500
Message-Id: <200702021410.l12EAY18012539@mail3.magma.ca>
From: "Christopher Dumoulin" <cdumoulin@ics-ltd.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: ELDK glibc fcntl(socketFd, F_SETFL, flags) causes Seg Fault
Date: Fri, 2 Feb 2007 09:10:37 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.1565.1170401421.9285.linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

If that's your exact code, I notice you're not checking if the socket()
call succeeded. You may be calling fcntl with an invalid socket handle.

The first place I'd look is to make sure you've included 'Networking
Support', 'Unix domain sockets', maybe 'TCP/IP networking', and whatever
else you might need, when you configure your kernel.

---------------------------------------------------------------------
Message: 6
Date: Fri, 02 Feb 2007 08:30:18 +0100
From: Wolfgang Denk <wd@denx.de>
Subject: Re: ELDK glibc fcntl(socketFd, F_SETFL, flags) causes Seg
	Fault
To: Daniel Ng <daniel_ng11@lycos.com>
Cc: linuxppc-embedded@ozlabs.org
Message-ID: <20070202073018.C8710352B86@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1

In message <loom.20070201T073939-302@post.gmane.org> you wrote:
> 
> My application Seg Faults when I try to set flags for my socket fd.
> 
> First, I get the fd by calling socket():
> fd = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
> 
> Then I try getting the fd flags:
> fcntl(fd, F_GETFL, flags)

Provide some working / crashing test code, i. e. a complete C program
with declarations etc.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There's an old story about the person who wished his computer were as
easy to use as his telephone. That wish has come  true,  since  I  no
longer know how to use my telephone.


------------------------------

_______________________________________________
