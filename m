Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A06EA6838F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Sep 2005 23:55:37 +1000 (EST)
In-Reply-To: <8D4C69676E66D511A1CB00508BBBB192052D4395@ranmx1.cs.myharris.net>
References: <8D4C69676E66D511A1CB00508BBBB192052D4395@ranmx1.cs.myharris.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ed8744038b59c4ab9bc4a9bfa9f4ebd8@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 30 Sep 2005 09:55:43 -0400
To: "Fend, Matthias" <mfend@harris.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: AW: mpc8xx and LCD
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Sep 30, 2005, at 7:07 AM, Fend, Matthias wrote:

> As I know at least the S1D13700 is brand new (the people from Epson 
> are working
> on a
> Linux driver at the moment).

OK.

> Do you think it's possible to write the device driver in such a way 
> that
> he also translates the pixel data into the indirect register mode of 
> the
> S1D13700 ?

The only way I can think of is to access protect the "frame buffer",
trap all accesses and then do some translation in software.  Very, very
slow and inefficient.  The most efficient way is for applications (like 
X)
to do this internally.


> ? You mean the 823 has an internal LCD controller -

Yes.

> ..... I know that but I want to
> use a 860 or 855 (we already use them in other products).

Oh well .... :-)


> Do you think it would be the best way to use an 823 and a driver-only 
> display ?

I don't understand the question.

> As there are so many devices with LCD display in use, I thought there 
> could be a
> an easy going standard solution for this, but it seems to be a little 
> bit tricky

There is a standard.  Attach your graphics device to the processor bus 
as
a memory mapped device and use a Linux frame buffer :-)  The complexity
of your graphics requirements will determine how much additional 
software
you have to write.  Since I like to use X-windows, most of the software 
I
end up writing is in that server, not the Linux driver.

Thanks.

	-- Dan
