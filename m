To: "Young-Han, Kim" <yhkim@da-san.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC 8xx as SPI slave... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 26 Mar 2003 18:44:17 +0900."
             <000901c2f37c$44a2a800$337ceccb@dasan.com>
Date: Wed, 26 Mar 2003 12:02:10 +0100
Message-Id: <20030326110215.8C7ECC58BA@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Kim,

in message <000901c2f37c$44a2a800$337ceccb@dasan.com> you wrote:
>
>   Also, I was doubt the cache problem.
>   I'll  check again...
>   My code is based on your lwmon_spi.c just basic function.

Note that there is also a simple (and more  generic)  SPI  driver  in
cpm_spi.c

> > Does the 8xx transfer data at all? You know, SPI has a very, very low
> > priority onthe CPM, so it will be starved  by  any  other  I/O  (like
> > ethernet and especially USB).
>
>   Just transmit the previous data of TX BD not on time.
>   I'll check the priority...

Try reducing the SPI clock. You cannot change the priority of SPI  in
the  CPM  - it is implemented in software (microcode), and running at
the lowest priority. It is not useful for any  taks  which  needs  to
transfer large amounts of data quickly.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Those who do not  understand  Unix  are  condemned  to  reinvent  it,
poorly.              - Henry Spencer, University of Toronto Unix hack

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
