Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 00CE5DDFEC
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 09:36:32 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so65308ywt.39
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 16:36:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <A88094362DE0AE49A118AB9B4EB3612403F9DEBC@dekaexchange.deka.local>
References: <A88094362DE0AE49A118AB9B4EB3612403F9DEB6@dekaexchange.deka.local>
	<20090519203645.GW19843@pengutronix.de>
	<20090519205706.GD27476@pengutronix.de>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBC@dekaexchange.deka.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 19 May 2009 17:36:11 -0600
Message-ID: <fa686aa40905191636u6f4a23d0xc8c6c13904a65b8e@mail.gmail.com>
Subject: Re: mpc5200 fec error
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 19, 2009 at 4:21 PM, Eric Millbrandt
<emillbrandt@dekaresearch.com> wrote:
> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Tuesday, May 19, 2009 16:57
> To: Robert Schwebel
> Cc: Eric Millbrandt; linuxppc-dev@ozlabs.org
> Subject: Re: mpc5200 fec error
>
> On Tue, May 19, 2009 at 10:36:45PM +0200, Robert Schwebel wrote:
>> Wolfram, have you seen this mail? You recently tested -rt on 2.6.29,
>> right? Did you only test that on the customer hardware or also on the
>> phyCORE-MPC5200B?
>
> So far, I tried only on customer hardware, and that was 2.6.29.2-rt11.
> With
> that setup, I could work with NFS flawlessly, no real stress-testing
> though.
> Testing latest .3-rt is on my todo, will check the phyCOREs, too.
>
> Regards,
>
> =A0 Wolfram
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | Wo=
lfram Sang
> |
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/
> |
>
> I am able to reproduce the error using 2.6.29.2-rt11. =A0I was able to
> mitigate the problem by raising the priority of the transmit irq.
> However when running an NFS server on the pcm030 under high cpu load I
> now get
>
> [ =A0132.477503] net eth0: FEC_IEVENT_RFIFO_ERROR
> [ =A0132.892329] net eth0: FEC_IEVENT_RFIFO_ERROR
> [ =A0133.884109] net eth0: FEC_IEVENT_RFIFO_ERROR
> [ =A0134.876059] net eth0: FEC_IEVENT_RFIFO_ERROR
>
> Raising the priority of the rx irq does not seem to fix this problem
> though.

Hi Eric,

This error has been seen before in non-rt kernels.  I haven't had the
chance to track it down and kill it yet.  I believe there are locking
issues associated with it.

g.

>
>
> _________________________________________________________________________=
________________
>
> This e-mail and the information, including any attachments, it contains a=
re intended to be a confidential communication only to the person or entity=
 to whom it is addressed and may contain information that is privileged. If=
 the reader of this message is not the intended recipient, you are hereby n=
otified that any dissemination, distribution or copying of this communicati=
on is strictly prohibited. If you have received this communication in error=
, please immediately notify the sender and destroy the original message.
>
> Thank you.
>
> Please consider the environment before printing this email.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
