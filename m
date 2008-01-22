Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 416E6DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jan 2008 16:34:16 +1100 (EST)
In-Reply-To: <20080121164006.GA3455@ld0162-tx32.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Endian problem when accessing internel regs on 8347
MIME-Version: 1.0
Message-ID: <OF5A89620A.086EE26A-ON882573D8.001D838F-882573D8.001E8ECE@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Mon, 21 Jan 2008 21:33:46 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > Can't anyone suggest anything I can try?
> 
> Beer.
> 
> -Scott

Right there with you Scott!  I have to apologize for the noise on the 
list.  Turns out my problem doesn't have anything to do with in_be32.  I 
didn't have print statements in enough places.  I was only printing out 
what was returned from the ioctl call in user space and assumed (we know 
what that means ;)  ) that what was coming back from the ioctl call was 
what was coming back from io_read32.  With better instrumenting I find 
that io_read32 is just fine.  Apparently my return value from the ioctl 
function in my driver is getting corrupted by the time it gets to my user 
space app.  I don't have an answer for that one yet, but now that I'm 
turned in the correct direction hopefully it'll fall out pretty quickly. 
Thanks for the patience.

See 'ya!

Bruce
