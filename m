Message-ID: <20020606130408.58860.qmail@web9502.mail.yahoo.com>
Date: Thu, 6 Jun 2002 06:04:08 -0700 (PDT)
From: Pete McCormick <pete261@yahoo.com>
Subject: Re: 8260 timer
To: "M?sz?ros_Lajos" <ludwigm@siemens.hu>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <37D0F88E70D96C428C19EEB865701A38E834F3@buda902a.siemens.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I had this problem before.  Make sure the frequency members of the bd_t
structure are in Hz, not MHz.

I made a change in M8260Setup.c:

void __init
platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
	      unsigned long r6, unsigned long r7)
{
	/* PEM : added */
	bd_t	*binfo;
	binfo = (bd_t *)__res;

	if ( r3 )
		memcpy( (void *)__res,(void *)(r3+KERNELBASE), sizeof(bd_t) );

	/* PEM : frequencies reported by ppcboot are in MHz, not Hz */
	/* Linux makes calculations assuming they are in Hz */
	binfo->bi_intfreq *= 1000000L;		/* Internal Freq, in MHz */
	binfo->bi_busfreq *= 1000000L;		/* Bus Freq, in MHz */
	binfo->bi_cpmfreq *= 1000000L;		/* CPM_CLK Freq, in MHz */
	binfo->bi_brgfreq *= 1000000L;		/* BRG_CLK Freq, in MHz */
	binfo->bi_sccfreq *= 1000000L;		/* SCC_CLK Freq, in MHz */
	binfo->bi_vco *= 1000000L;			/* VCO Out from PLL, in MHz */

Not sure if this is the correct place to do this, but it worked for me.  I
suppose you could also rebuild ppcboot, but I didn't feel like doing this.

Pete
--- Mészáros_Lajos <ludwigm@siemens.hu> wrote:
>
> Hi All!
>
> On our MPC8260ADS board the 2.4.18 kernel starts fine from PPCBoot, but
> after
> "Warning: real time clock seems stuck!"
>    message, (which seems true) stops on
> "Calibrating delay loop... "
>    message. (which proves the previous assumption)
>
> Where to find the initial settings of the 8260 timer?
> In the PPCBoot or in the kernel?
>
> Best Regards
> 	Ludwig
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
