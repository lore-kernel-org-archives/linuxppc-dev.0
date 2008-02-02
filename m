Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 32D31DDE43
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 15:24:26 +1100 (EST)
To: "Sebastian Theiss" <st12@inf.tu-dresden.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: pthread / TQM5200 problem
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 01 Feb 2008 13:47:45 +0100."
	<002c01c864d0$a4ad11c0$0101a8c0@tis>
Date: Sat, 02 Feb 2008 05:24:24 +0100
Sender: wd@denx.de
Message-Id: <20080202042424.8E6AA247A1@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <002c01c864d0$a4ad11c0$0101a8c0@tis> you wrote:
> 
> I've been having some headache using the pthread library with a TB5200 box
> (based on a TQM5200 board with a Freescale MPC5200 PowerPC-CPU). I created a
> small program to pin down the problem and it runs fine on all my Unix- and

NOTE: It is really bad behaviour to post the same  question  indepen-
dently  in  several  mailing  list.  Your  question  has already been
answered on the ELDK list.

> Linux-machines but fails on the embedded box: The program contains a class
> CSignal that provides thread-synchronisation based on the
> pthread_cond_signal and pthread_cond_wait calls and takes care of the
> "spurious wakeup" and "lost signal" problems. The program runs 159
> additional threads (that seems to be some internal limit), each of them

And this strange "internal limit"  is  an  indication  that  you  are
running code that is more than 1.5 years old, as the bug was fixed in
September  2006.  It was caused by bad PCI mappings that overlap with
CONFIG_TASKSIZE.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It would seem that evil retreats when forcibly confronted
	-- Yarnek of Excalbia, "The Savage Curtain", stardate 5906.5
