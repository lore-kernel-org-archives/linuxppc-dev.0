To: Gabriel Paubert <paubert@iram.es>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Zidlicky <rz@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: set_rtc_time() cleanup / normalization 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 13 May 2003 12:21:45 +0200."
             <20030513102145.GA3997@iram.es>
Date: Tue, 13 May 2003 15:35:23 +0200
Message-Id: <20030513133528.4E5E0C6092@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20030513102145.GA3997@iram.es> Gabriel Paubert wrote:
>
> > > I certainly would like to know the details of this. I believe it may
> > > be fixing the symptom rather than the cause (an NTP bug).
> >
> > As far as I remember, NTP estimates the error of your RTC and uses that
> > estimation to correct your time if no NTP server is available, but the
> > estimation step fails if the kernel messes with the RTC behind NTP's back.
>
> In this case NTP should never clear the STA_UNSYNC flag shen it
> synchronized to the local clock (driver 127.127.0.0 IIRC) . The state
> change from 0x41 to 0x01 should never happen for the kernel side of
> the status flags, this would avoid creating the loop.


There are eventually two problems:

* Probably there is a problem in NTP.

  The conficuration where the problem was observed was one where  NTP
  was  used  with  a  "server  127.127.1.0"  setting  with  no  other
  synchronization source.

* set_rtc_time() should never be called from timer interrupt.

  Setting the RTC will in many cases involce  transactions  over  I2C
  which  (1)  are  awfully  slow  and (2) involve interrup processing
  themselfs so they cannot be used in interrupt context.


I think we should remove this code from the timer interrupt handler.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Living on Earth may be expensive, but it includes an annual free trip
around the Sun.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
