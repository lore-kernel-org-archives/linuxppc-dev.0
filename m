Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 51138DE16D
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 09:02:44 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so414013anc.78
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 16:02:38 -0700 (PDT)
Message-ID: <fa686aa40804201602p32b90f19wb6ca270503bd2a53@mail.gmail.com>
Date: Sun, 20 Apr 2008 17:02:38 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: UartLite
In-Reply-To: <480BA62D.5020904@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <480BA62D.5020904@dlasys.net>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

BTW, you should really be asking these questions on the linuxppc mailing list

On Sun, Apr 20, 2008 at 2:23 PM, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
> I have been looking more and more at the kernel uartlite driver.
>  Somewhere along the line while I was not watching PK's driver has
>  developed alot stronger resemblance to most normal serial drivers. I am
>  seriously thinking of putting some effort into getting it working for
>  me, and then pushing my polling patch for interrupt free implimentations.
>
>  But I have tripped over several things that trouble me. Though I am not
>  a serial driver expert.
>
>  The first is that all the Uartlite related definitions tend to create a
>  BaseAddress+3 definition.
>  This really bothers me, it presumes that the registers are all 4 bytes
>  apart - I know that is the norm
>  and I have never actually seen a different implimentation, but I do not
>  think it is set in stone.
>  It also is basically a cleaver trick to get readb/writeb to work without
>  adjustment.
>  Endian issues tend to give me headaches, but somehow I think there is an
>  endian issue in this.
>  All the port offsets are defined with the presumption the registers are
>  4 bytes apart.
>  Despite the fact that all the offsets masks and bits are needed in
>  several files, they are not in a header.

Yes, I'm not a big fan of the +3 either; but it is expedient.  I think
the best solution is to encode it into the device tree by adding
optional "reg-stride" and "reg-offset" properties (at least for memory
mapped implementations).

We can define another binding for the DCR version.

>  If I can manage to get the thing to work for me,
>  Am I going to be stepping on any toes if I make changes to adress my
>  concerns above ?

I've got no problem reworking the register accessor functions.

>  I really want to migrate all the direct IO to a ulite_in() and
>  ulite_out() routine.
>  Letting those two routines deal with all the issues of BaseAddress,
>  register size, endianness, register shift,
>  and even whether access is via DCR - I have seen atleast one
>  implimentation that was DCR.
>
>  I would like to remove the +3 from all the macro's etc. as it seems to
>  me to confuse what is actually going on.
>
>  I did a diff merge against my own driver a few days ago and aside from
>  these issues, order of functions, some naming issues, the absence of OF
>  support in my driver, and the presence of polling in mine, the code now
>  very very strongly parallels my code now. So it should not be alot of
>  work to merge  my code  into the  standard driver now.
>
>  I will be happy to do this - presuming I am not going to be stepping on
>  any toes.
>  I would be happy to not have to support a separate driver, but the stock
>  driver has to work with my hardware.
>  It still does not, but I think the code is now close enough for me to
>  track down and kill the problem.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
