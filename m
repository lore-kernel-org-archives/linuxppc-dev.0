Return-Path: <bart.vanassche@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id CBBEDDDE0E
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 01:34:36 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so262737nfc
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 07:34:35 -0700 (PDT)
Message-ID: <e2e108260703160734o24550c4dp7bef0d7f33bcdcc5@mail.gmail.com>
Date: Fri, 16 Mar 2007 15:34:35 +0100
From: "Bart Van Assche" <bart.vanassche@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: +
	ocotea-board-ntpd-complains-that-the-frequency-error-exceeds-the-tolerance.patch
	added to -mm tree
In-Reply-To: <FD6A6842-530A-444B-A198-51947F3EAC20@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200703161052.l2GAqIRV009441@shell0.pdx.osdl.net>
	<FD6A6842-530A-444B-A198-51947F3EAC20@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org ML" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 3/16/07, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Mar 16, 2007, at 5:52 AM, akpm@linux-foundation.org wrote:
>
> >
> > The patch titled
> >      Ocotea board: ntpd complains that the frequency error exceeds
> > the tolerance
> > has been added to the -mm tree.  Its filename is
> >      ocotea-board-ntpd-complains-that-the-frequency-error-exceeds-
> > the-tolerance.patch
> >
> > *** Remember to use Documentation/SubmitChecklist when testing your
> > code ***
> >
> > See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt
> > to find
> > out what to do about this
> >
> > ------------------------------------------------------
> > Subject: Ocotea board: ntpd complains that the frequency error
> > exceeds the tolerance
> > From: Bart Van Assche <bart.vanassche@gmail.com>
> >
> > Lifted from http://bugzilla.kernel.org/show_bug.cgi?id=8182
> >
> > Steps to reproduce:
> > - Boot an Ocotea board with the mainline 2.6.20.1 kernel.
> > - Create an /etc/ntp.conf file with at least one NTP server and
> > iburst mode set.
> > - Issue the command "ntpd -g".
> > - Wait about two minutes.
> > - Verify ntpd's status via "ntpq -pn" and by looking in /var/log/ntp.
> >
> > Patch that fixes this problem:
> >
> > Cc: Kumar Gala <galak@gate.crashing.org>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >
> >  arch/ppc/platforms/4xx/ocotea.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff -puN arch/ppc/platforms/4xx/ocotea.c~ocotea-board-ntpd-
> > complains-that-the-frequency-error-exceeds-the-tolerance arch/ppc/
> > platforms/4xx/ocotea.c
> > --- a/arch/ppc/platforms/4xx/ocotea.c~ocotea-board-ntpd-complains-
> > that-the-frequency-error-exceeds-the-tolerance
> > +++ a/arch/ppc/platforms/4xx/ocotea.c
> > @@ -289,7 +289,7 @@ ocotea_setup_arch(void)
> >        * from FPGA, because it can be changed by on-board switches
> >        * --ebs
> >        */
> > -     ibm440gx_get_clocks(&clocks, 33333333, 6 * 1843200);
> > +     ibm440gx_get_clocks(&clocks, 33300000, 6 * 1843200);
> >       ocp_sys_info.opb_bus_freq = clocks.opb;
>
>   I asked Stefan & Josh to look at this and Stefan believes its a
> 33.33Mhz clock.  So should this really be 33330000?

I have measured the clock frequency on the two Ocotea boards I have on
my desk, and both have a clock crystal of 33.3 MHz, not 33.33 MHz.
What I don't know is whether the same clock crystal is mounted on all
Ocotea boards.

Regards,

Bart Van Assche.
