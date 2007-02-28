Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 02779DDE35
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 04:04:11 +1100 (EST)
Message-ID: <45E5B604.904@freescale.com>
Date: Wed, 28 Feb 2007 11:04:04 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: lanana: Add major/minor entries for PPC QE UART devices
References: <45E46976.6060600@freescale.com>
	<29c13109971547687159078eacdea008@kernel.crashing.org>
	<45E592DC.9060700@freescale.com>
	<511cacb7bbe8a65ff72738c84ec9ece4@kernel.crashing.org>
	<BD465924-7387-47EF-B90F-606F215819C2@embeddedalley.com>
In-Reply-To: <BD465924-7387-47EF-B90F-606F215819C2@embeddedalley.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Torben.Mathiasen@hp.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:

> I don't know the origin of this thread, but none of
> that looks correct.  Today, there can be up to 8
> CPM UART devices, 6 on CPM/CPM2 and 8
> on the QE.  If ttyCPM0 starts at minor 46, they
> should be at least monotonically incrementing
> up to ttyCPM7 with minor 53.

Minor nit: On the QE, they'll be called ttyQE0 through ttyQE7.

I agree that the CPM and the QE should share the same starting minor number, so that 
ttyCPM0 has the same major/minor number as ttyQE0, since it's not possible to have a CPM 
and a QE on the same device.  However, ttyCPM0 is currently assigned to 46, and device 50 
is an Altix serial card.  The only way to give the CPM 6 or 8 slots without moving it is 
to overlap the Altix card.

Now I don't know anything about the Altix card, so I don't know if it's possible to use 
that card on a system with a CPM or a QE.  If it isn't, then I don't know if overlapping 
minor numbers is still a problem.

(Note that the Altix card has a range of 50-81, which is pretty big.)

If we move CPM/QE to 192, then I can change the CPM device driver to reflect that, but I 
don't know what that means for older kernels.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
