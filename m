Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id AF6F3DDE3E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Feb 2007 13:42:19 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so582152ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 08 Feb 2007 18:42:17 -0800 (PST)
Message-ID: <528646bc0702081842r3390c0dvb4767f4d66daabd@mail.gmail.com>
Date: Thu, 8 Feb 2007 19:42:16 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Juergen Beisert" <juergen.beisert@weihenstephan.org>
Subject: Re: How to detect fsystem clock on MPC5200
In-Reply-To: <200702081813.35776.juergen.beisert@weihenstephan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200702081813.35776.juergen.beisert@weihenstephan.org>
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

On 2/8/07, Juergen Beisert <juergen.beisert@weihenstephan.org> wrote:
> Hi all,
>
> currently I am writing an SPI driver for a PSC unit.

Cool; that would be useful!  :)  I look forward to seeing it.

> To calculate the baudrate
> this unit should use I need the fsystem frequence (fsystem is the used name
> in the datasheet). Is there a generic way (API) to read back this clock?
>
> For the IPB clock I found mpc52xx_find_ipb_freq() from the open firmware
> framework. Is there something similar for the fsystem clock?

Hmmm, yeah... Sylvain brought this up a while ago.  We currently don't
have that information in the device tree definition; but it is needed.
 I need to add a new device tree property; probably 'system-frequency'
in the soc node.  It is also possible to derive fsystem from the
/soc5200/bus-frequency by interpreting the registers; but i think
that's rather ugly.

I'm working on the device tree bindings at the moment.  I'll add in a
property for the system frequency and post the patch for comments.
Once that's defined, it's trivial to add a function to return the
system frequency.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
