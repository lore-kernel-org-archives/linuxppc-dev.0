Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 1276867BD7
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Dec 2006 19:03:27 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1203064ugf
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Dec 2006 00:03:25 -0800 (PST)
Message-ID: <528646bc0612170003w536c4938if29749a5cf47d07@mail.gmail.com>
Date: Sun, 17 Dec 2006 01:03:24 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Pedro Luis D. L." <carcadiz@hotmail.com>
Subject: Re: Lite5200B I2S driver
In-Reply-To: <BAY122-F11E9828E7994B0E0514B19CAD70@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <BAY122-F11E9828E7994B0E0514B19CAD70@phx.gbl>
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

On 12/12/06, Pedro Luis D. L. <carcadiz@hotmail.com> wrote:
> Hi all,
>
> I=B4m working with a Lite5200B EVB, trying to atach an audio output to a =
PCM
> 1680 from Texas Instruments.
> At this moment I am using the patched 2.6.16.11-rt18 kernel that comes wi=
th
> Freescale BSP.
> I=B4ve tried to develop an I2S driver for the platform with no results. I=
=B4m
> afraid that my driver devolping skills are still too low.
>
> Anybody knows a working I2S driver for this board that can throw any
> audiooutput through PSCs?

I've just pushed a driver for the mpc52xx psc + AIC26 codec out to the
'lite5200' branch of my git tree on http://git.secretlab.ca.  I've
just pushed it out to my tree so that those who are interested can
take a look at it.  But it is *not* complete.  Here's a non-exhaustive
list of known issues with it.

1. not ported to arch/powerpc
2. doesn't use the SPI infrastructure
3. I had to rip out some board specific code for manipulating SPI chip
selects (in order to release it)
4. Poor coding convention in places

It works quite well on one of my targets; but I was not able to
release that code as is; hence the broken driver.  I'll be working on
this code to get it into shape for inclusion into mainline.  Most of
the work will probably revolve around doing a proper SPI connection
and adapting the bestcomm code to whatever Sylvain has brewing in his
tree.  The move to arch/powerpc will also have a fair impact.

Cheers,
g.

--=20
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
