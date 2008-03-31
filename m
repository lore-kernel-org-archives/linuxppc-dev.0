Return-Path: <dwilson@dslextreme.com>
Received: from mail9.dslextreme.com (mail9.dslextreme.com [66.51.199.94])
	by ozlabs.org (Postfix) with SMTP id C7382DE7BE
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Apr 2008 03:03:33 +1000 (EST)
Message-ID: <47F117CA.3020901@dslextreme.com>
Date: Mon, 31 Mar 2008 09:56:42 -0700
From: Dan Wilson <dwilson@dslextreme.com>
MIME-Version: 1.0
CC: linuxppc-embedded@ozlabs.org
Subject: Re: 8543 console baud rate change problem
References: <47EEFB5B.3050700@fulcrummicro.com>
In-Reply-To: <47EEFB5B.3050700@fulcrummicro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan Wilson wrote:
> We are using ELDK 4.1, linux kernel 2.6.22 on an 8543 board with a 
> Layer 2 switch on it (i.e., the actual packet switching is done in an 
> external chip, not by the 8543 itself).  One of our customers has 
> encountered a strange issue with system console baud rate changes.  
> The system console is connected to a UART port on the 8543.
>
>
> Here is the sequence of events:
>
> + powercycle unit at 115200
>
> + have ping session going
> + establish telnet session
> + have L2 traffic traversing the switch
>
> + switch baud rate to any other baud rate beside 38400
> + hit a few returns
> + switch baud rate back to 115200 and no problem
>
> + switch baud rate to 38400
> + type a few char
> + switch baud rate back to 115200
> + console is not responsive
>
> + existing ping session is still going
> + L2 traffic is still OK
> + telnet session disconnected and can not reconnect;
>  telnet session is being served by linux ip stack
>
> + Had to power cycle to get everything back
>
Just to follow up on this.  We were able to determine that our customer 
had shut off the normal telnet daemon and was using their own program to 
handle telnet sessions.  In addition, they weren't using agetty.  We got 
them to use agetty, and now things seem to be working for them.

Dan.
